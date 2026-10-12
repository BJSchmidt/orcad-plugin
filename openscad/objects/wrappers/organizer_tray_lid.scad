// orcad wrapper for mmalecki/composable-organizer (MIT): tray-lid.scad.
// Upstream takes a [x, y, z] size vector; the wrapper builds it from units.
use <composable-organizer-f01bb2fb/tray-lid.scad>

tray_lid_x = 3;
tray_lid_y = 2;
tray_lid_z = 2;
tray_lid_notch = true;

tray_lid([tray_lid_x, tray_lid_y, tray_lid_z], notch = tray_lid_notch);
