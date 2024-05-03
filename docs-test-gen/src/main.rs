use anyhow::Result;
use glob::glob;
use phf::phf_map;
use pulldown_cmark::{CodeBlockKind, Event, Tag, TagEnd};
use std::fs;
use strum::{EnumIter, IntoEnumIterator};

static TEMPLATES: phf::Map<&'static str, &'static str> = phf_map! {
    "core" => include_str!("../templates/core.tpl"),
    "execute" => include_str!("../templates/execute.tpl"),
};

fn is_goey(fence: &str) -> bool {
    fence.split_whitespace().any(|item| item.trim() == "go")
}

fn is_rusty(fence: &str) -> bool {
    fence.split_whitespace().any(|item| item.trim() == "rust")
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

#[derive(Clone, Copy, Debug, EnumIter)]
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

fn main() -> Result<()> {
    let mdx_files = glob("../src/**/*.mdx").unwrap();

    for language in Language::iter() {
        fs::create_dir_all(language.test_dir())?;
    }

    for path in mdx_files {
        let path = path?;

        let src = fs::read_to_string(&path)?;
        let parser = pulldown_cmark::Parser::new(&src);

        let mut is_aggregating = false;

        let mut language = Language::Rust;
        let mut template = String::new();
        let mut agg = String::new();
        let mut blocks = Vec::new();

        for event in parser {
            if is_aggregating {
                if let Event::Text(ref text) = event {
                    agg.push_str(&text);
                }
            }

            match event {
                Event::Start(Tag::CodeBlock(CodeBlockKind::Fenced(fence))) => {
                    if is_rusty(&fence) {
                        language = Language::Rust;
                    } else if is_goey(&fence) {
                        language = Language::Go;
                    } else {
                        continue;
                    }

                    if let Some(template_name) = get_template_name(&fence) {
                        is_aggregating = true;
                        template = template_name.to_string();
                    }
                }
                Event::End(TagEnd::CodeBlock) if is_aggregating => {
                    is_aggregating = false;

                    blocks.push(CodeBlock {
                        template: template.clone(),
                        code: agg.clone(),
                        language,
                    });

                    template.clear();
                    agg.clear();
                }
                _ => (),
            }
        }

        if blocks.is_empty() {
            continue;
        }

        for (idx, block) in blocks.iter().enumerate() {
            // Actually write the tests into files or smth. Please kill me.

            let mdx_filename = path.file_name().unwrap().to_str().unwrap();
            let filename = format!(
                "{}_{}_{}.{}",
                mdx_filename.replace(".", "_"),
                block.template,
                idx,
                block.language.file_ext(),
            );
            let path = format!("{}/{filename}", block.language.test_dir());

            let template = TEMPLATES.get(&block.template).unwrap();
            let code = template.replace("{{code}}", &block.code);

            fs::write(path, code)?;
        }
    }

    Ok(())
}
