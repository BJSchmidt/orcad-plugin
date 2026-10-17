/*
 * Module: dkb_lib_parts_camera.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates "mounts" for common camera modules including
 * OpenMV cameras and raspberry pi camera modules
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
 *	20241204 - Initial Release
 */

//include <dkb_core.scad>;


//
//  NOTE: this module can be used as a library or to generate standalone parts
//  because it may be used as a library for camera mounts (ie from plate_motors_n20)
//  it is important that nothing is "uncommented" in the section below, EXCEPT FOR
//  whan you are actually using it to generate a standalone part ()
//

//component_openmv_mount();
//component_pillar(30, 10);



module component_openmv_mount() {
    base_thickness = 4;
    mount_height = 4;
    camera_mount_sep_x = 30;  // distance between mount holes
    camera_mount_offset = 18; // distance of holes from longway center of camera

    translate([ 0, -55/2, 0 ]) union() {
	    difference() {
	        union() {
	            roundedbox(44, 55, 3, base_thickness);
	            translate([ 0, 0, 0 ]) roundedbox(10, 55, 3, (base_thickness+mount_height));

	            translate([ -(camera_mount_sep_x/2), +camera_mount_offset, base_thickness ]) 
	                cylinder(d1=12, d2=7, h=(mount_height));
	            translate([ +(camera_mount_sep_x/2), +camera_mount_offset, base_thickness ]) 
	                cylinder(d1=12, d2=7, h=(mount_height));
	        }
	        translate([ -(camera_mount_sep_x/2), +camera_mount_offset, -0.1 ]) 
	            cylinder(d=M25_throughhole_dia, h=(base_thickness+mount_height+0.2));
	        translate([ +(camera_mount_sep_x/2), +camera_mount_offset, -0.1 ]) 
	            cylinder(d=M25_throughhole_dia, h=(base_thickness+mount_height+0.2));
	    }
	    translate([ -16, -6, base_thickness-1]) rotate([ 0, 0, -90 ]) linear_extrude(2) text("OpenMV", 
	        size=6,  halign="center", font = "Liberation Sans:style=Bold");
	    translate([ 16, -6, base_thickness-1]) rotate([ 0, 0, 90 ]) linear_extrude(2) text("M2.5", 
	        size=6,  halign="center", font = "Liberation Sans:style=Bold");
	 }
}

module component_rpicam_mount() {
    base_thickness = 4;
    mount_height = 4;
    camera_mount_sep_x = 21;  // distance between mount holes
    camera_mount_sep_y = 13;  // distance between mount holes

    difference() {
        union() {
            roundedbox(44, 36, 3, base_thickness);

            translate([ -(camera_mount_sep_x/2), +camera_mount_sep_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));
            translate([ +(camera_mount_sep_x/2), +camera_mount_sep_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));

            translate([ -(camera_mount_sep_x/2), -camera_mount_sep_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));
            translate([ +(camera_mount_sep_x/2), -camera_mount_sep_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));

            translate([0, 17, base_thickness]) rotate([ 0, 0, 180 ]) linear_extrude(1) text("M2", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
            translate([0, -11, base_thickness]) rotate([ 0, 0, 180 ]) linear_extrude(1) text("RPi Cam", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
        }
        translate([ -(camera_mount_sep_x/2), +camera_mount_sep_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));
        translate([ +(camera_mount_sep_x/2), +camera_mount_sep_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));

        translate([ -(camera_mount_sep_x/2), -camera_mount_sep_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));
        translate([ +(camera_mount_sep_x/2), -camera_mount_sep_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));
    }
}

/*
 * module part_openMVcam_pillar() creates a bolt-on pillar for openMV camera
 * note that show_viz displays front edges of plate above and plate below to aid 
 * 		in ensuring that board doesn't collide with either plate; 
 *		for this purpose it is assumed that plate-above is 29mm above plate-below
 * note it is best to print this with supports, regardless of downAngle, so that
 *		it doesn't topple over during print due to unsupported weight to front...
 */
module component_pillar(cameraDownAngle=35, lift=10 ) {
	if (cameraDownAngle > 34) {
	    difference() {
	        roundedbox(60, 18, 3, 3);
	        translate([ -sensor_mount_hole_spacing/2, -6, -0.1 ]) cylinder(d=M3_throughhole_dia, 3.2 );
	        translate([  sensor_mount_hole_spacing/2, -6, -0.1 ]) cylinder(d=M3_throughhole_dia, 3.2 );
	    }

	    translate([ 0, 5, 2 ]) rotate([ -cameraDownAngle, 0, 0 ])
	        difference() {
	        	union() {
	            	roundedbox(20, 6, 3, 50);
	            	translate([ 0, -3, lift ]) rotate([ -90, 0, 0 ])  component_openmv_mount();
	        	}
	        }

	    translate([ 0, -5, 2]) rotate([ 0, 0, 0 ]) linear_extrude(2) text(str( cameraDownAngle, " deg"), 
	        size=6,  halign="center", font = "Liberation Sans:style=Bold");

	     if (show_viz == true) {
	     	translate([ -50/2, -6, 29 ]) color([ 0.7, 0.7, 0.7 ]) cube([ 50, 24, 2 ]);
	     	translate([ -50/2, -6, -(3+2) ]) color([ 0.7, 0.7, 0.7 ]) cube([ 50, 24, 2 ]);
	     }
	 } else if (cameraDownAngle > 17) {
	    difference() {
	        roundedbox(60, 24, 3, 3);
	        translate([ -sensor_mount_hole_spacing/2, -9, -0.1 ]) cylinder(d=M3_throughhole_dia, 3.2 );
	        translate([  sensor_mount_hole_spacing/2, -9, -0.1 ]) cylinder(d=M3_throughhole_dia, 3.2 );
	    }

	    translate([ 0, 10, 2 ]) rotate([ -cameraDownAngle, 0, 0 ])
	        difference() {
	        	union() {
	            	roundedbox(20, 6, 3, 50);
	            	translate([ 0, -3, lift ]) rotate([ -90, 0, 0 ])  component_openmv_mount();
	        	}
	        }

	    translate([ 0, -5, 2]) rotate([ 0, 0, 0 ]) linear_extrude(2) text(str( cameraDownAngle, " deg"), 
	        size=6,  halign="center", font = "Liberation Sans:style=Bold");

	     if (show_viz == true) {
	     	translate([ -50/2, -9, 29 ]) color([ 0.7, 0.7, 0.7 ]) cube([ 50, 24, 2 ]);
	     	translate([ -50/2, -9, -(3+2) ]) color([ 0.7, 0.7, 0.7 ]) cube([ 50, 24, 2 ]);
	     }
	 }
}