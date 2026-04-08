import { Connection, Client } from "@temporalio/client";

let client: Client;

export async function getClient(): Promise<Client> {
  if (!client) {
    const connection = await Connection.connect({
      address: process.env.TEMPORAL_ADDRESS || "localhost:7233",
    });
    client = new Client({ connection });
  }
  return client;
}

export const TASK_QUEUE = process.env.TEMPORAL_TASK_QUEUE || "main-queue";
