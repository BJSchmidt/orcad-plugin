// orcad wrapper for istergiou/nas-rack (Apache-2.0): src/scad/inc/rack_item.scad.
// connector_lock() is the small tie-down that keeps a USB-SATA adapter in its
// rack slot; upstream exposes only the adapter width.
include <nas-rack-8c5f1582/src/scad/inc/rack_item.scad>

lock_width = 54.5;

connector_lock(bw = lock_width);
