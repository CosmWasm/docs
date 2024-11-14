use anyhow::{anyhow, Result};
use comrak::nodes::{NodeCodeBlock, NodeValue};
use glob::glob;
use phf::phf_map;
use std::{fs, path::Path};
use strum::{AsRefStr, EnumIter, IntoEnumIterator};

static TEMPLATES: phf::Map<&'static str, &'static str> = phf_map! {
    "core" => include_str!("../templates/core.tpl"),
    "execute" => include_str!("../templates/execute.tpl"),
    "instantiate-spec" => include_str!("../templates/instantiate-spec.tpl"),
    "ibc-channel" => include_str!("../templates/ibc-channel.tpl"),
    "ibc-packet" => include_str!("../templates/ibc-packet.tpl"),
    "storage" => include_str!("../templates/storage.tpl"),
    "sylvia-storey-contract" => include_str!("../templates/sylvia/storey_contract.tpl"),
    "sylvia-cw-storage-contract" => include_str!("../templates/sylvia/cw_storage_contract.tpl"),
    "sylvia-empty" => include_str!("../templates/sylvia/empty.tpl"),
    "empty" => include_str!("../templates/empty.tpl"),
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
    fn file_ext(&self) -> &'static str {
        match self {
            Self::Go => "go",
            Self::Rust => "rs",
        }
    }

    fn test_dir(&self) -> &'static str {
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

    let arena = comrak::Arena::new();
    let ast = comrak::parse_document(&arena, &src, &comrak::Options::default());

    let mut blocks = Vec::new();
    for node in ast.descendants() {
        let node = &node.data.borrow().value;

        if let NodeValue::CodeBlock(NodeCodeBlock {
            fenced: true,
            info,
            literal,
            ..
        }) = node
        {
            let Some(language) = find_language(info) else {
                continue;
            };

            if let Some(template_name) = get_template_name(info) {
                blocks.push(CodeBlock {
                    language,
                    template: template_name.to_string(),
                    code: literal.clone(),
                });
            }
        }
    }

    for (idx, block) in blocks.iter().enumerate() {
        let mdx_path = path
            .to_str()
            .ok_or_else(|| {
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
