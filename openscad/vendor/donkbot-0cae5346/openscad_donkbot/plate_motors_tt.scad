/*
 * Module: plate_motors_tt.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates plates that include TT motors in addition
 * to line sensor or wall sensor modules, as well as motor driver boards,
 * ADC (analog-to-digital converter) breakouts, etc
 *
 * Project: DonKbot_mm
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

include <dkb_core.scad>;

// set visualizations flag (normally false, and should definitely be false when rendering for print)
// if true it shows the "bodies" of some parts to aid in visualizing spacing when settiup up plates
// currently used by plate_motors_nema8_stepper() and component_motormount_TT()
show_viz = false;

// (possibly) over-ride configuration 
TI20_use_threaded_insert = true;
TI25_use_threaded_insert = true;
TI30_use_threaded_insert = true;



/*
 ********************************************************************
 * select the part to be rendered
 ********************************************************************
 */
plate_motors_TT( 35, 2 );


/*
 ********************************************************************
 * modules creating plates
 ********************************************************************
 */

/*
 *  
 * 
 * NOTE that the pillars extend "height" above the plate's top surface
 * this needs 31x39 mm o-ring tires; 5 mm caster on back, 4mm on front,  and 32mm pillar height
 * @param caster_post_height:  	height of spacer ring at caster locations to provide room
 *								for screws if using short casters
 * adafruit yellow TT motors are 200 RPM
 */
module plate_motors_TT( pillar_height = 32, caster_post_height=2 ) {
	// these parameters are related to choice of board design
	wheel_x = 9;	// wheel hole "width"
	wheel_y = 39;	// wheel hole "length"
	wheel_center_y = 34;
	motormount_dist_from_ctr_x = 9;	// TT motors
	motormount_lift = 0;
	caster_front_y = 96.5;
	caster_mid_y = 76.5;
	caster_back_y = 8;

	wheel_adj = 4;	// this makes wheel slot fatter to eliminate round corner on outside edge
	difference() {
		union() { 
			component_plate( "E", pillar_height );
			// ADC board
			translate([ -15, adc_y, 1 ])  color([ 0, 0, 1 ]) component_adc_ads7830();

			// TB6612
			translate([ 18, adc_y, 1 ]) color([ 1, 0, 0 ]) component_tb6612();

			// motor mounts 
			translate([ motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
				component_motormount_TT( "R", motormount_lift, 3 );
			translate([ -motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
				component_motormount_TT( "L", motormount_lift, 3 );

			// add posts for sensor mount board (if lifted) 
			translate([ 0, sens_mount_y_front, 0 ]) component_sensor_mount_holes(sens_mount_lift_front, "adds");
			translate([ 0, sens_mount_y_back, 0 ]) component_sensor_mount_holes(sens_mount_lift_back, "adds");
	        translate([ -15, sens_mount_y_back - 4, plate_thick ]) linear_extrude(2) text("M3", 
	            size=5,  halign="center", font = "Liberation Sans:style=Bold");

	        // add posts for caster mount screw (if lifted)
	        if (caster_post_height > 0) {
				translate([ 0, caster_front_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
				//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
				translate([ 0, caster_back_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
	        }
		}
		// add holes for sensor mount board (if lifted)
		translate([ 0, sens_mount_y_front, 0 ]) component_sensor_mount_holes(sens_mount_lift_front, "holes");
		translate([ 0, sens_mount_y_back, 0 ]) component_sensor_mount_holes(sens_mount_lift_back, "holes");

		// wheel holes
		translate([ -(plate_x/2) + (wheel_x/2) - (wheel_adj/2), wheel_center_y, -0.1 ]) 
			roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );
		translate([  (plate_x/2) - (wheel_x/2) + (wheel_adj/2), wheel_center_y, -0.1 ]) 
			roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );

		// line sensor viewing hole
		translate([ 0, sens_mount_y_back + sensor_viewslot_offset, -0.1 ]) 
			roundedbox( viewslot_line_x, viewslot_line_y, 2, plate_thick+0.2);

		// side sensors viewing hole (start/stop sensor, curve start sensor)
		translate([ -viewslot_side_offset_x, sens_mount_y_back + viewslot_side_offset_y, -0.1 ])
			roundedbox(viewslot_side_x, viewslot_side_y, viewslot_side_y/2, plate_thick+0.2);
		translate([  viewslot_side_offset_x, sens_mount_y_back + viewslot_side_offset_y, -0.1 ])
			roundedbox(viewslot_side_x, viewslot_side_y, viewslot_side_y/2, plate_thick+0.2);

		// caster mount holes
		translate([ 0, caster_front_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_back_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);

		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );

	}
}

