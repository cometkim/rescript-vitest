import { defineConfig } from 'vite';
import rescript from '@jihchi/vite-plugin-rescript';

export default defineConfig({
  test: {
    includeSource: ['src/insource.mjs'], 
  },
  plugins: [
    rescript(),
  ],
})
