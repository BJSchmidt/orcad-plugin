// orcad wrapper for cfinke/Technic.scad (MIT): Technic axle.
include <cfinke-technic-scad-41f17a46/Technic.scad>
axle_length = 2;
axle_stop = false;
axle_stud = true;
technic_axle(length = axle_length, stop = axle_stop, stud = axle_stud);
