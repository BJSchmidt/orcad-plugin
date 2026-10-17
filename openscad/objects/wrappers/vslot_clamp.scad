// orcad wrapper for holgerlembke/OpenSCAD-Modelle (MIT): halteklammer.scad.
// Clamp plate that grips a 40 mm V-slot extrusion and carries a strap and screws
// for a remote sensor or tool. Upstream renders the plate, so the wrapper
// includes it and restates the plate and slot dimensions it exposes.
include <holgerlembke-openscad-modelle-b48f4ea0/halteklammer.scad>

// Länge der Platte (Slot-Breite)
laenge = 40.0;
// Breite der Platte
breite = 60.0;
// Dicke der Platte
dicke = 7.0;
// Breite der Nutenstege
stegbreite = 6.2;
