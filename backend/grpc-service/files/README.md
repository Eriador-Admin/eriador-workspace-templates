# {{SERVICE_NAME}}

A gRPC service with Protocol Buffers and Node.js.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start the gRPC server
bash stop.sh    # stop the server
```

## Project Structure

```
proto/
  greeter.proto     # Protocol Buffer definitions
src/
  server.js         # gRPC server implementation
  client.js         # Example gRPC client
```

## Testing

```bash
node src/client.js          # run the example client
```

## Requirements

- Node.js 18+
