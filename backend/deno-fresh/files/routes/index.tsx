import { type PageProps } from "$fresh/server.ts";
import Counter from "../islands/Counter.tsx";
import Header from "../components/Header.tsx";

export default function Home(_props: PageProps) {
  return (
    <div>
      <Header />
      <div class="container">
        <h1>Welcome to {{PROJECT_NAME}}</h1>
        <p>This is a <a href="https://fresh.deno.dev/">Fresh</a> project with islands architecture.</p>
        <h2>Interactive Island</h2>
        <Counter start={0} />
        <h2>API Routes</h2>
        <ul>
          <li><a href="/api/joke">Random Joke</a></li>
          <li><a href="/api/greet/World">Greet API</a></li>
        </ul>
        <p><a href="/about">About</a></p>
      </div>
    </div>
  );
}
