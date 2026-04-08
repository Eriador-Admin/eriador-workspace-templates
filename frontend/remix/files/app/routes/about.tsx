import type { MetaFunction } from "@remix-run/node";
import { Link } from "@remix-run/react";

export const meta: MetaFunction = () => {
  return [{ title: "About — {{PROJECT_NAME}}" }];
};

export default function About() {
  return (
    <div style={{ fontFamily: "system-ui, sans-serif", padding: "2rem" }}>
      <h1>About</h1>
      <p>This is the about page for {{PROJECT_NAME}}.</p>
      <Link to="/">Back home</Link>
    </div>
  );
}
