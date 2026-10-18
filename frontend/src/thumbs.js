// Model preview thumbnails.
//
// The previews are rendered ahead of time (dev/thumbs.py) and shipped with the
// plugin, but they are not part of the page: 350 inlined PNGs added 425 KB to
// the HTML OrcaSlicer hands to the webview, which is what tipped the page over
// its size limit. Instead the cards ask for the previews of the models they are
// actually showing, and the plugin answers with base64 from its payload.
import { useEffect, useState } from 'react'
import { bridge } from './bridge.js'

const MAX_BATCH = 48
const BATCH_DELAY = 16

// One observer per scroll container: a card owning its own would mean 350
// registrations on the machines that can least afford them.
const observers = new Map()
const watchers = new WeakMap()

function scrollParent(element) {
  for (let node = element.parentElement; node; node = node.parentElement) {
    const overflow = globalThis.getComputedStyle?.(node)?.overflowY
    if ((overflow === 'auto' || overflow === 'scroll') && node.scrollHeight > node.clientHeight) return node
  }
  return null
}

function observerFor(root) {
  let observer = observers.get(root)
  if (!observer) {
    observer = new IntersectionObserver((entries) => {
      for (const entry of entries) {
        if (!entry.isIntersecting) continue
        const notify = watchers.get(entry.target)
        if (!notify) continue
        watchers.delete(entry.target) // one preview per card, ever
        observer.unobserve(entry.target)
        notify()
      }
    }, { root, rootMargin: root ? '600px 0px' : '256px' })
    observers.set(root, observer)
  }
  return observer
}

/** Calls notify once the element is on screen (or about to be), then stops watching. */
export function whenVisible(element, notify) {
  if (typeof IntersectionObserver !== 'function') {
    notify()
    return () => {}
  }
  // A card clipped by a scroll container can never intersect past it, so a card
  // inside the library panel watches that panel rather than the window.
  const observer = observerFor(scrollParent(element))
  watchers.set(element, notify)
  observer.observe(element)
  return () => {
    watchers.delete(element)
    observer.unobserve(element)
  }
}

const urls = new Map()
const waiting = new Map()
let queue = new Set()
let timer = null
let nextId = 1

export function subscribe(name, listener) {
  if (!waiting.has(name)) waiting.set(name, new Set())
  const set = waiting.get(name)
  set.add(listener)
  return () => { set.delete(listener) }
}

function publish(name, url) {
  urls.set(name, url)
  for (const listener of waiting.get(name) || []) listener(url)
  waiting.delete(name)
}

function flush() {
  timer = null
  const keys = [...queue].slice(0, MAX_BATCH)
  queue = new Set([...queue].slice(MAX_BATCH))
  if (queue.size) schedule()
  if (keys.length) bridge.send({ type: 'thumbs', id: nextId++, keys })
}

function schedule() {
  if (timer === null) timer = setTimeout(flush, BATCH_DELAY)
}

export function requestThumb(name) {
  if (!name || urls.has(name) || !bridge.available) return
  queue.add(name)
  schedule()
}

export function thumbUrl(name) {
  return urls.get(name) || null
}

// A reply carries the previews of one card batch, so one message covers a screenful.
bridge.subscribe((message) => {
  if (message.type !== 'thumbs' || !Array.isArray(message.items)) return
  for (const item of message.items) {
    if (item && typeof item.key === 'string' && typeof item.png === 'string') {
      publish(item.key, `data:image/png;base64,${item.png}`)
    }
  }
})

/** The preview URL for `name`, requested once the card is on screen. */
export function useThumb(name, visible = true) {
  const [url, setUrl] = useState(() => thumbUrl(name))
  useEffect(() => {
    if (!name || !visible) return undefined
    const cached = thumbUrl(name)
    if (cached) { setUrl(cached); return undefined }
    setUrl(null)
    const off = subscribe(name, setUrl)
    requestThumb(name)
    return off
  }, [name, visible])
  return url
}
