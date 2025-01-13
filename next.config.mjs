import nextra from "nextra";

const withNextra = nextra({
  theme: "nextra-theme-docs",
  themeConfig: "./src/theme.config.jsx",
  latex: true,
  search: {
    codeblocks: false,
  },
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
