use anyhow::bail;
use comrak::{nodes::NodeValue, Arena};
use glob::glob;

fn check_link(link: &str) -> anyhow::Result<()> {
    let response = ureq::get(link).call()?;

    if !(200..=299).contains(&response.status()) {
        bail!("❌ Link \"{link}\" is broken (status code: {})", response.status());
    }

    Ok(())
}

fn main() -> anyhow::Result<()> {
    println!("🔎 Go Go Gadget Linkifier");

    let arena = Arena::new();
    let comrak_options = comrak::ComrakOptions::default();
    let mdx_files = glob("../src/**/*.mdx")?;

    for entry in mdx_files {
        let path = entry?;
        println!("📄 Checking file \"{}\"..", path.display());

        let content = std::fs::read_to_string(&path)?;
        // Parse the content with comrak and iterate over its link nodes
        let doc = comrak::parse_document(&arena, &content, &comrak_options);
        for node in doc.descendants() {
            match &node.data.borrow().value {
                NodeValue::Link(link) => {
                    let url = &link.url;
                    if url.starts_with("http") {
                        println!("🔗 Found external link: {}", url);
                        check_link(url)?;
                    }
                }
                NodeValue::Image(link) => {
                    let url = &link.url;
                    if url.starts_with("http") {
                        println!("🔗 Found external image: {}", url);
                        check_link(url)?;
                    }
                }
                _ => {}
            }
        }
    }

    println!("✅ All links are valid!");

    Ok(())
}
