import { redis } from "../redis.js";

/**
 * Sliding window rate limiter using Redis sorted sets.
 */
export async function isRateLimited(
  key: string,
  maxRequests: number,
  windowSeconds: number
): Promise<{ limited: boolean; remaining: number }> {
  const now = Date.now();
  const windowStart = now - windowSeconds * 1000;
  const redisKey = `ratelimit:${key}`;

  const pipeline = redis.pipeline();
  pipeline.zremrangebyscore(redisKey, 0, windowStart);
  pipeline.zadd(redisKey, now.toString(), `${now}-${Math.random()}`);
  pipeline.zcard(redisKey);
  pipeline.expire(redisKey, windowSeconds);

  const results = await pipeline.exec();
  const count = (results?.[2]?.[1] as number) || 0;

  return {
    limited: count > maxRequests,
    remaining: Math.max(0, maxRequests - count),
  };
}
