/*
 * Module: dkb_lib_parts_switches_batts.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates "mounts" for batteries (including 9v, AA, and 
 * 18650), switches, and fuse holders
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


module component_9v_batt() {
	batt_len = 46;
	batt_width = 26;
	batt_thick = 18;
	base_thick = 2;
	sidewall_thick = 2;

	translate([ -(batt_width+(2*sidewall_thick))/2, 0, 0 ]) union() {
		cube([batt_width+(2*sidewall_thick), batt_len+(2*sidewall_thick), base_thick]);

		// back wall
		translate([ 0, batt_len + sidewall_thick, base_thick ])
			cube([ batt_width+(2*sidewall_thick), sidewall_thick, batt_thick]);	// back wall

		// front retainer
		translate([ 0, 0, base_thick ])
			cube([ batt_width+(2*sidewall_thick), sidewall_thick, 2]);	// back wall

		// left wall
		translate([ 0, 0, base_thick ]) cube([ sidewall_thick, batt_len+(2*sidewall_thick), 6]);

		// left hook
		translate([ 0, batt_len/2, base_thick ]) 
			cube([ sidewall_thick, 8, batt_thick ]);
		translate([ 4, batt_len/2 + 8, base_thick + batt_thick ]) rotate([ 0, 180, 90 ]) 
			prism_lwh(8, 4, 2);

		// right hook
		translate([ batt_width + sidewall_thick, batt_len/2, base_thick ]) 
			cube([ sidewall_thick, 8, batt_thick ]);
		translate([ batt_width, batt_len/2, base_thick + batt_thick ]) rotate([ 0, 180, -90 ]) 
			prism_lwh(8, 4, 2);

		// right wall
		translate([ batt_width + sidewall_thick, 0, base_thick ]) cube([ sidewall_thick, batt_len+(2*sidewall_thick), 6]);
	}
}


/*
 * ****************************************************************************************
 * standard mini toggle switch
 * purchase:  https://www.adafruit.com/product/3220   or equivalent
 * purchase:  https://www.amazon.com/yueton-Terminals-Position-Toggle-Switch/dp/B013DZB6CO/
 * purchase:  https://www.amazon.com/MTS-101-Position-Miniature-Toggle-Switch/dp/B0799LBFNY
 * *****************************************************************************************
 */

module component_mini_toggle_switch_holes() {        
    // makes a hole for standard mini-toggle switch 7.5mm dia
    // this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)

    hole_dia = 6.5;
    hole_radius = hole_dia / 2;
    keyhole_long = 3;
    keyhole_wide = 2;
    keyhole_distance = 6.4; // distance away from center of switch hole
    switch_body_width = 13;
    switch_body_depth = 10; 

    // note through-hole extra thick so if on lid it would go all the way through any board mounts placed over it
    translate([ 0, 0, -0.1 ]) cylinder( r=hole_radius, h=8 );

    translate([ -(keyhole_long/2), (keyhole_distance-(keyhole_wide/2)), -0.1 ]) 
        cube([ keyhole_long, keyhole_wide, 8 ]);
    
    translate([ -(keyhole_long/2), -(keyhole_distance+(keyhole_wide/2)), -0.1 ]) 
        cube([ keyhole_long, keyhole_wide, 8 ]);
}

batt_18650_tube_dia = 18+1;
batt_18650_tube_len = 67;
batt_18650_case_width = 42;
batt_18650_case_height = 17;
batt_18650_batt_separation = 20;
batt_18650_height_of_dimple = 10;
batt_18650_spring_len = 4;			// (very gently compressed)
batt_18650_endpiece_thick = 5;

// note the full length of the case enclosing the batteries is batt_18650_holder_system_length
// but part of it is in the "mount_block" part and part of it is in the "door_block" part
// this is to allow the batteries to help "align" the door part

batt_18650_holder_system_length = batt_18650_endpiece_thick + batt_18650_tube_len + batt_18650_spring_len + batt_18650_endpiece_thick;
batt_18650_mount_block_portion_len = 55;	// (not including endpiece or spring) -- was 65
batt_18650_door_block_portion_len = (batt_18650_tube_len - batt_18650_mount_block_portion_len);	// (not including endpiece)

module part_batt_18650_door() {
	difference() {
		union() {
			component_batt_18650_connector_endpiece();
			component_batt_18650_tube_casing( batt_18650_door_block_portion_len );
			translate([ -batt_18650_endpiece_thick, -7/2, batt_18650_case_height ]) cube([ batt_18650_endpiece_thick+batt_18650_door_block_portion_len, 7, 4 ]);
		}
		translate([ -batt_18650_endpiece_thick-0.1, 0, batt_18650_case_height + 1 ]) rotate([ 0, 90, 0 ]) 
			cylinder( d=M3_throughhole_dia, h=batt_18650_endpiece_thick+batt_18650_door_block_portion_len + 0.2);
	}
}
module component_batt_18650_mount() {
	difference() {
		union() {
			cube([ batt_18650_holder_system_length, batt_18650_case_width, 1 ]);
			translate([ batt_18650_endpiece_thick, batt_18650_case_width/2, 1 ]) 
				component_batt_18650_tube_casing( batt_18650_mount_block_portion_len + batt_18650_spring_len );
			translate([ batt_18650_endpiece_thick, batt_18650_case_width/2, 1 ]) component_batt_18650_connector_endpiece();
			translate([ batt_18650_mount_block_portion_len + batt_18650_endpiece_thick + batt_18650_spring_len - 8, batt_18650_case_width/2-7/2, batt_18650_case_height + 1 ])
					cube([ 8, 7, 4 ]);
		}
		if (TI30_use_threaded_insert) {
			translate([ batt_18650_mount_block_portion_len + batt_18650_endpiece_thick + batt_18650_spring_len - 8.1, batt_18650_case_width/2, batt_18650_case_height + 2 ]) rotate([ 0, 90, 0 ]) 
				cylinder( d=TI30_threaded_insert_dia, h=8.2);
		} else {
			translate([ batt_18650_mount_block_portion_len + batt_18650_endpiece_thick + batt_18650_spring_len - 8.1, batt_18650_case_width/2, batt_18650_case_height + 2 ]) rotate([ 0, 90, 0 ]) 
				cylinder( d=M3_selftap_dia, h=8.2);
		}
	}	
}

module component_batt_18650_tube_casing( block_len ) {

	 difference () {
		translate([ 0, -batt_18650_case_width/2, 0 ]) 
			cube([ block_len, batt_18650_case_width, batt_18650_case_height ]);
		translate([ -0.1, -batt_18650_batt_separation/2, batt_18650_height_of_dimple ]) 
			rotate([ 0, 90, 0 ]) cylinder ( d=batt_18650_tube_dia, h=batt_18650_tube_len + 3.2);
		translate([ -0.1, batt_18650_batt_separation/2, batt_18650_height_of_dimple ]) 
			rotate([ 0, 90, 0 ]) cylinder ( d=batt_18650_tube_dia, h=batt_18650_tube_len + 3.2);
	}
}

/*
 * connector endpiece is build in YZ plane, centered left and right, and moving from x=0 into (negative x)
 */
module component_batt_18650_connector_endpiece() {

	rotate([ 0, 0, 90 ]) difference() {
		translate([ -batt_18650_case_width/2, 0, 0 ]) cube([ batt_18650_case_width, batt_18650_endpiece_thick, batt_18650_case_height ]);
		translate([ -(batt_18650_batt_separation/2), -0.1, batt_18650_height_of_dimple ]) component_battery_clip( 20 );
		translate([  (batt_18650_batt_separation/2), -0.1, batt_18650_height_of_dimple ]) component_battery_clip( 20 );
	}
}

/* 
 * mount for keystone battery clip
 * purchase link (dimple): https://www.digikey.com/en/products/detail/SN-T5-2/SN-T5-2-ND/2439587  (keystone SN-T5-2)
 * purchase link (spring): https://www.digikey.com/en/products/detail/SN-T5-1/SNT5-1-ND/2439583   (keystone SN-T5-1)
 *
 * @param: clip_height  height of slots (note this is more than actual height of clip itself
 *						because it actually must be as tall as enclosing block so clip can slide 
 *						into place...
 * @param: dimple_height	height of battery sprint or dimple above bottom of slot
 *
 * note when using the keystorn clips, the spring compresses to about 4 mm when battery is inserted
 * this should be printed in "upright" orientation due to thin-ness of slot
 * this is generated in that "upright" orientation with origin at center of spring or dimple, and hole moving into (+) y direction
 */
module component_battery_clip( clip_height ) {
	clip_width = 12;	// main body of clip
	clip_thick = 0.7;	// thickness of slot
	clip_ctr = 6.5;		// height from bottom of clip to center of spring or dimple
	window_width = 9;	// width of window at "front" of clip
	window_thick = 1.0;	// thickness of window (basically strength of front of slot...)
	back_clearance_slit_width = 5;
	back_clearance_slit_depth = 1.0;

	translate([ -clip_width/2, 0, 0 ]) union() {
		translate([ 0, window_thick, -clip_ctr ]) cube([ clip_width, clip_thick, clip_height]);
		translate([ (clip_width - window_width)/2, 0, -clip_ctr ]) cube([ window_width, window_thick, clip_height]);
		translate([ (clip_width - back_clearance_slit_width)/2, (window_thick+clip_thick), -clip_ctr ]) 
			cube([ back_clearance_slit_width, back_clearance_slit_depth, clip_height]);
	}
}

module test_batt_clip() {
	difference() {
		cube([ 44, 6, 8 ]);

		//translate([ 3, 1, 2 ]) cube([ 11, 0.5, 8]);
		//translate([ 4, -0.1, 2 ]) cube([ 9, 1.1, 8]);

		translate([ 17, 1, 2 ]) cube([ 11, 0.7, 8]);
		translate([ 18, -0.1, 2 ]) cube([ 9, 1.1, 8]);

		//translate([ 31, 1, 2 ]) cube([ 11, 0.9, 8]);
		//translate([ 32, -0.1, 2 ]) cube([ 9, 1.1, 8]);
	}
}

fuseblock_width = 30; 
fuseblock_height = 7;
fuseblock_length = 23; // note this should be (length_of_cavity + 2)


/*
 * module fuse_holder_lid()
 * this creates a cover (lid) for the fuseblock
 * this is created in xy plane, centered at origin
 */
module part_fuse_holder_lid() {
    difference() {
        //translate([ -((fuseblock_length-5)/2), -(fuseblock_width/2), 0 ]) cube([ (fuseblock_length-5), fuseblock_width, 2 ]); 
       	roundedbox( (fuseblock_length-5), fuseblock_width, 2, 2 ); 

        // mount holes for lid
        translate([ -((fuseblock_length-5)/2)+8, -(fuseblock_width/2)+3, -0.1 ]) 
            cylinder(d=M3_throughhole_dia, h=fuseblock_height + 0.2);
        translate([ -((fuseblock_length-5)/2)+8, +(fuseblock_width/2)-3, -0.1 ]) 
            cylinder(d=M3_throughhole_dia, h=fuseblock_height + 0.2);
    }
}

module component_fuse_holder_mount(block_height = 3) {
	difference() {
		roundedbox( 14, fuseblock_width, 2, block_height);

        // mount holes for lid
        translate([ 0, -(fuseblock_width/2)+3, -0.1 ]) 
            cylinder(d=TI30_threaded_insert_dia, h=fuseblock_height + 0.2);
        translate([ 0, +(fuseblock_width/2)-3, -0.1 ]) 
            cylinder(d=TI30_threaded_insert_dia, h=fuseblock_height + 0.2);
     }
}

/*
 * ***************************************************************************
 * this makes a holder for automotive blade type fuses
 *
 * this is made to fit these blade connectors: 
 *     https://www.amazon.com/Baomain-disconnects-Insulated-Connector-Electrical/dp/B01G4POUAU/
 *
 * inspired by: https://www.thingiverse.com/thing:1787609
 *
 * @param mounthole = "selftap", "insert",  "passthrough", "auto"
 *
 * ***************************************************************************
 */

module component_fuse_holder_block( mounthole = "selftap") {
    blade_separation = 10; 
    
        difference() {
            // but note its actually GENERATED flat on XY plane with "front" to right (+X)
            roundedbox( fuseblock_length, fuseblock_width, 2, fuseblock_height );   

            translate([ 0, -blade_separation/2, 0 ]) fuse_cavity();        
            translate([ 0, +blade_separation/2, 0 ]) fuse_cavity();
            
	        // mount holes for lid 
	        if (mounthole == "insert") {
	            translate([ -(fuseblock_length/2) + 8, -(fuseblock_width/2)+3, -0.1 ]) 
	                cylinder(d=TI30_threaded_insert_dia, h=fuseblock_height + 0.2);
	            translate([ -(fuseblock_length/2) + 8, +(fuseblock_width/2)-3, -0.1 ]) 
	                cylinder(d=TI30_threaded_insert_dia, h=fuseblock_height + 0.2);
	        } 
	        if (mounthole == "passthrough") {
	            translate([ -(fuseblock_length/2) + 8, -(fuseblock_width/2)+3, -0.1 ]) 
	                cylinder(d=M3_throughhole_dia, h=fuseblock_height + 0.2);
	            translate([ -(fuseblock_length/2) + 8, +(fuseblock_width/2)-3, -0.1 ]) 
	                cylinder(d=M3_throughhole_dia, h=fuseblock_height + 0.2);
	        } 
	        if (mounthole == "selftap") {
	            translate([ -(fuseblock_length/2) + 8, -(fuseblock_width/2)+3, -0.1 ]) 
	                cylinder(d=M3_selftap_dia, h=fuseblock_height + 0.2);
	            translate([ -(fuseblock_length/2) + 8, +(fuseblock_width/2)-3, -0.1 ]) 
	                cylinder(d=M3_selftap_dia, h=fuseblock_height + 0.2);
	        }
	        if (mounthole == "auto") {
	        	if (TI30_use_threaded_insert) {
		            translate([ -(fuseblock_length/2) + 8, -(fuseblock_width/2)+3, -0.1 ]) 
		                cylinder(d=TI30_threaded_insert_dia, h=fuseblock_height + 0.2);
		            translate([ -(fuseblock_length/2) + 8, +(fuseblock_width/2)-3, -0.1 ]) 
		                cylinder(d=TI30_threaded_insert_dia, h=fuseblock_height + 0.2);
	        	} else {
		            translate([ -(fuseblock_length/2) + 8, -(fuseblock_width/2)+3, -0.1 ]) 
		                cylinder(d=M3_selftap_dia, h=fuseblock_height + 0.2);
		            translate([ -(fuseblock_length/2) + 8, +(fuseblock_width/2)-3, -0.1 ]) 
		                cylinder(d=M3_selftap_dia, h=fuseblock_height + 0.2);
		        }
		    }

            // window in front so fuse can seat in "deeper"
            translate([ (fuseblock_length/2)-2, -1.6, 4 ]) cube([ 3, 3.2, 4.2 ]); 
        }
}

/*
 * module hole_for_fuseblock()
 * this creates a hole in the backpanel that accepts fuseblock 
 * this is created in xy plane, centered at origin
 */
module hole_for_fuseblock() {
    window_width = 20;
    window_height = 4;

    //translate([ -fuseblock_width/2, -fuseblock_height/2, -0.1 ]) cube([ fuseblock_width, fuseblock_height, 3.2 ]);  // removed 1/24
    translate([ 0, -2, -0.1 ]) roundedbox( window_width, window_height, (window_height/2), 3.2 );
}


/*
 * module fuse_cavity
 * this is a subcomponent, part of the fuseblock 
 *     it creates one blade cavity
 * this is created in xy plane, centered at origin
 */
module fuse_cavity() {
    width_of_blade = 6.5;
    width_of_blade_cavity = 8.5;
    length_of_cavity = 21; 
    depth_of_cavity_wire_part = 5.5;
    depth_of_cavity_blade_part = 4;
    depth_of_access_hole_blade = 3;
    length_of_blade_part = 8;
    length_of_deep_part = length_of_cavity - length_of_blade_part; 
    front_edge_of_cavity = (fuseblock_length / 2) - 1;
    random_big = 20;
    random_small = 5;
    
    // shelf for bottom of contact (blade)
    translate([ (front_edge_of_cavity - length_of_blade_part), 
                -(width_of_blade_cavity/2), 
                (fuseblock_height - depth_of_cavity_blade_part) ]) 
                    cube([ length_of_blade_part, width_of_blade_cavity, random_big ]);    
    
    translate([ (front_edge_of_cavity - length_of_blade_part), 
                -(width_of_blade_cavity/2), 
                (fuseblock_height - depth_of_cavity_blade_part) ]) 
                    cube([ length_of_blade_part, width_of_blade_cavity, random_big ]);
    
    // shelf for bottom of wire crimp area
    translate([ (front_edge_of_cavity - length_of_cavity), 
                -(width_of_blade_cavity/2), 
                (fuseblock_height - depth_of_cavity_wire_part) ]) 
                    cube([ length_of_deep_part + 0.1, width_of_blade_cavity, random_big ]);
     
     // front access hole for blade
     translate([ front_edge_of_cavity-4, -(width_of_blade+0.5)/2, (fuseblock_height - depth_of_access_hole_blade) ])
        cube([ random_big, (width_of_blade+0.5), random_big ]);
        
     // back access hole for wire
     translate([ -(fuseblock_length/2)-0.1, -(depth_of_cavity_wire_part-1)/2, (fuseblock_height - depth_of_cavity_wire_part) ])
        cube([ random_small, depth_of_cavity_wire_part-1, random_big ]);
}

module component_power_selector_mount( want_labels = false ) {
	difference() {			
		translate([ -10, 0, 0 ]) cube([ 20, 4, 20 ]); // power switch mounting stub
		translate([ 0, 0, 10 ]) rotate([ -90, 90, 0 ]) component_mini_toggle_switch_holes();
	}
	if (want_labels) {
        translate([ -5, -7, 0] ) linear_extrude(1) rotate([ 0, 0, 90 ]) text("USB", 
            size=4,  halign="center", font = "Liberation Sans:style=Bold");
        translate([ 7, -7, 0 ]) linear_extrude(1) rotate([ 0, 0, 90 ]) text("BAT", 
            size=4,  halign="center", font = "Liberation Sans:style=Bold");
	}
	if (show_viz) {
		translate([ -6.5, 4, 7 ]) color ([ 1, 0, 1 ]) cube([ 13, 15, 6 ]);
	}
}

module component_power_selector_mount_dual( want_labels = false ) {
	difference() {			
		translate([ -10, 0, 0 ]) cube([ 20, 4, 26 ]); // power switch mounting stub
		translate([ 0, 0, 8 ]) rotate([ -90, 90, 0 ]) component_mini_toggle_switch_holes();
		translate([ 0, 0, 20 ]) rotate([ -90, 90, 0 ]) component_mini_toggle_switch_holes();
	}
	if (want_labels) {
        translate([ -5, -7, 0] ) linear_extrude(1) rotate([ 0, 0, 90 ]) text("USB", 
            size=4,  halign="center", font = "Liberation Sans:style=Bold");
        translate([ 7, -7, 0 ]) linear_extrude(1) rotate([ 0, 0, 90 ]) text("BAT", 
            size=4,  halign="center", font = "Liberation Sans:style=Bold");
	}
	if (show_viz) {
		translate([ -6.5, 4, 5 ]) color ([ 1, 0, 1 ]) cube([ 13, 15, 6 ]);
		translate([ -6.5, 4, 17 ]) color ([ 1, 0, 1 ]) cube([ 13, 15, 6 ]);
	}
}


module component_power_switch_mount( want_labels = false ) {
	difference() {			
		translate([ -8, 0, 0 ]) cube([ 16, 4, 20 ]); // power switch mounting stub
		translate([ 0, 0, 10 ]) rotate([ -90, 0, 0 ]) component_mini_toggle_switch_holes();
	}
	if (want_labels) {
        translate([ -0, -12, 0] ) linear_extrude(1) rotate([ 0, 0, 0 ]) text("PWR", 
            size=4,  halign="center", font = "Liberation Sans:style=Bold");
	}
	if (show_viz) {
		translate([ -4, 4, 3.5 ]) color ([ 1, 0, 1 ]) cube([ 8, 15, 13 ]);
	}
}