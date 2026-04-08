# Agent Instructions — {{SERVICE_NAME}}

This is a gRPC service using Node.js and Protocol Buffers.

## Tech Stack
- **Protocol**: gRPC (HTTP/2, binary protocol)
- **Schema**: Protocol Buffers (.proto files)
- **Runtime**: Node.js with @grpc/grpc-js

## Key Conventions
- Proto definitions in `proto/` — define services and messages
- Server in `src/server.js` — implements service methods
- Client in `src/client.js` — example client for testing
- Uses dynamic proto loading (@grpc/proto-loader) — no code generation step
- Services defined in .proto, implementations in server

## File Patterns
- `proto/*.proto` → Service and message definitions
- `src/server.js` → Server with service implementations
- `src/client.js` → Client example
