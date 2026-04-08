import mqtt from "mqtt";
import "dotenv/config";

const BROKER_URL = process.env.MQTT_BROKER_URL || "mqtt://localhost:1883";

export function createClient(clientId: string): mqtt.MqttClient {
  const client = mqtt.connect(BROKER_URL, {
    clientId,
    clean: true,
    connectTimeout: 5000,
    reconnectPeriod: 3000,
  });

  client.on("connect", () => {
    console.log(`[${clientId}] Connected to ${BROKER_URL}`);
  });

  client.on("error", (err) => {
    console.error(`[${clientId}] Error:`, err.message);
  });

  client.on("reconnect", () => {
    console.log(`[${clientId}] Reconnecting...`);
  });

  return client;
}
