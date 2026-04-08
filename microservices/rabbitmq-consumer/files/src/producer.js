require("dotenv").config();
const { getChannel, closeConnection } = require("./connection");

const QUEUE = process.env.QUEUE_NAME || "tasks";

async function sendMessage(message) {
  const channel = await getChannel();
  await channel.assertQueue(QUEUE, { durable: true });

  channel.sendToQueue(QUEUE, Buffer.from(message), { persistent: true });
  console.log(`[x] Sent: ${message}`);

  await closeConnection();
}

const message = process.argv[2] || "Hello from {{PROJECT_NAME}}!";
sendMessage(message).catch(console.error);
