'use client';

import { trpc } from '@/utils/trpc';

export default function Home() {
  const hello = trpc.hello.useQuery({ text: 'tRPC' });

  return (
    <main className="p-8">
      <h1 className="text-3xl font-bold">{'{{APP_NAME}}'}</h1>
      <p className="mt-2 text-gray-600">Next.js + tRPC + Tailwind</p>
      <p className="mt-4">{hello.data?.greeting ?? 'Loading...'}</p>
    </main>
  );
}
