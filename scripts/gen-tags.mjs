import { promises as fs } from "fs";
import matter from "gray-matter";

(async function genTags() {
  console.info("Generating tags…");

  const pagesDir = "src/pages";
  const wholeDir = await fs.readdir(pagesDir, { recursive: true });

  const files = wholeDir
    .filter((file) => !file.startsWith("_") && file.endsWith(".mdx"))
    .map((file) => "/" + file);

  const tagsObj = { routes: {}, allTags: [], colors: {} };
  const tagsArr = [];

  // Tags per sidebar route
  const fillTagsPromises = files.map(async (filename) => {
    const content = await fs.readFile(pagesDir + filename);
    const { data } = matter(content);

    let route = filename.endsWith("index.mdx")
      ? filename.slice(0, -1 * "index.mdx".length)
      : filename.slice(0, -1 * ".mdx".length);

    route = route.endsWith("/") ? route.slice(0, -1) || "/" : route;

    tagsObj.routes[route] = data.tags;
    tagsArr.push(...data.tags);
  });

  await Promise.all(fillTagsPromises);

  // Build allTags array with unique tags
  tagsObj.allTags = [...new Set(tagsArr)].sort();

  // Color per tag

  const srcColors = [
    "#dc2626",
    "#d97706",
    "#65a30d",
    "#059669",
    "#0891b2",
    "#2563eb",
    "#7c3aed",
    "#c026d3",
  ];

  for (const [index, tag] of tagsObj.allTags.entries()) {
    tagsObj.colors[tag] = srcColors[index % srcColors.length];
  }

  await fs.writeFile("./src/utils/tags.json", JSON.stringify(tagsObj));
  console.info(
    "Tags successfully generated and written to src/utils/tags.json",
  );
})();
