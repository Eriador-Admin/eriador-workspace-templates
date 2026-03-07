import { z } from 'zod';
import { router, publicProcedure } from './trpc';
import { PrismaClient } from '@prisma/client';

const globalForPrisma = globalThis as unknown as { prisma?: PrismaClient };
const prisma = globalForPrisma.prisma ?? new PrismaClient();
if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma;

export const appRouter = router({
  hello: publicProcedure
    .input(z.object({ text: z.string().optional() }))
    .query(({ input }) => {
      return { greeting: `Hello ${input.text ?? 'world'}!` };
    }),

  posts: router({
    list: publicProcedure.query(async () => {
      return prisma.post.findMany({ orderBy: { createdAt: 'desc' } });
    }),

    create: publicProcedure
      .input(z.object({ title: z.string().min(1), content: z.string().optional() }))
      .mutation(async ({ input }) => {
        return prisma.post.create({ data: input });
      }),
  }),
});

export type AppRouter = typeof appRouter;
