import { elasticClient } from "./elastic";

export async function indexDocument(index: string, body: object, id?: string) {
  return elasticClient.index({ index, id, body });
}

export async function getDocument(index: string, id: string) {
  return elasticClient.get({ index, id });
}

export async function deleteDocument(index: string, id: string) {
  return elasticClient.delete({ index, id });
}

export async function bulkIndex(index: string, documents: object[]) {
  const operations = documents.flatMap((doc) => [
    { index: { _index: index } },
    doc,
  ]);
  return elasticClient.bulk({ body: operations, refresh: true });
}
