import { WebSocketServer, WebSocket } from "ws";
import { log } from "./logger";

interface ExtendedWebSocket extends WebSocket {
  isAlive?: boolean;
  id?: string;
}

export function startHeartbeat(wss: WebSocketServer, intervalMs: number) {
  const interval = setInterval(() => {
    wss.clients.forEach((ws: ExtendedWebSocket) => {
      if (ws.isAlive === false) {
        log(`Terminating stale connection: ${ws.id}`);
        return ws.terminate();
      }
      ws.isAlive = false;
      ws.ping();
    });
  }, intervalMs);

  wss.on("close", () => clearInterval(interval));
}
