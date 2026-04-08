const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');
const path = require('path');

const PROTO_PATH = path.join(__dirname, '..', 'proto', 'greeter.proto');
const PORT = process.env.GRPC_PORT || '{{GRPC_PORT}}';

const packageDefinition = protoLoader.loadSync(PROTO_PATH, {
  keepCase: true,
  longs: String,
  enums: String,
  defaults: true,
  oneofs: true,
});

const greeterProto = grpc.loadPackageDefinition(packageDefinition).greeter;

function sayHello(call, callback) {
  callback(null, {
    message: `Hello, ${call.request.name}!`,
    timestamp: new Date().toISOString(),
  });
}

function sayHelloAgain(call, callback) {
  callback(null, {
    message: `Hello again, ${call.request.name}!`,
    timestamp: new Date().toISOString(),
  });
}

function main() {
  const server = new grpc.Server();
  server.addService(greeterProto.Greeter.service, {
    SayHello: sayHello,
    SayHelloAgain: sayHelloAgain,
  });

  server.bindAsync(
    `0.0.0.0:${PORT}`,
    grpc.ServerCredentials.createInsecure(),
    (err, port) => {
      if (err) {
        console.error('Failed to start server:', err);
        process.exit(1);
      }
      console.log(`gRPC server running on port ${port}`);
    }
  );
}

main();
