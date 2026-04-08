FROM node:20-alpine
WORKDIR /app
RUN cat <<'EOF' > server.js
const http = require("http");
const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ status: "ok", service: "web" }));
    return;
  }
  res.writeHead(200, { "Content-Type": "text/html" });
  res.end(`<!DOCTYPE html>
<html><head><title>Web Service</title></head>
<body>
  <h1>Web Service</h1>
  <p>Hostname: ${process.env.HOSTNAME}</p>
  <p>Path: ${req.url}</p>
  <p><a href="/api/">API endpoint</a></p>
</body></html>`);
});
server.listen(3000, () => console.log("Web on :3000"));
EOF
EXPOSE 3000
HEALTHCHECK --interval=5s --timeout=2s CMD wget -qO- http://localhost:3000/health || exit 1
CMD ["node", "server.js"]
