import nextra from "nextra";

const withNextra = nextra({
  theme: "nextra-theme-docs",
  themeConfig: "./src/theme.config.js",
  latex: true,
});

export default withNextra({
  reactStrictMode: true,
  async redirects() {
    return [
      {
        source: "/docs",
        destination: "/",
        permanent: true,
      },
      {
        source: "/docs/:p*",
        destination: "/",
        permanent: true,
      },
    ];
  },
});
