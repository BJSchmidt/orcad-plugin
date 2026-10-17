// orcad wrapper for dmhernandez2525/splice3d (MIT): hardware/f1_4/cad/vent_ducts.scad.
// Upstream renders a cooling/exhaust duct bed with its own top-level layout, so
// the wrapper includes it and restates the HEPA mounting switch it exposes.
include <splice3d-1b9233f1/hardware/f1_4/cad/vent_ducts.scad>

// HEPA-Rahmen mitdrucken
hepa_enabled = true;
