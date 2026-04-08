FROM node:20-alpine
WORKDIR /app
RUN echo '{"name":"api","private":true,"type":"module","scripts":{"start":"node server.js"}}' > package.json
RUN cat <<'EOF' > server.js
import http from "http";
const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ status: "ok", service: "api" }));
  } else {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ message: "Hello from API service", hostname: process.env.HOSTNAME }));
  }
});
server.listen(3000, () => console.log("API on :3000"));
EOF
EXPOSE 3000
CMD ["node", "server.js"]
