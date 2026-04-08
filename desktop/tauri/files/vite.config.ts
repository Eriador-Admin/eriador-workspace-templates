import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  clearScreen: false,
  server: {
    port: {{DEV_PORT}},
    strictPort: true,
  },
  envPrefix: ['VITE_', 'TAURI_'],
});
