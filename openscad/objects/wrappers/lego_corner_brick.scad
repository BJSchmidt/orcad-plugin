// orcad wrapper for qubolino/brick_lib (CC0-1.0): L shaped corner brick.
include <qubolino-brick-lib-95a3c865/corner.scad>
corner_length = 2;
corner_height_plates = 1;
corner_height = corner_height_plates / 3;
corner(corner_length, corner_height, "brick");
