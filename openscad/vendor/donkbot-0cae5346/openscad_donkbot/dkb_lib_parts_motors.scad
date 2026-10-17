/*
 * Module: dkb_lib_parts_motors.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates "mounts" for plastic TT motors.  Note that
 * this module is referenced by plate builder module plate_motors_tt.scad
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

//include <dkb_core.scad>;

/*
 * ****************************************************************************************
 * TT motors (various options)
 * purchase: https://www.adafruit.com/product/4638
 * "Yellow TT", "Blue TT", "DFR TT with Encoder Straight"
 *
 * purchase (yellow) plastic gears, bidirectional shaft 1:48 200 rpm: 
 *      https://www.adafruit.com/product/3777
 * purchase (blue) metal gears shaft only goes "out" 1:90 120rpm: 
 *      https://www.adafruit.com/product/3802 
 * purchase (with encoder) shaft only goes "out" 1:120 160 rpm: 
 *      https://www.dfrobot.com/product-1457.html
 *
 * Note internal dimensions from https://www.adafruit.com/product/3777
 *    but external dimensions inflated a little bit so it could dig body holes if needed
 *
 * on entry "errorstatus" false = display vis normal color, true = display as "DarkOrange"
 * *****************************************************************************************
 */

module component_motormount_TT( side = "L", lift = 0, thick = 3 ) {
	block_height = 24 + lift;
	block_length = 40;
	motor_body_width = 20;

	if (side == "L") {
		translate([ 0, 13, 0 ]) rotate([ 90, 0, -90 ]) difference() {
			cube([ block_length, block_height, thick ]);
			translate([ 12, (block_height/2) + lift,  thick+0.1 ]) component_TT_yellow_motor_holes(  );
		}
		if (show_viz) {
			translate([ -(motor_body_width + thick), -(block_length - 13), 0 ])  color([ 1, 0, 1 ]) 
				cube([ motor_body_width, block_length, 0.24 ]);
		}
	} else {
		translate([ thick, 13, 0 ]) rotate([ 90, 0, -90 ]) difference() {
			cube([ block_length, block_height, thick ]);
			translate([ 12, (block_height/2) + lift,  thick+0.1 ]) component_TT_yellow_motor_holes(  );
		}
		if (show_viz) {
			translate([ thick, -(block_length - 13), 0 ])  color([ 1, 0, 1 ]) cube([ motor_body_width, block_length, 0.24 ]);
		}
	}
}

/*
 * module component_TT_yellow_motor_holes() makes holes for mounting TT Motor
 * note that the part is generated in the xy plane with holes pointing "downward"
 * it is oriented with the axle at (0,0) and holes to the right of it ( +x)
 */
module component_TT_yellow_motor_holes( ) {
	full_depth_hole = 8; 		// (this is maximum "wall width" that these holes will be on)
	full_mount_slot_len = 30;	// length of slots "above" protrusions so motor can slide into mount

	// motor shaft
    translate([ 0, 0, -full_depth_hole ]) cylinder( r=(9/2), h=full_depth_hole+0.2 );  // the shaft hole
    translate([ 0-(7/2), 0, -full_depth_hole ]) cube([ 7, full_mount_slot_len, full_depth_hole ]);

    // slot for internal gear shaft
    translate([ 11.5, 0, -full_depth_hole ]) cylinder( d=6, h=full_depth_hole+0.2 );  
    translate([ 11.5-(6/2), 0, -full_depth_hole ]) cube([ 6, full_mount_slot_len, full_depth_hole+0.2 ]); 

    // slot for flexible band clamp
    translate([ 33, -4, -2 ]) cube([ 4, (8 + full_mount_slot_len), 2 ]);

    // M3 mounting holes
    translate([ 20.85, +(17.6/2), -full_depth_hole-0.1 ]) 
        cylinder( d=M3_selftap_dia, h=full_depth_hole+0.2 );    // mount hole M3
    translate([ 20.85, -(17.6/2), -full_depth_hole-0.1 ]) 
        cylinder( d=M3_selftap_dia, h=full_depth_hole+0.2 );    // mount hole M3
}