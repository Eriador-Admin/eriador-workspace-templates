export default function Home() {
  return (
    <main style={{ padding: "2rem", fontFamily: "system-ui, sans-serif" }}>
      <h1>{{PROJECT_NAME}}</h1>
      <p>Vercel Edge Functions demo. Try the API endpoints:</p>
      <ul>
        <li><a href="/api/hello">/api/hello</a> — JSON response from edge</li>
        <li><a href="/api/geo">/api/geo</a> — Geolocation data</li>
        <li><a href="/api/rewrite">/api/rewrite</a> — Conditional rewrite</li>
      </ul>
    </main>
  );
}
