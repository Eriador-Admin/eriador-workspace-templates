# {{PROJECT_NAME}}

A raw WebSocket server built with [ws](https://github.com/websockets/ws) — the fastest and most popular WebSocket library for Node.js. No abstraction layer, direct control over the WebSocket protocol.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start on port 8080
bash stop.sh    # stop server
```

## Prerequisites

- Node.js 18+

## Project Structure

```
src/
  server.ts             # WebSocket server setup + HTTP upgrade
  handlers/
    connection.ts       # Connection lifecycle (open, close, error)
    message.ts          # Message routing and handling
  rooms/
    room-manager.ts     # Room join/leave/broadcast logic
  utils/
    heartbeat.ts        # Ping/pong heartbeat to detect dead connections
    logger.ts           # Simple logger
test-client.html        # Browser-based test client
```

## Protocol

Messages are JSON with a `type` field:

```json
{ "type": "join", "room": "general" }
{ "type": "message", "room": "general", "data": "Hello!" }
{ "type": "leave", "room": "general" }
```

Server broadcasts to room members. Heartbeat pings every 30s to detect stale connections.

## Testing

Open `test-client.html` in a browser to connect and send messages interactively.
