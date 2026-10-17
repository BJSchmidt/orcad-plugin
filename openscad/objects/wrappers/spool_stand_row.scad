// orcad wrapper for dmhernandez2525/splice3d (MIT): hardware/f1_4/cad/spool_holder.scad.
// spool_side_stand() is one side of a 1 kg spool cradle; orcad lays out a row of
// them at a settable pitch instead of editing the vendored module.
use <splice3d-1b9233f1/hardware/f1_4/cad/spool_holder.scad>

// Anzahl der Ständer
stand_count = 2;
// Abstand zwischen den Ständern
stand_pitch = 100;

for (i = [0 : stand_count - 1])
    translate([i * stand_pitch, 0, 0]) spool_side_stand();
