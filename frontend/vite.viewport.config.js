import { defineConfig } from 'vite'

// The 3D viewer as a classic script, built next to the page as
// frontend/dist/viewport.js. The plugin embeds it, and the page downloads it
// from the plugin the first time a model is previewed, so three.js never sits
// in the page OrcaSlicer loads with SetPage(). It registers window.__orcadThree.
export default defineConfig({
  build: {
    target: 'es2020',
    minify: 'esbuild',
    // never wipe the page index.html that the other build writes here
    emptyOutDir: false,
    outDir: process.env.ORCAD_OUT_DIR || 'dist',
    lib: {
      entry: 'src/viewport-entry.js',
      formats: ['iife'],
      name: 'OrcadThree',
      fileName: () => 'viewport.js',
    },
  },
})
