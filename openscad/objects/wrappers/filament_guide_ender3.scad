// orcad wrapper for holgerlembke/OpenSCAD-Modelle (MIT): ender3v3kefilamentguide.scad.
// Side-mount filament guide and runout-sensor bracket for an Ender 3 V3 KE.
// Upstream renders the bracket at top level, so the wrapper includes it and
// restates the mounting-block and coupling dimensions it exposes.
include <holgerlembke-openscad-modelle-b48f4ea0/ender3v3kefilamentguide.scad>

// Höhe des Haltewinkels
winkelh = 50.0;
// Länge des Haltewinkels
winkell = 40.0;
// Breite des Haltewinkels
winkelb = 40.0;
// Außenmaß der Schlauchkupplung
kupplungaussen = 25.0;
// Höhe der Schlauchkupplung
kupplungh = 18.0;
