// orcad wrapper for mmalecki/composable-organizer (MIT): tray.scad.
// Upstream takes a [x, y, z] size vector; the wrapper builds it from units.
use <composable-organizer-f01bb2fb/tray.scad>

tray_x = 3;
tray_y = 2;
tray_z = 2;
tray_walls = true;

tray([tray_x, tray_y, tray_z], walls = tray_walls);
