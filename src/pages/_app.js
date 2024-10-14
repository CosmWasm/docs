import DocShortcut from "@/components/DocShortcut";
import { TooltipProvider } from "@/components/ui/tooltip";
import "./global.css";

export default function App({ Component, pageProps }) {
  return (
    <>
      <DocShortcut />
      <TooltipProvider delayDuration={0}>
        <Component {...pageProps} />
      </TooltipProvider>
    </>
  );
}
