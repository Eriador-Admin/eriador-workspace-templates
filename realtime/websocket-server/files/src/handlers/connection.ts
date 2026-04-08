import { WebSocketServer, WebSocket } from "ws";
import { IncomingMessage } from "http";
import { handleMessage } from "./message";
import { roomManager } from "../rooms/room-manager";
import { log } from "../utils/logger";
import crypto from "crypto";

interface ExtendedWebSocket extends WebSocket {
  id?: string;
  isAlive?: boolean;
}

export function handleConnection(
  wss: WebSocketServer,
  ws: ExtendedWebSocket,
  req: IncomingMessage
) {
  ws.id = crypto.randomUUID();
  ws.isAlive = true;

  log(`Client connected: ${ws.id} from ${req.socket.remoteAddress}`);

  ws.send(
    JSON.stringify({ type: "connected", id: ws.id, message: "Welcome!" })
  );

  ws.on("pong", () => {
    ws.isAlive = true;
  });

  ws.on("message", (raw) => {
    handleMessage(wss, ws, raw);
  });

  ws.on("close", (code, reason) => {
    log(`Client disconnected: ${ws.id} (code: ${code})`);
    roomManager.removeFromAll(ws.id!);
  });

  ws.on("error", (err) => {
    log(`Client error: ${ws.id} — ${err.message}`);
  });
}
