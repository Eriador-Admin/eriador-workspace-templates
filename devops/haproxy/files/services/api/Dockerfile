FROM node:20-alpine
WORKDIR /app
RUN cat <<'EOF' > server.js
const http = require("http");
const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ status: "ok", service: "api" }));
    return;
  }
  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(JSON.stringify({
    service: "api",
    hostname: process.env.HOSTNAME,
    path: req.url,
    timestamp: new Date().toISOString()
  }));
});
server.listen(3000, () => console.log("API on :3000"));
EOF
EXPOSE 3000
HEALTHCHECK --interval=5s --timeout=2s CMD wget -qO- http://localhost:3000/health || exit 1
CMD ["node", "server.js"]
