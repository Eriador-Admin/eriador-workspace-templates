import Redis from "ioredis";

const subscriber = new Redis(process.env.REDIS_URL || "redis://localhost:6379");
const publisher = new Redis(process.env.REDIS_URL || "redis://localhost:6379");

const listeners: Map<string, ((message: string) => void)[]> = new Map();

subscriber.on("message", (channel, message) => {
  const fns = listeners.get(channel) || [];
  fns.forEach((fn) => fn(message));
});

export function subscribe(channel: string, callback: (message: string) => void) {
  if (!listeners.has(channel)) {
    listeners.set(channel, []);
    subscriber.subscribe(channel);
  }
  listeners.get(channel)!.push(callback);
}

export async function publish(channel: string, message: string) {
  await publisher.publish(channel, message);
}
