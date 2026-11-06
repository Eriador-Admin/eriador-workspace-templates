import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  root: path.resolve(__dirname, 'src/renderer'),
  // The packaged window loads index.html over file://, so asset URLs must be relative.
  base: './',
  build: {
    outDir: path.resolve(__dirname, 'dist/renderer'),
  },
  server: {
    port: {{DEV_PORT}},
  },
});
