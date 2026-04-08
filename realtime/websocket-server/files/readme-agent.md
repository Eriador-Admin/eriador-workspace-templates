# Agent Instructions — {{PROJECT_NAME}}

This is a raw WebSocket server using the ws library in TypeScript.

## Tech Stack
- **Language**: TypeScript
- **Library**: ws 8.x
- **Runtime**: Node.js 18+

## Key Conventions
- Server in `src/server.ts` — creates `WebSocketServer` on a port
- Message protocol: JSON with `type` field for routing
- Rooms managed in `src/rooms/room-manager.ts` — Map of room name → Set of clients
- Heartbeat in `src/utils/heartbeat.ts` — ping/pong interval to detect dead connections
- Each client gets a unique `id` property attached to the WebSocket instance
- Use `ws.send(JSON.stringify(payload))` to send, `ws.on('message', ...)` to receive
- Broadcast: iterate room members and call `client.send()` on each
- Close codes: 1000 (normal), 1001 (going away), 1006 (abnormal)
- Parse incoming messages with try/catch — clients may send invalid JSON
