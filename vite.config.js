import { defineConfig } from 'vite';
import symfonyPlugin from 'vite-plugin-symfony';

export default defineConfig({
  plugins: [
    symfonyPlugin(),
  ],
  build: {
    outDir: 'public/build',
    manifest: true,
  },
  server: {
    port: 8001,
  },
});
