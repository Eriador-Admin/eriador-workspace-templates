import { redis } from "../redis.js";

/**
 * Cache-aside pattern: check cache first, fetch from source on miss.
 */
export async function cacheAside<T>(
  key: string,
  ttlSeconds: number,
  fetchFn: () => Promise<T>
): Promise<{ data: T; cached: boolean }> {
  const cached = await redis.get(key);
  if (cached) {
    return { data: JSON.parse(cached), cached: true };
  }

  const data = await fetchFn();
  await redis.setex(key, ttlSeconds, JSON.stringify(data));
  return { data, cached: false };
}

export async function invalidateCache(key: string) {
  await redis.del(key);
}
