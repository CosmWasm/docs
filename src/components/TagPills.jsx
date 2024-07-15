import { useConfig } from "nextra-theme-docs";
import TagPill from "./TagPill";

export default function TagPills() {
  const { frontMatter } = useConfig();

  return frontMatter.tags?.length ? (
    <div className="my-4 flex flex-wrap gap-2">
      {frontMatter.tags.sort().map((tag) => (
        <TagPill key={tag} tag={tag} />
      ))}
    </div>
  ) : null;
}
