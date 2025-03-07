use anyhow::bail;
use comrak::{nodes::NodeValue, Arena};
use glob::glob;
use url::Url;

static EXCLUDED_HOSTS: phf::Set<&'static str> = phf::phf_set! {
    "crates.io", // Excluded because it always returns 200 OK when requesting HTML documents, and 404 for any other type
};

fn check_link(link: &str) -> anyhow::Result<()> {
    let url = Url::parse(link)?;
    if EXCLUDED_HOSTS.contains(url.host_str().unwrap_or_default()) {
        println!("⚠️ Skipping link to excluded host: {}", link);
        return Ok(());
    }

    let response = ureq::get(link).call()?;

    if !(200..=299).contains(&response.status()) {
        bail!(
            "❌ Link \"{}\" is broken (status code: {})",
            link,
            response.status()
        );
    }

    println!("✅ Link \"{link}\" is valid");

    Ok(())
}

fn main() -> anyhow::Result<()> {
    println!("🔎 Go Go Gadget Linkifier");

    let arena = Arena::new();
    let comrak_options = comrak::ComrakOptions::default();
    let md_files = glob("../src/**/*.md*")?;

    for entry in md_files {
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

    println!("🎉 All links are valid!");

    Ok(())
}
