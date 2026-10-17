// orcad wrapper for dmhernandez2525/splice3d (MIT): hardware/f1_4/cad/filament_guides.scad.
// guide_fitting_block() is the entry fitting that feeds filament through a
// smooth channel into a PC4-M6 coupler; the wrapper passes the block size.
use <splice3d-1b9233f1/hardware/f1_4/cad/filament_guides.scad>

// Länge des Führungsblocks
guide_length = 28;
// Breite des Führungsblocks
guide_width = 16;
// Höhe des Führungsblocks
guide_height = 14;

guide_fitting_block(guide_length, guide_width, guide_height);
