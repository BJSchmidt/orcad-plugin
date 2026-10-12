// orcad wrapper for dmhernandez2525/splice3d (MIT): hardware/f1_1/cad/filament_guides_jigs.scad.
// guide_block() is the small alignment jig the guide fittings are assembled
// around; the wrapper exposes its size instead of rendering the whole bed.
use <splice3d-1b9233f1/hardware/f1_1/cad/filament_guides_jigs.scad>

// Länge des Jigs
jig_length = 20;
// Breite des Jigs
jig_width = 14;
// Höhe des Jigs
jig_height = 12;

guide_block(jig_length, jig_width, jig_height);
