import tagsObj from "@/utils/tags.json";
import Link from "next/link";

const className = "font-medium px-2 py-1 rounded-full text-xs";

export default function TagPill({ tag, onClick, checked }) {
  if (!tagsObj.allTags.includes(tag)) {
    return null;
  }

  const style = {
    backgroundColor: checked || !onClick ? tagsObj.colors[tag] : "transparent",
    border: `1px solid ${tagsObj.colors[tag]}`,
    color: checked || !onClick ? "white" : tagsObj.colors[tag],
  };

  return onClick ? (
    <button onClick={onClick} className={className} style={style}>
      {tag}
    </button>
  ) : (
    <Link href={`/tags?tag=${tag}`} className={className} style={style}>
      {tag}
    </Link>
  );
}
