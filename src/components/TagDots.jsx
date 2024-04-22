import tagsObj from "@/utils/tags.json";

export default function TagDots({ route }) {
  const tags = tagsObj.routes?.[route];

  return tags?.length ? (
    <div className="nx-inline-flex nx-gap-1 tag-dots">
      {tags.map((t) => (
        <span
          className="nx-rounded-full"
          style={{
            backgroundColor: tagsObj.colors[t],
            width: "8px",
            height: "8px",
          }}
        ></span>
      ))}
    </div>
  ) : null;
}
