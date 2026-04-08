import React from "react";
import type { HeadFC, PageProps } from "gatsby";
import { graphql, Link } from "gatsby";
import Layout from "../components/Layout";
import Seo from "../components/Seo";

type DataProps = {
  allMdx: {
    nodes: Array<{
      id: string;
      frontmatter: { title: string; date: string; description: string };
      internal: { contentFilePath: string };
    }>;
  };
};

const IndexPage: React.FC<PageProps<DataProps>> = ({ data }) => {
  const posts = data.allMdx.nodes;

  return (
    <Layout>
      <h1>Welcome to {{PROJECT_NAME}}</h1>
      <p>A Gatsby site with TypeScript and MDX.</p>
      <h2>Recent Posts</h2>
      <ul>
        {posts.map((post) => {
          const slug = post.internal.contentFilePath.split("/").pop()?.replace(/\.mdx?$/, "");
          return (
            <li key={post.id}>
              <Link to={`/blog/${slug}`}>
                <strong>{post.frontmatter.title}</strong>
              </Link>
              <br />
              <small>{post.frontmatter.date}</small>
              <p>{post.frontmatter.description}</p>
            </li>
          );
        })}
      </ul>
    </Layout>
  );
};

export default IndexPage;

export const Head: HeadFC = () => <Seo title="Home" />;

export const query = graphql`
  query IndexPage {
    allMdx(sort: { frontmatter: { date: DESC } }, limit: 5) {
      nodes {
        id
        frontmatter {
          title
          date(formatString: "MMMM DD, YYYY")
          description
        }
        internal {
          contentFilePath
        }
      }
    }
  }
`;
