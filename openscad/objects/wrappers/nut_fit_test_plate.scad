// orcad wrapper for ewc3labs/ewc3-test-hole-generator (MIT): _ARCHIVE/src/test-hole-generator.scad.
// The earlier rectangular test plate, generated in larger steps so a printed
// strip identifies which hex-nut or square-nut pocket fits. Upstream renders
// the plate at top level, so the wrapper includes it and restates its rows.
include <ewc3-test-hole-generator-c4b7bfdc/_ARCHIVE/src/test-hole-generator.scad>

// Form der Löcher
shape_type = "hexagon";
// Kleinste Lochgröße
start_size = 5;
// Größte Lochgröße
end_size = 8.95;
// Schrittweite pro Loch
step_size = 0.05;
// Löcher pro Reihe
holes_per_row = 10;
// Abstand zwischen den Löchern
hole_spacing = 3;
// Dicke der Platte
plate_thickness = 5;
