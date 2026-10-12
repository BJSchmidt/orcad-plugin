// orcad wrapper for holgerlembke/OpenSCAD-Modelle (MIT): Schaberklingenhalter.scad.
// Handle that carries a replaceable trapezoid scraper blade for cleaning a print
// bed. Upstream renders the complete handle, so the wrapper includes it and
// restates the handle and blade-seat dimensions it exposes.
include <holgerlembke-openscad-modelle-b48f4ea0/Schaberklingenhalter.scad>

// Breite des Griffs
griffbreite = 25.0;
// Länge des Griffs
grifflaenge = 120.0;
// Höhe des Griffs
griffhoehe = 5.0;
// DM der Klingenaufnahme
holderdm = 6.5;
