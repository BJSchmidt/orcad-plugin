// orcad wrapper for holgerlembke/OpenSCAD-Modelle (MIT): spoolholder3.scad.
// The v3 shelf arm adds a roller and a tipping guard to the spool hook. Upstream
// renders the complete arm, so the wrapper includes it and restates the roller
// and arm dimensions it exposes.
include <holgerlembke-openscad-modelle-b48f4ea0/spoolholder3.scad>

// Dicke des Armes
rundscheibeh = 8.0;
// Länge des Spulenrollers
arml = 65;
// Außendurchmesser des Rollers
armda = 25;
// Innendurchmesser des Rollers
armdi = 20;
