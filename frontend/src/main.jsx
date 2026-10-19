import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.jsx'
import { ErrorBoundary } from './components/ErrorBoundary.jsx'
import { setCatalog } from './catalog.js'
import './style.css'

// OrcaSlicer stamps data-orca-theme (and updates it live); outside the host,
// follow the OS preference instead.
const root = document.documentElement
if (!root.hasAttribute('data-orca-theme')) {
  const query = window.matchMedia?.('(prefers-color-scheme: light)')
  const apply = () => root.setAttribute('data-orca-theme', query?.matches ? 'light' : 'dark')
  apply()
  query?.addEventListener?.('change', apply)
}

// The plugin injects the compact catalog index (labels, categories, credits)
// into the page; the object parameters arrive later, one object at a time, when
// a model is selected. Opened outside OrcaSlicer the index is missing, and the
// app says so instead of failing.
setCatalog(globalThis.__ORCAD_BOOT__?.catalog, globalThis.__ORCAD_BOOT__?.error)
globalThis.__orcadBooted = true

createRoot(document.getElementById('app')).render(
  <StrictMode><ErrorBoundary><App /></ErrorBoundary></StrictMode>)
