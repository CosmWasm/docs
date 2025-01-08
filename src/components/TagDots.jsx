import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip";
import tagsObj from "@/utils/tags.json";
import * as TooltipPrimitive from "@radix-ui/react-tooltip";
import Link from "next/link";

export default function TagDots({ route }) {
  const tags = tagsObj.routes?.[route];

  return tags?.length ? (
    <div className="inline-flex gap-1">
      {tags.map((tag) => (
        <Tooltip key={tag}>
          <TooltipTrigger>
            <span
              className="-mr-4 block h-2 w-2 rounded-full transition-spacing group-hover:mr-0"
              style={{ backgroundColor: tagsObj.colors[tag] }}
            ></span>
          </TooltipTrigger>
          <TooltipPrimitive.Portal>
            <TooltipContent style={{ backgroundColor: tagsObj.colors[tag] }}>
              <Link href={`/tags?tag=${tag}`}>
                <p>{tag}</p>
              </Link>
            </TooltipContent>
          </TooltipPrimitive.Portal>
        </Tooltip>
      ))}
    </div>
  ) : null;
}
