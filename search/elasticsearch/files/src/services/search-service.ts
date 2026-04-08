import { elasticClient } from "./elastic";

export async function search(
  index: string,
  query: string,
  from = 0,
  size = 10
) {
  return elasticClient.search({
    index,
    body: {
      from,
      size,
      query: {
        multi_match: {
          query,
          fields: ["*"],
          fuzziness: "AUTO",
        },
      },
    },
  });
}

export async function advancedSearch(index: string, body: object) {
  return elasticClient.search({ index, body });
}
