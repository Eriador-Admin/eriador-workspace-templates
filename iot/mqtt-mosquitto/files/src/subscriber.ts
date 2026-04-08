import { createClient } from "./mqtt.js";

const client = createClient("subscriber-01");

const TOPICS = [
  "sensors/temperature",
  "sensors/humidity",
  "devices/+/status",
  "alerts/#",
];

client.on("connect", () => {
  for (const topic of TOPICS) {
    client.subscribe(topic, { qos: 1 }, (err) => {
      if (err) {
        console.error(`Failed to subscribe to ${topic}:`, err.message);
      } else {
        console.log(`Subscribed to: ${topic}`);
      }
    });
  }
});

client.on("message", (topic, payload) => {
  try {
    const data = JSON.parse(payload.toString());
    console.log(`[${topic}]`, JSON.stringify(data, null, 2));
  } catch {
    console.log(`[${topic}]`, payload.toString());
  }
});

process.on("SIGINT", () => {
  console.log("\nDisconnecting...");
  client.end(false, () => process.exit(0));
});
