// orcad wrapper for mmalecki/composable-organizer (MIT): lid.scad.
// Upstream takes a [x, y, z] size vector; the wrapper builds it from units.
use <composable-organizer-f01bb2fb/lid.scad>

lid_x = 3;
lid_y = 2;
lid_z = 2;

lid([lid_x, lid_y, lid_z]);
