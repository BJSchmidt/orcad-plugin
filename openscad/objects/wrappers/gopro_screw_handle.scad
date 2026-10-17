// orcad wrapper for ridercz/GoProScad (MIT): gopro_screw_handle().
// Upstream's own sample only toggles the head, so this wrapper exposes the
// screw and handle lengths the library module already takes.
use <ridercz-gopro-98c0161e/GoPro.scad>

screw_length = 50;
hex_head = true;
total_length = 0;

gopro_screw_handle(screw_length = screw_length, hex_head = hex_head, total_length = total_length);
