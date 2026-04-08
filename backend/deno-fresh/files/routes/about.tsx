import Header from "../components/Header.tsx";

export default function About() {
  return (
    <div>
      <Header />
      <div class="container">
        <h1>About</h1>
        <p>
          This is a demo Fresh application showing server-side rendering with
          selective client-side hydration via islands.
        </p>
        <p>
          Only the Counter component ships JavaScript to the client.
          Everything else is pure HTML.
        </p>
        <p><a href="/">Back to home</a></p>
      </div>
    </div>
  );
}
