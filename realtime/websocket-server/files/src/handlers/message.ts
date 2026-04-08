import { WebSocketServer, WebSocket, RawData } from "ws";
import { roomManager } from "../rooms/room-manager";
import { log } from "../utils/logger";

interface ExtendedWebSocket extends WebSocket {
  id?: string;
}

interface WsMessage {
  type: string;
  room?: string;
  data?: string;
}

export function handleMessage(
  wss: WebSocketServer,
  ws: ExtendedWebSocket,
  raw: RawData
) {
  let msg: WsMessage;
  try {
    msg = JSON.parse(raw.toString());
  } catch {
    ws.send(JSON.stringify({ type: "error", message: "Invalid JSON" }));
    return;
  }

  switch (msg.type) {
    case "join":
      if (!msg.room) {
        ws.send(JSON.stringify({ type: "error", message: "Room required" }));
        return;
      }
      roomManager.join(msg.room, ws.id!);
      ws.send(JSON.stringify({ type: "joined", room: msg.room }));
      roomManager.broadcast(wss, msg.room, {
        type: "system",
        room: msg.room,
        data: `${ws.id} joined`,
      }, ws.id);
      log(`${ws.id} joined room: ${msg.room}`);
      break;

    case "leave":
      if (!msg.room) return;
      roomManager.leave(msg.room, ws.id!);
      ws.send(JSON.stringify({ type: "left", room: msg.room }));
      roomManager.broadcast(wss, msg.room, {
        type: "system",
        room: msg.room,
        data: `${ws.id} left`,
      });
      log(`${ws.id} left room: ${msg.room}`);
      break;

    case "message":
      if (!msg.room || !msg.data) {
        ws.send(JSON.stringify({ type: "error", message: "Room and data required" }));
        return;
      }
      roomManager.broadcast(wss, msg.room, {
        type: "message",
        room: msg.room,
        sender: ws.id,
        data: msg.data,
      });
      break;

    default:
      ws.send(JSON.stringify({ type: "error", message: `Unknown type: ${msg.type}` }));
  }
}
