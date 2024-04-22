import tagsObj from "@/utils/tags.json";
import { useConfig } from "nextra-theme-docs";

export default function Tags() {
  const { frontMatter } = useConfig();

  return frontMatter.tags?.length ? (
    <div className="nx-my-4 nx-flex nx-flex-wrap nx-gap-2">
      {frontMatter.tags.map((tag) => (
        <span
          key={tag}
          className="nx-font-medium nx-px-2 nx-py-1 nx-rounded-full nx-text-xs"
          style={{ backgroundColor: tagsObj.colors[tag], color: "white" }}
        >
          {tag}
        </span>
      ))}
    </div>
  ) : null;
}
