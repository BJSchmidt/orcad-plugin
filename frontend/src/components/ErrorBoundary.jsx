import { Component } from 'react'

// A page that throws during render used to leave the tab white with no hint of
// what happened. This keeps the failure on screen, in the plugin's own styling.
export class ErrorBoundary extends Component {
  constructor(props) {
    super(props)
    this.state = { error: null }
  }

  static getDerivedStateFromError(error) {
    return { error }
  }

  componentDidCatch(error, info) {
    console.error('OrcaCAD failed to render:', error, info?.componentStack)
  }

  render() {
    if (!this.state.error) return this.props.children
    return (
      <div className="boot-failure" role="alert">
        <h2>OrcaCAD could not start</h2>
        <p>{String(this.state.error?.message || this.state.error)}</p>
        <p className="muted">Please report this together with the console output, then reopen the tab.</p>
        <button type="button" className="btn btn-primary" onClick={() => globalThis.location?.reload?.()}>Reload</button>
      </div>
    )
  }
}
