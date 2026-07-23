import { defineConfig } from 'vite';
import { configDefaults } from 'vitest/config';
import rescript from '@jihchi/vite-plugin-rescript';

export default defineConfig({
  test: {
    includeSource: ['src/insource.mjs'],
    exclude: [
      ...configDefaults.exclude,
      'lib/bs/**',
    ],
  },
  plugins: [
    // https://github.com/jihchi/vite-plugin-rescript/issues/231
    // rescript(),
  ],
})
