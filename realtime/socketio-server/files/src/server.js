require("dotenv").config();
const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const path = require("path");
const registerChatHandlers = require("./handlers/chat");
const registerConnectionHandlers = require("./handlers/connection");

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: { origin: "*" },
});

app.use(express.static(path.join(__dirname, "..", "public")));

io.on("connection", (socket) => {
  registerConnectionHandlers(io, socket);
  registerChatHandlers(io, socket);
});

const PORT = process.env.PORT || {{DEV_PORT}};
server.listen(PORT, () => {
  console.log(`🔌 {{PROJECT_NAME}} running on http://localhost:${PORT}`);
});
