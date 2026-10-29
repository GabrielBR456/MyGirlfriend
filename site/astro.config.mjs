// @ts-check
import { defineConfig } from 'astro/config';

import tailwindcss from '@tailwindcss/vite';

// Site de projeto do GitHub Pages: gabrielbr456.github.io/MyGirlfriend
// Todo caminho interno deve passar pelo helper `url()` de src/lib/url.ts.
export default defineConfig({
  site: 'https://gabrielbr456.github.io',
  base: '/MyGirlfriend',
  vite: {
    plugins: [tailwindcss()]
  }
});
