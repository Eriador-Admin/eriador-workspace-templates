import { WebSocketServer, WebSocket } from "ws";

interface ExtendedWebSocket extends WebSocket {
  id?: string;
}

class RoomManager {
  private rooms: Map<string, Set<string>> = new Map();

  join(room: string, clientId: string) {
    if (!this.rooms.has(room)) {
      this.rooms.set(room, new Set());
    }
    this.rooms.get(room)!.add(clientId);
  }

  leave(room: string, clientId: string) {
    const members = this.rooms.get(room);
    if (members) {
      members.delete(clientId);
      if (members.size === 0) {
        this.rooms.delete(room);
      }
    }
  }

  removeFromAll(clientId: string) {
    for (const [room, members] of this.rooms) {
      members.delete(clientId);
      if (members.size === 0) {
        this.rooms.delete(room);
      }
    }
  }

  getMembers(room: string): Set<string> {
    return this.rooms.get(room) || new Set();
  }

  broadcast(
    wss: WebSocketServer,
    room: string,
    payload: object,
    excludeId?: string
  ) {
    const members = this.getMembers(room);
    const data = JSON.stringify(payload);

    wss.clients.forEach((client: ExtendedWebSocket) => {
      if (
        client.readyState === WebSocket.OPEN &&
        members.has(client.id!) &&
        client.id !== excludeId
      ) {
        client.send(data);
      }
    });
  }
}

export const roomManager = new RoomManager();
