import path from "path";
import type { GatsbyNode } from "gatsby";

export const createPages: GatsbyNode["createPages"] = async ({ graphql, actions }) => {
  const { createPage } = actions;

  const result = await graphql<{
    allMdx: { nodes: Array<{ id: string; frontmatter: { title: string }; internal: { contentFilePath: string } }> };
  }>(`
    query {
      allMdx(sort: { frontmatter: { date: DESC } }) {
        nodes {
          id
          frontmatter {
            title
          }
          internal {
            contentFilePath
          }
        }
      }
    }
  `);

  if (result.errors || !result.data) {
    throw new Error("Error querying MDX posts");
  }

  const blogPostTemplate = path.resolve("src/templates/blog-post.tsx");

  result.data.allMdx.nodes.forEach((node) => {
    const slug = path.basename(node.internal.contentFilePath, path.extname(node.internal.contentFilePath));
    createPage({
      path: `/blog/${slug}`,
      component: `${blogPostTemplate}?__contentFilePath=${node.internal.contentFilePath}`,
      context: { id: node.id },
    });
  });
};
