import { defineConfig } from 'astro/config';

export default defineConfig({
  server: { port: parseInt(process.env.DEV_PORT || '4321') }
});
