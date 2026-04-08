import React from "react";
import { graphql } from "gatsby";
import type { HeadFC, PageProps } from "gatsby";
import Layout from "../components/Layout";
import Seo from "../components/Seo";

type DataProps = {
  mdx: {
    frontmatter: { title: string; date: string; description: string };
  };
};

const BlogPostTemplate: React.FC<PageProps<DataProps>> = ({ data, children }) => {
  const { frontmatter } = data.mdx;

  return (
    <Layout>
      <article>
        <h1>{frontmatter.title}</h1>
        <p style={{ color: "#666", fontSize: "0.875rem" }}>{frontmatter.date}</p>
        {children}
      </article>
    </Layout>
  );
};

export default BlogPostTemplate;

export const Head: HeadFC<DataProps> = ({ data }) => (
  <Seo title={data.mdx.frontmatter.title} description={data.mdx.frontmatter.description} />
);

export const query = graphql`
  query BlogPost($id: String!) {
    mdx(id: { eq: $id }) {
      frontmatter {
        title
        date(formatString: "MMMM DD, YYYY")
        description
      }
    }
  }
`;
