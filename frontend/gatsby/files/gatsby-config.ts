import type { GatsbyConfig } from "gatsby";

const config: GatsbyConfig = {
  siteMetadata: {
    title: "{{PROJECT_NAME}}",
    description: "A Gatsby site built with TypeScript and MDX",
    siteUrl: process.env.GATSBY_SITE_URL || "http://localhost:8000",
  },
  plugins: [
    {
      resolve: "gatsby-source-filesystem",
      options: {
        name: "blog",
        path: `${__dirname}/content/blog`,
      },
    },
    {
      resolve: "gatsby-plugin-mdx",
      options: {
        extensions: [".mdx", ".md"],
      },
    },
  ],
};

export default config;
