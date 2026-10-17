// orcad wrapper for istergiou/nas-rack (Apache-2.0): src/scad/inc/rack_item.scad.
// connector() is the snap-on USB-to-SATA adapter caddy: the case with the
// adapter body subtracted so the drive connector sits inside it.
include <nas-rack-8c5f1582/src/scad/inc/rack_item.scad>

caddy_offset = 10;

connector(zOffset = caddy_offset);
