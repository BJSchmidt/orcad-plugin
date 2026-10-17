// orcad wrapper for holgerlembke/OpenSCAD-Modelle (MIT): ender3v3kefilamentguide2.scad.
// Version 2 of the Ender 3 V3 KE guide adds a filament roller in front of the
// coupling. Upstream renders the whole bracket, so the wrapper includes it and
// restates the bracket and roller dimensions it exposes.
include <holgerlembke-openscad-modelle-b48f4ea0/ender3v3kefilamentguide2.scad>

// Höhe des Haltewinkels
winkelh = 50.0;
// Länge des Haltewinkels
winkell = 40.0;
// Breite des Haltewinkels
winkelb = 40.0;
// Außendurchmesser des Rollrads
rollrdm = 24.0;
// Dicke des Rollrads
rollrb = 3.0;
