// This is a mount for shower curtain rails.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

MOUNT_LENGTH = 20;
PLATE_THICKNESS = 2;
PLATE_HEIGHT = 20 + 20;

module mount() {
  difference() {
    cuboid([MOUNT_LENGTH, PLATE_THICKNESS, PLATE_HEIGHT], align=V_FRONT);
    xspread(n=2, spacing=12) zmove(5) ycyl(d=2, h=5, align=V_FRONT, $fn=FN);
    zmove(10) ycyl(d=2, h=5, align=V_FRONT, $fn=FN);
  }
  move([0, 1.8, -1.75]) cuboid([MOUNT_LENGTH, 10 - 0.3, 16.0], align=V_BACK + V_DOWN, fillet=1, edges=EDGES_ALL , $fn=FN);
  move([0, 0, -9.75]) cuboid([MOUNT_LENGTH - 2, 1.8, 8], align=V_BACK);
}

mount();
