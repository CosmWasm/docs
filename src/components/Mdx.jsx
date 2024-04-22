import { evaluateSync } from "@mdx-js/mdx";
import * as provider from "@mdx-js/react";
import { useMDXComponents } from "nextra/mdx";
import * as runtime from "react/jsx-runtime";

export default function Mdx({ children }) {
  const { default: MdxContent } = evaluateSync(children, {
    ...runtime,
    ...provider,
    useMDXComponents,
    format: "mdx",
    development: false,
  });

  return <MdxContent />;
}
