import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

const devPort = Number(process.env.DEV_PORT) || 5173;

export default defineConfig({
  plugins: [sveltekit()],
  server: { port: devPort },
});
