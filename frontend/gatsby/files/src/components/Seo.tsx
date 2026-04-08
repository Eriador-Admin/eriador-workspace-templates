import React from "react";
import { useStaticQuery, graphql } from "gatsby";

type SeoProps = {
  title: string;
  description?: string;
};

const Seo: React.FC<SeoProps> = ({ title, description }) => {
  const data = useStaticQuery(graphql`
    query SeoQuery {
      site {
        siteMetadata {
          title
          description
        }
      }
    }
  `);

  const metaDescription = description || data.site.siteMetadata.description;
  const defaultTitle = data.site.siteMetadata.title;

  return (
    <>
      <title>{title ? `${title} | ${defaultTitle}` : defaultTitle}</title>
      <meta name="description" content={metaDescription} />
    </>
  );
};

export default Seo;
