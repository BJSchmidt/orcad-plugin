import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { viteSingleFile } from 'vite-plugin-singlefile'

// One self-contained HTML file: OrcaSlicer loads the page with SetPage(), so
// there is no server to fetch separate assets from.
//
// Keep this page small. The host hands the whole string to the webview in one
// piece (WebView2 NavigateToString), which fails above about 2 MB - so the
// catalog, the model previews and the 3D viewer are delivered by the plugin at
// runtime instead of being bundled here (see frontend/src/catalog.js,
// thumbs.js and viewport.js). packaging/check.py enforces the budget.
export default defineConfig({
  plugins: [react(), viteSingleFile()],
  build: {
    target: 'es2020',
    cssCodeSplit: false,
    assetsInlineLimit: 100_000_000,
    // ORCAD_OUT_DIR lets the release check build into a scratch directory.
    outDir: process.env.ORCAD_OUT_DIR || 'dist',
  },
})
