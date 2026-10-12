// orcad wrapper for holgerlembke/OpenSCAD-Modelle (MIT): Kabel Knickschutz.scad.
// Tapered segmented sleeve that takes the bend out of a hot-end or bed cable
// where it leaves the frame. Upstream renders the whole sleeve, so the wrapper
// includes it and restates the ring dimensions it exposes.
include <holgerlembke-openscad-modelle-b48f4ea0/Kabel Knickschutz.scad>

// Außendurchmesser des ersten Rings
ringda = 12.0;
// Innendurchmesser des Kabelkanals
ringdi = 6.0;
// Anzahl der Ringe
ringanzahl = 12;
// Abstand zwischen den Ringen
ringabstand = 0.8;
