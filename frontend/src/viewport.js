// The three.js runtime, delivered on demand.
//
// three.js and OrbitControls are about 460 KB, a quarter of the whole page and
// pure overhead for someone who only browses the model library. The plugin
// keeps that code in a separate chunk and sends it when the 3D view is first
// needed; this module fetches it, runs it once and hands back the globals it
// registered.
import { bridge } from './bridge.js'

const TIMEOUT = 30_000
let loading = null
let nextId = 1

const globalRuntime = () => globalThis.__orcadThree || null

async function decode(message) {
  if (typeof message.code !== 'string' || !message.code) throw new Error('The plugin sent no 3D viewer code.')
  if (message.encoding !== 'gzip') return message.code
  if (typeof DecompressionStream !== 'function') throw new Error('This webview cannot decompress the 3D viewer.')
  const binary = atob(message.code)
  const bytes = new Uint8Array(binary.length)
  for (let i = 0; i < binary.length; i += 1) bytes[i] = binary.charCodeAt(i)
  const stream = new Blob([bytes]).stream().pipeThrough(new DecompressionStream('gzip'))
  return new Response(stream).text()
}

function install(code) {
  const script = document.createElement('script')
  script.textContent = code
  document.head.appendChild(script)
  script.remove()
  const runtime = globalRuntime()
  if (!runtime) throw new Error('The 3D viewer did not register itself.')
  return runtime
}

/** Resolves with { THREE, OrbitControls } once the viewer code has been fetched. */
export function viewportRuntime() {
  const ready = globalRuntime()
  if (ready) return Promise.resolve(ready)
  if (loading) return loading
  if (!bridge.available) {
    return Promise.reject(new Error('The 3D preview needs the OrcaCAD plugin. Reopen the tab in OrcaSlicer.'))
  }
  loading = new Promise((resolve, reject) => {
    const id = nextId++
    let timer = null
    const finish = (error, runtime) => {
      clearTimeout(timer)
      off()
      if (error) { loading = null; reject(error) } else resolve(runtime)
    }
    const off = bridge.subscribe((message) => {
      if (message.type !== 'viewport' || message.id !== id) return
      decode(message).then((code) => {
        try { finish(null, install(code)) } catch (error) { finish(error) }
      }, finish)
    })
    timer = setTimeout(() => finish(new Error('The 3D viewer timed out.')), TIMEOUT)
    bridge.send({ type: 'viewport', id, encoding: typeof DecompressionStream === 'function' ? 'gzip' : 'plain' })
  })
  return loading
}
