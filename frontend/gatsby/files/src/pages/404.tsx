import React from "react";
import type { HeadFC } from "gatsby";
import Layout from "../components/Layout";
import Seo from "../components/Seo";
import { Link } from "gatsby";

const NotFoundPage: React.FC = () => (
  <Layout>
    <h1>404: Not Found</h1>
    <p>The page you're looking for doesn't exist.</p>
    <Link to="/">Go home</Link>
  </Layout>
);

export default NotFoundPage;

export const Head: HeadFC = () => <Seo title="404: Not Found" />;
