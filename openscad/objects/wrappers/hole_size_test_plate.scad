// orcad wrapper for ewc3labs/ewc3-test-hole-generator (MIT): src/test-hole-generator-v2.scad.
// Parametric plate of labelled, increasing holes; print it and measure which
// size fits a screw or shaft on this printer. Upstream renders the plate at top
// level, so the wrapper includes it and restates the row and plate dimensions.
include <ewc3-test-hole-generator-c4b7bfdc/src/test-hole-generator-v2.scad>

// Form der Löcher
hole_type = "circle";
// Kleinste Lochgröße
initial_hole_size = 5;
// Größte Lochgröße
final_hole_size = 6.75;
// Schrittweite pro Loch
hole_step_size = 0.25;
// Löcher pro Reihe
holes_per_row = 4;
// Abstand zwischen den Löchern
hole_spacing = 3.0;
// Dicke der Platte
plate_thickness = 5.0;
