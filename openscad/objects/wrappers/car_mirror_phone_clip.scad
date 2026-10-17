// orcad wrapper for StandardCyborg/clip-openscad (MIT): generate_assembly().
// Upstream sizes the clip from its own per-device dimension tables, so this
// wrapper restates the iPhone XS geometry with the device size as parameters
// and calls the upstream generator.
include <clip-openscad-789c87dc/components/constants.scad>
include <clip-openscad-789c87dc/components/rounded-cube.scad>
include <clip-openscad-789c87dc/components/phone.scad>
include <clip-openscad-789c87dc/components/mirror.scad>
include <clip-openscad-789c87dc/components/assembly.scad>

phone_width = 71;
phone_length = 144;
phone_thickness = 8;
phone_edge_radius = 8;
rounded_corners = true;
clip_width = 47;
clip_length = 50;
mirror_width = 36;

// Values the upstream generator takes but that the catalog does not expose.
camera_bump_x_offset = 11.82 - camera_bump_offset;
camera_bump_y_offset = 18.67 - camera_bump_offset + 0.5;
camera_bump_width = 11.26 + camera_bump_offset * 2;
camera_bump_length = 24.23 + camera_bump_offset * 2 + 1;
camera_bump_thickness = 1.56 + 1;
camera_bump_radius = camera_bump_width / 2;
mirror_offset = 2;
notch_offset_height = 3.91 + 4.99 + mirror_offset + dfm_notch_offset;
notch_offset_width = phone_width / 2 - mirror_width / 2;
back_offset_width = phone_width / 2 - mirror_back_width / 2;
clip_thickness = phone_thickness + 2 * clip_top_bottom_thickness;
cutout_width = mirror_width;
cutout_length = 16;
cutout_thickness = clip_thickness / 2 + 5;
cutout_1_dist = -4.8 + mirror_offset;
cutout_2_dist = -8.5 + mirror_offset;

generate_assembly(phone_width, phone_length, phone_thickness, phone_edge_radius,
                  rounded_corners, notch_offset_width, notch_offset_height,
                  back_offset_width, camera_bump_x_offset, camera_bump_y_offset,
                  camera_bump_width, camera_bump_length, camera_bump_thickness,
                  camera_bump_radius, clip_width, clip_length, clip_thickness,
                  clip_top_bottom_thickness, cutout_width, cutout_length,
                  cutout_thickness, cutout_1_dist, cutout_2_dist);
