import { useEffect, useRef } from "react";

export default function DocTitle() {
  const titleRef = useRef(null);

  useEffect(() => {
    if (!titleRef.current) {
      return;
    }

    const isDocRoute = window.location.pathname.startsWith("/how-to-doc");
    const parent = titleRef.current.parentNode;
    const grandparent = parent.parentNode;

    // Hide sidebar menu option
    if (!isDocRoute && parent.tagName === "A" && grandparent.tagName === "LI") {
      grandparent.classList.add("hidden");
    }

    // Hide nextLink on the page before "How to doc"
    if (!isDocRoute && parent.tagName === "A" && grandparent.tagName === "DIV") {
      parent.classList.add("hidden");
    }
  }, []);

  return <span ref={titleRef}>How to doc</span>;
}
