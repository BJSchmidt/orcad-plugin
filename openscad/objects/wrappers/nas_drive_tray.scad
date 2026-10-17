// orcad wrapper for istergiou/nas-rack (Apache-2.0): src/scad/inc/rack_item.scad.
// both_parts() builds the two mirrored rack halves that clamp a 3.5" drive
// between the threaded rods; upstream only exposes the rod hardware top level.
include <nas-rack-8c5f1582/src/scad/inc/rack_item.scad>

threadedRodHoleD = 4.4;
threadedRodNutD = 7.7;
threadedRodHoleOuterDiameter = 6;

both_parts(drive = true, power = false, board = false);
