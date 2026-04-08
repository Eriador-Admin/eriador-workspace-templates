const amqp = require("amqplib");

let connection = null;
let channel = null;

async function getChannel() {
  if (channel) return channel;

  const url = process.env.RABBITMQ_URL || "amqp://guest:guest@localhost:{{RABBITMQ_PORT}}";
  connection = await amqp.connect(url);
  channel = await connection.createChannel();

  connection.on("close", () => {
    console.log("RabbitMQ connection closed");
    channel = null;
    connection = null;
  });

  return channel;
}

async function closeConnection() {
  if (connection) {
    await connection.close();
    connection = null;
    channel = null;
  }
}

module.exports = { getChannel, closeConnection };
