// orcad wrapper for agjendem/corrugated-pipe-clamp (MIT): pipe_clamp.scad.
// Split clamp with axial grip teeth for corrugated electrical conduit. Upstream
// renders its own body; the values below restate upstream's defaults so opening
// this file matches the catalog, and the plugin's -D definitions override them.
include <corrugated-pipe-clamp-f85ac05d/pipe_clamp.scad>

pipe_diameter = 15.8;
bore_diameter = 18;
corr_count = 6;
coverage_deg = 200;
flange_overhang = 3;
flange_thickness = 1;
screw_count = 0;
