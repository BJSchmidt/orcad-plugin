// orcad wrapper for holgerlembke/OpenSCAD-Modelle (MIT): spoolholder.scad.
// Upstream prints a pair of interlocking arms that hook over a Lundia shelf and
// carry 608-bearing axles for a filament spool. The pinned file already assembles
// that pair, so the wrapper restates the dimensions it exposes and includes it.
include <holgerlembke-openscad-modelle-b48f4ea0/spoolholder.scad>

// Länge der Arme
armlaenge = 120.0;
// Dicke des Armes
rundscheibeh = 14.0;
// DM der Lagerbohrung
kugellagerdi = 7.9;
// Offset des Zapfens von der Wand
kugelofs = 10.0;
