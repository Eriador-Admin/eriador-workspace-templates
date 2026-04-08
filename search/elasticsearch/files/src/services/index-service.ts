import { elasticClient } from "./elastic";

export async function createIndex(name: string, mappings?: object) {
  return elasticClient.indices.create({
    index: name,
    body: mappings ? { mappings } : undefined,
  });
}

export async function deleteIndex(name: string) {
  return elasticClient.indices.delete({ index: name });
}

export async function indexExists(name: string): Promise<boolean> {
  return elasticClient.indices.exists({ index: name });
}
