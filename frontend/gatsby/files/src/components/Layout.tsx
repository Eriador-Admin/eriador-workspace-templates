import React from "react";

const Layout: React.FC<{ children: React.ReactNode }> = ({ children }) => (
  <div style={{ maxWidth: 720, margin: "0 auto", padding: "2rem 1rem" }}>
    <header style={{ marginBottom: "2rem", borderBottom: "1px solid #eee", paddingBottom: "1rem" }}>
      <a href="/" style={{ textDecoration: "none", color: "inherit" }}>
        <strong>{{PROJECT_NAME}}</strong>
      </a>
    </header>
    <main>{children}</main>
    <footer style={{ marginTop: "3rem", borderTop: "1px solid #eee", paddingTop: "1rem", fontSize: "0.875rem", color: "#666" }}>
      Built with Gatsby
    </footer>
  </div>
);

export default Layout;
