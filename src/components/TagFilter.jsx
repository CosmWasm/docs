import tagsObj from "@/utils/tags.json";
import { useRouter } from "next/router";
import { useSearchParams } from "next/navigation";
import TagPill from "./TagPill";

export default function TagFilter() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const urlTags = searchParams.getAll("tag");

  const routes = Object.entries(tagsObj.routes)
    .filter(
      ([, tags]) =>
        !urlTags.length || urlTags.find((urlTag) => tags.includes(urlTag)),
    )
    .map(([route]) => route)
    .sort();

  const minRouteDepth = Math.min(
    ...routes.map((route) => route.match(/\//gi).length),
  );

  const toggleTag = (selectedTag) => {
    let newTags = [];

    if (urlTags.includes(selectedTag)) {
      newTags = urlTags.filter((urlTag) => urlTag !== selectedTag).sort();
    } else {
      newTags = [...new Set([...urlTags, selectedTag])].sort();
    }

    router.push({ query: { ...router.query, tag: newTags } });
  };

  return (
    <>
      <p className="my-4">
        Select one or more tags to list its associated articles
      </p>
      <div className="my-4 flex flex-wrap gap-2">
        {tagsObj.allTags.map((tag) => (
          <TagPill
            key={tag}
            tag={tag}
            onClick={() => toggleTag(tag)}
            checked={urlTags.includes(tag)}
          />
        ))}
      </div>
      {routes.length ? (
        <div className="my-4 flex flex-col gap-2">
          {routes.map((route) => {
            const routeDepth = route.match(/\//gi).length - minRouteDepth;
            const file = route.split("/").slice(-1)[0] || "welcome";

            return (
              <a
                key={route}
                href={route}
                className="decoration self-start font-mono text-lg font-bold text-blue-500 hover:underline"
                style={{ marginLeft: routeDepth * 20 }}
              >
                {file}
              </a>
            );
          })}
        </div>
      ) : null}
    </>
  );
}
