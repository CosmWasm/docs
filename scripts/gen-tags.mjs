import { promises as fs } from "fs";
import matter from "gray-matter";

const pagesDir = "src/pages/";
const srcTagColors = [
  "#dc2626",
  "#d97706",
  "#65a30d",
  "#059669",
  "#0891b2",
  "#2563eb",
  "#7c3aed",
  "#c026d3",
];

(async function genTags() {
  console.info("Generating tags…");

  const tagsObj = { routes: {}, allTags: [], colors: {} };
  const files = await getFiles();
  const fillTagsPromises = files.map((filepath) => fillTags(tagsObj, filepath));

  // Fill tagsObj with tags from all files
  await Promise.all(fillTagsPromises);

  // Build allTags array with unique tags
  tagsObj.allTags = [...new Set(tagsObj.allTags)].sort();

  fillTagColors(tagsObj);

  await fs.writeFile("src/utils/tags.json", JSON.stringify(tagsObj));

  console.info("Tags written to src/utils/tags.json");
})();

async function getFiles() {
  const wholeDir = await fs.readdir(pagesDir, { recursive: true });

  const files = wholeDir.filter(
    (file) =>
      (file.endsWith(".md") || file.endsWith(".mdx")) && file !== "_app.mdx",
  );

  return files;
}

async function fillTags(tagsObj, filepath) {
  const route = getRoute(filepath);
  const tags = await getTags(filepath);

  tagsObj.routes[route] = tags;
  tagsObj.allTags.push(...tags);
}

function getRoute(filepath) {
  const extension = "." + filepath.split(".")[1];

  const numCharsToRemove = filepath.endsWith(`index${extension}`)
    ? `index${extension}`.length
    : extension.length;

  let route = filepath.slice(0, -1 * numCharsToRemove);
  route = route.endsWith("/") ? route.slice(0, -1) || "/" : route;
  route = "/" + route;

  return route;
}

async function getTags(filepath) {
  const content = await fs.readFile(pagesDir + filepath);
  const { data } = matter(content);

  let tags = data.tags || [];
  tags = Array.isArray(tags) ? tags : [tags];
  tags = tags.map((tag) => String(tag));

  return tags;
}

function fillTagColors(tagsObj) {
  for (const [index, tag] of tagsObj.allTags.entries()) {
    tagsObj.colors[tag] = srcTagColors[index % srcTagColors.length];
  }
}
