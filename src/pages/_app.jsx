import { useCallback, useEffect } from "react";
import "./global.css";

export default function App({ Component, pageProps }) {
  const goToDocs = useCallback((event) => {
    if (event.ctrlKey && event.key === ".") {
      window.location.href = "/how-to-doc";
      event.preventDefault();
    }
  }, []);

  useEffect(() => {
    window.addEventListener("keyup", goToDocs);
    return () => {
      window.removeEventListener("keyup", goToDocs);
    };
  }, [goToDocs]);

  return <Component {...pageProps} />;
}
