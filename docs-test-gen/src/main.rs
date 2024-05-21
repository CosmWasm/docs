use anyhow::{anyhow, Result};
use glob::glob;
use phf::phf_map;
use pulldown_cmark::{CodeBlockKind, Event, Tag, TagEnd};
use std::{fs, path::Path};
use strum::{AsRefStr, EnumIter, IntoEnumIterator};

static TEMPLATES: phf::Map<&'static str, &'static str> = phf_map! {
    "core" => include_str!("../templates/core.tpl"),
    "execute" => include_str!("../templates/execute.tpl"),
};

#[inline]
fn find_language(fence: &str) -> Option<Language> {
    fence.split_whitespace().find_map(|item| {
        Language::iter().find(|language| language.as_ref().eq_ignore_ascii_case(item))
    })
}

fn get_template_name(fence: &str) -> Option<&str> {
    let fence_iter = fence.split_whitespace();
    for item in fence_iter {
        let Some((key, value)) = item.split_once('=') else {
            continue;
        };

        if key == "template" {
            return Some(value.trim_matches('"'));
        }
    }

    None
}

#[derive(AsRefStr, Clone, Copy, Debug, EnumIter)]
#[strum(serialize_all = "lowercase")]
enum Language {
    Go,
    Rust,
}

impl Language {
    fn file_ext(&self) -> &str {
        match self {
            Self::Go => "go",
            Self::Rust => "rs",
        }
    }

    fn test_dir(&self) -> &str {
        match self {
            Self::Go => "go_tests",
            Self::Rust => "tests",
        }
    }
}

#[derive(Debug)]
struct CodeBlock {
    language: Language,
    template: String,
    code: String,
}

fn process_file(path: &Path) -> Result<()> {
    let src = fs::read_to_string(path)?;
    let parser = pulldown_cmark::Parser::new(&src);

    let mut is_aggregating = false;

    let mut language = Language::Rust;
    let mut template = String::new();
    let mut code = String::new();
    let mut blocks = Vec::new();

    for event in parser {
        if is_aggregating {
            if let Event::Text(ref text) = event {
                code.push_str(text);
            }
        }

        match event {
            Event::Start(Tag::CodeBlock(CodeBlockKind::Fenced(fence))) => {
                language = match find_language(&fence) {
                    Some(found_lang) => found_lang,
                    None => continue,
                };

                if let Some(template_name) = get_template_name(&fence) {
                    is_aggregating = true;
                    template = template_name.to_string();
                }
            }
            Event::End(TagEnd::CodeBlock) if is_aggregating => {
                is_aggregating = false;

                blocks.push(CodeBlock {
                    template: template.clone(),
                    code: code.clone(),
                    language,
                });

                template.clear();
                code.clear();
            }
            _ => (),
        }
    }

    for (idx, block) in blocks.iter().enumerate() {
        let mdx_path = path.to_str().ok_or_else(|| {
            anyhow!(
                "filename of path \"{}\" isn't valid utf-8. (really?! in the 21st century?)",
                path.display()
            )
        })?
        .replace("../", "")
        .replace('/', "_");

        let filename = format!(
            "{}_{}.{}",
            mdx_path.replace('.', "_"),
            idx,
            block.language.file_ext(),
        );
        let path = format!("{}/{filename}", block.language.test_dir());

        let template = TEMPLATES
            .get(&block.template)
            .ok_or_else(|| anyhow!("template \"{}\" not found", block.template))?;
        let code = template.replace("{{code}}", &block.code);

        fs::write(path, code)?;
    }

    Ok(())
}

fn main() -> Result<()> {
    let mdx_files = glob("../src/**/*.mdx")?;

    for language in Language::iter() {
        fs::create_dir_all(language.test_dir())?;
    }

    for path in mdx_files {
        let path = path?;
        process_file(&path)?;
    }

    Ok(())
}
