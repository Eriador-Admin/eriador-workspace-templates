# {{PROJECT_NAME}}

A real-time WebSocket server built with [Socket.io](https://socket.io/) and Express.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start the server
bash stop.sh    # stop the server
```

Open http://localhost:{{DEV_PORT}} to see the demo chat client.

## Project Structure

```
src/
  server.js         # Express + Socket.io server
  handlers/
    chat.js         # Chat room event handlers
    connection.js   # Connection/disconnection handlers
public/
  index.html        # Demo chat client
```

## Events

| Event            | Direction       | Description              |
|------------------|-----------------|--------------------------|
| `join-room`      | client → server | Join a chat room         |
| `leave-room`     | client → server | Leave a chat room        |
| `chat-message`   | client → server | Send a message           |
| `message`        | server → client | Broadcast message        |
| `room-joined`    | server → client | Confirm room join        |
| `user-connected` | server → client | New user notification    |

## Requirements

- Node.js 18+
