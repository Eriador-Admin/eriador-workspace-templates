import { Link } from "react-router";
import type { Route } from "./+types/about";

export const meta: Route.MetaFunction = () => {
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
