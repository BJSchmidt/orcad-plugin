/*
 * Module: dkb_lib_plate_parts.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates the basic (empty) "plates" in the appropriate
 * shape for DonKbot robots (similar in shape to the UKMARS basic chassis)
 * the plates include the basic pillars and holes for stacking the platees
 *
 * Project:   DonKbot_mm
 * Author(s): Don Korte
 * github:    https://github.com/dnkorte/donkbot
 *   
 * Note that this and all functional modules
 * within the DonKbot family also reference 3 true "core" modules that on
 * my computers actually live in a different folder because they provide
 * functionality for several additional projects.  However for most users, 
 * they may be stored in the same folder as the DonKbot files.
 *  The 3 "core" modules are:
 *      core_robo_functions.scad 
 *      core_config_dimensions.scad
 *      core_parts_wheels.scad
 * they can be found at https://github.com/dnkorte/lib_robo_core
 * 
 * if they are stored in a remote location, you may use a system ENVIRONMENT
 * VARIABLE called OPENSCADPATH to allow OpenSCAD to find them at that location.
 *
 * to implement the OPENSCADPATH library functionality, setup the environment var as follows:
 *      on linux, store a file called /etc/profile.d/openscadpath.sh with contents:  
 *          export OPENSCADPATH="/home/the_rest_of_the_path/" 
 *          (note that ~/.bashrc fails because its not run from terminal session)
 *      on Windows, by Control Panel / System / Advanced System Settings / Environment Variables / User Variable 
 * see https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries   for details
 * *************************************************************************
 *   
 * MIT License
 * 
 * Copyright (c) 2024 Don Korte
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * *************************************************************************
 *  
 * Reference:
 *  https://github.com/dnkorte/donkbot
 *  https://github.com/dnkorte/lib_robo_core
 *  https://photos.app.goo.gl/n3T1WMVK3Vmwz7cS7  photo album random pics donkbot parts etc
 *  https://photos.app.goo.gl/D5PgzwZijvFSpFg68  photo album maze fabrication
 *  https://donstechstuff.com/
 *  https://openscad.org/
 *  https://donstechstuff.com
 *
 * Version History:
 *  20241204    - Initial Release
 */


/*
 ********************************************************************
 * component parts to support robotics plates
 ********************************************************************
 */

/* 
 * style = "A" post forward, hole back;  "B" hole forward, post back; "C" hole-only fwd;  "D" hole-only back
 *		   "E" post-only back
 * hole_or_post = "H" or "P"  
 */

module component_plate( style, pillar_height )  {
	difference() {
		union() {
			component_plate_simple();
			component_standoff( pillar_height, standoff_y_front, style, "P" );
			component_standoff( pillar_height, standoff_y_back, style, "P" );
		}
		component_standoff( pillar_height, standoff_y_front, style, "H" );
		component_standoff( pillar_height, standoff_y_back, style, "H" );
	}
}

module component_plate_simple( thickness = plate_thick) {
	plate_uk_triangle_x = 12;
	plate_uk_triangle_y = 12;
	plate_uk_square_part_x = plate_x;
	plate_uk_square_part_y = plate_y - plate_uk_triangle_y;

	translate([ -plate_uk_square_part_x/2, 0, 0 ]) union() {
		cube([ plate_uk_square_part_x, plate_uk_square_part_y, thickness]);
		translate([ plate_uk_square_part_x-plate_uk_triangle_x, plate_uk_square_part_y, 0 ]) 
			right_triangle( plate_uk_triangle_x, plate_uk_triangle_y, thickness);
		translate([ plate_uk_triangle_x, plate_uk_square_part_y, 0 ]) mirror([ 1, 0, 0 ]) 
			right_triangle( plate_uk_triangle_x, plate_uk_triangle_y, thickness);
		translate([ plate_uk_triangle_x, plate_uk_square_part_y, 0 ]) 
			cube([ plate_uk_square_part_x - (2*plate_uk_triangle_x), plate_uk_triangle_y, thickness ]);
	}
}

/* 
 * style = "A" post forward, hole back;  "B" hole forward, post back; "C" hole-only fwd;  "D" hole-only back
 *			"E" post-only back;  "F" post-only fwd
 * hole_or_post = "H" or "P"  
 * 
 * NOTE that the pillars extend "height" above the plate's top surface
 */

module component_standoff( height, loc_y, style, hole_or_post ) {
	if (hole_or_post == "P") {
		if ((style == "A") || (style == "F")) {
			translate([ standoff_x, loc_y + (standoff_spacing/2), plate_thick ]) M3_mount_cyl_with_bolthole( height );
			translate([ -standoff_x, loc_y + (standoff_spacing/2), plate_thick ]) M3_mount_cyl_with_bolthole( height );
		}
		if ((style == "B") || (style == "E")) {
			translate([ standoff_x, loc_y - (standoff_spacing/2), plate_thick ]) M3_mount_cyl_with_bolthole( height );
			translate([ -standoff_x, loc_y - (standoff_spacing/2), plate_thick ]) M3_mount_cyl_with_bolthole( height );
		}
	} else {
		if ((style == "B") || (style == "C")) {
			translate([ standoff_x, loc_y + (standoff_spacing/2), -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2);
			translate([ -standoff_x, loc_y + (standoff_spacing/2), -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2);
		}
		if ((style == "A") || (style == "D")) {
			translate([ standoff_x, loc_y - (standoff_spacing/2), -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2);
			translate([ -standoff_x, loc_y - (standoff_spacing/2), -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2);
		}
	}
}


module component_sensor_mount_holes( lift, mode="holes" ) {
	if ((lift == 0) && (mode == "holes")) {
		translate([ -sensor_mount_hole_spacing/2, 0, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2);
		translate([ +sensor_mount_hole_spacing/2, 0, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2);
	}
	if ((lift > 0) && (mode == "adds")) {
		translate([ -sensor_mount_hole_spacing/2, 0, plate_thick ]) cylinder( d=mount_cone_top_dia, h=lift );
		translate([ +sensor_mount_hole_spacing/2, 0, plate_thick ]) cylinder( d=mount_cone_top_dia, h=lift );
	}
	if ((lift > 0) && (mode == "holes")) {
		if (TI30_use_threaded_insert == true) {
			translate([ -sensor_mount_hole_spacing/2, 0, -0.1 ]) cylinder( d=TI30_threaded_insert_dia, h=plate_thick+lift+0.2 );
			translate([ +sensor_mount_hole_spacing/2, 0, -0.1 ]) cylinder( d=TI30_threaded_insert_dia, h=plate_thick+lift+0.2 );
		} else {
			translate([ -sensor_mount_hole_spacing/2, 0, -0.1 ]) cylinder( d=M3_selftap_dia, h=plate_thick+lift+0.2 );
			translate([ +sensor_mount_hole_spacing/2, 0, -0.1 ]) cylinder( d=M3_selftap_dia, h=plate_thick+lift+0.2 );
		}
	}
}

