export default function Header() {
  return (
    <header
      style={{
        padding: "1rem 2rem",
        borderBottom: "1px solid #eee",
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center",
      }}
    >
      <a href="/" style={{ textDecoration: "none", color: "inherit", fontWeight: "bold" }}>
        {{PROJECT_NAME}}
      </a>
      <nav style={{ display: "flex", gap: "1rem" }}>
        <a href="/">Home</a>
        <a href="/about">About</a>
      </nav>
    </header>
  );
}
