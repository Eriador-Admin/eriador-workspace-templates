FROM node:20-alpine
WORKDIR /app
RUN echo '{"name":"web","private":true,"type":"module","scripts":{"start":"node server.js"}}' > package.json
RUN cat <<'EOF' > server.js
import http from "http";
const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ status: "ok", service: "web" }));
  } else {
    res.writeHead(200, { "Content-Type": "text/html" });
    res.end(`<h1>Web Service</h1><p>Hostname: ${process.env.HOSTNAME}</p>`);
  }
});
server.listen(3000, () => console.log("Web on :3000"));
EOF
EXPOSE 3000
CMD ["node", "server.js"]
