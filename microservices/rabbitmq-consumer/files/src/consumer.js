require("dotenv").config();
const { getChannel } = require("./connection");

const QUEUE = process.env.QUEUE_NAME || "tasks";

async function startConsumer() {
  const channel = await getChannel();
  await channel.assertQueue(QUEUE, { durable: true });
  channel.prefetch(1);

  console.log(`[*] Waiting for messages in "${QUEUE}". Press Ctrl+C to exit.`);

  channel.consume(QUEUE, (msg) => {
    if (!msg) return;

    const content = msg.content.toString();
    console.log(`[x] Received: ${content}`);

    // Process the message
    setTimeout(() => {
      console.log(`[x] Done processing: ${content}`);
      channel.ack(msg);
    }, 1000);
  });
}

startConsumer().catch(console.error);

process.on("SIGINT", () => {
  console.log("\nShutting down consumer...");
  process.exit(0);
});
