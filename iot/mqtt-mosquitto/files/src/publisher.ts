import { createClient } from "./mqtt.js";

const client = createClient("publisher-01");

function randomBetween(min: number, max: number): number {
  return Math.round((Math.random() * (max - min) + min) * 10) / 10;
}

function publishSensorData(): void {
  const temperature = {
    value: randomBetween(18, 35),
    unit: "celsius",
    timestamp: new Date().toISOString(),
  };
  client.publish("sensors/temperature", JSON.stringify(temperature), { qos: 1 });
  console.log("Published temperature:", temperature.value);

  const humidity = {
    value: randomBetween(30, 90),
    unit: "percent",
    timestamp: new Date().toISOString(),
  };
  client.publish("sensors/humidity", JSON.stringify(humidity), { qos: 1 });
  console.log("Published humidity:", humidity.value);

  const deviceId = `device-${Math.floor(Math.random() * 3) + 1}`;
  const status = {
    online: Math.random() > 0.2,
    battery: Math.floor(Math.random() * 100),
    timestamp: new Date().toISOString(),
  };
  client.publish(`devices/${deviceId}/status`, JSON.stringify(status), { qos: 1 });

  if (temperature.value > 30) {
    const alert = {
      type: "high-temperature",
      value: temperature.value,
      threshold: 30,
      timestamp: new Date().toISOString(),
    };
    client.publish("alerts/temperature", JSON.stringify(alert), { qos: 2 });
    console.log("ALERT: High temperature!");
  }
}

client.on("connect", () => {
  publishSensorData();
  setInterval(publishSensorData, 3000);
});

process.on("SIGINT", () => {
  console.log("\nDisconnecting...");
  client.end(false, () => process.exit(0));
});
