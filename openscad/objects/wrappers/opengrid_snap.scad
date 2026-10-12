// orcad wrapper for mikeydotio/opengrid-scad (CC-BY-4.0): the opengrid_snap()
// module from the openGrid wall system, the clip that anchors every accessory.
use <opengrid-scad-894a731f/opengrid-snap.scad>

snap_fitment = 0.66;

opengrid_snap(snap_type = "Directional", fitment = snap_fitment);
