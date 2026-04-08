FROM node:20-alpine
WORKDIR /app
RUN cat <<'EOF' > server.js
const http = require("http");
const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ status: "ok" }));
    return;
  }
  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(JSON.stringify({
    message: "Hello from API",
    hostname: process.env.HOSTNAME,
    timestamp: new Date().toISOString()
  }));
});
server.listen(3000, () => console.log("API listening on :3000"));
EOF
EXPOSE 3000
HEALTHCHECK --interval=10s --timeout=3s CMD wget -qO- http://localhost:3000/health || exit 1
CMD ["node", "server.js"]
