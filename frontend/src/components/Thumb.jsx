import { useEffect, useRef, useState } from 'react'
import { useThumb, whenVisible } from '../thumbs.js'

// One model card preview. The 350 previews are prebuilt and shipped with the
// plugin, but asking for all of them up front would put them in the page (and
// over the host's size limit), so a card requests its own preview once it
// scrolls into view.
export function Thumb({ name }) {
  const host = useRef(null)
  const [visible, setVisible] = useState(false)

  useEffect(() => {
    const element = host.current
    if (!element) return undefined
    return whenVisible(element, () => setVisible(true))
  }, [name])

  const url = useThumb(name, visible)
  return (
    <span className="object-thumb" ref={host}>
      {url ? <img src={url} alt="" /> : <span className="thumb-empty" aria-hidden="true" />}
    </span>
  )
}
