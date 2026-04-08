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

function main() {
  const client = new greeterProto.Greeter(
    `localhost:${PORT}`,
    grpc.credentials.createInsecure()
  );

  client.SayHello({ name: 'World' }, (err, response) => {
    if (err) {
      console.error('Error:', err.message);
      return;
    }
    console.log('SayHello:', response.message, `(${response.timestamp})`);
  });

  client.SayHelloAgain({ name: 'World' }, (err, response) => {
    if (err) {
      console.error('Error:', err.message);
      return;
    }
    console.log('SayHelloAgain:', response.message, `(${response.timestamp})`);
  });
}

main();
