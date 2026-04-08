import { WebSocketServer } from "ws";
import { handleConnection } from "./handlers/connection";
import { startHeartbeat } from "./utils/heartbeat";
import { log } from "./utils/logger";

const PORT = parseInt(process.env.PORT || "8080", 10);

const wss = new WebSocketServer({ port: PORT });

log(`{{PROJECT_NAME}} WebSocket server starting on ws://localhost:${PORT}`);

wss.on("connection", (ws, req) => {
  handleConnection(wss, ws, req);
});

startHeartbeat(wss, 30000);

process.on("SIGINT", () => {
  log("Shutting down...");
  wss.close(() => process.exit(0));
});
