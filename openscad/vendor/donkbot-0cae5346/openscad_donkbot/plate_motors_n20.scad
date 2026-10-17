/*
 * Module: plate_motors_n20.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates plates that include n20 motors in addition
 * to line sensor or wall sensor modules, as well as motor driver boards,
 * ADC (analog-to-digital converter) breakouts, etc
 *
 * Project:   DonKbot_mm
 * Author(s): Don Korte
 * github:    https://github.com/dnkorte/donkbot
 *
 * per david hannaford (UKMARS mailing list feb 10 2025):  *
 * 	https://shop.pimoroni.com/products/micro-metal-gearmotor-extended-back-shaft?variant=32587847050
 *
 * The 20:1 will get you around 1000 RPM at the drive shaft. With a standard 32mm diameter wheel 
 * that goes with the motors that will get you 100mm per revolution and a top speed of 1.6meters 
 * per second. The 11:1 will get you around 1800 RPM and a potential top speed of 2.8 meters per 
 * second which is probably a lot faster than you can control initially. The 20:1 will give you 
 * more torque so you will be able to accelerate better and the mouse will be easier to control 
 * which is helpful when you are building and coding your first mouse, but you can easily 
 * upgrade to the 11:1 ones if you find you need the extra speed.
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
 *
 */

include <dkb_core.scad>;
include <dkb_lib_parts_camera.scad>

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
//plate_motors_n20( 29, 0 );
//plate_motors_n20_enc(35, 0);				// good for n20 line follower
//plate_motors_n20_enc_tof_qtpy( 30 );
//plate_motors_n20_enc_tof_mux( 35 ); 		// i2c mux with 3 adafruit ToF
//plate_motors_n20_enc_cam(30, 0);
plate_motors_n20_enc_tofp_qtpy( 30 );

/*
 *  
 * 
 * NOTE that the pillars extend "height" above the plate's top surface
 * this uses 28x36 mm o-ring wheels
 * @param caster_post_height:  	height of spacer ring at caster locations to provide room
 *								for screws if using short casters
 * adafruit 1:50 N20 motors are spec-ed at 200 RPM
 * pimoroni 1:20 N20 motors are spec-ed at 1000 RPM 
 */
module plate_motors_n20( pillar_height = 29, caster_post_height=2 ) {
	// these parameters are related to choice of board design
	wheel_x = 9;	// wheel hole "width"
	wheel_y = 39;	// wheel hole "length"
	wheel_center_y = 37;
	motormount_dist_from_ctr_x = 17;	// adafruit N20 motors
	motormount_hole_spacing = 18;
	motormount_lift = 3;
	caster_front_y = 96.5;
	caster_mid_y = 76.5;
	caster_back_y = 8;

	wheel_adj = 4;	// this makes wheel slot fatter to eliminate round corner on outside edge
	difference() {
		union() { 
			component_plate( "E", pillar_height );
			// ADC board
			translate([ 0, adc_y, 1 ])  color([ 0, 0, 1 ]) component_adc_ads7830();

			// TB6612
			translate([ 18, 12, 1 ]) color([ 1, 0, 0 ]) component_tb6612();

			// lift for motor mounts (left)
			if (motormount_lift > 0) {
				translate([ -motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ 0, wheel_center_y, plate_thick ]) 
					roundedbox(plate_x - (2 * wheel_x), 9, 2, motormount_lift);
		        translate([ -5, wheel_center_y - (motormount_hole_spacing/2) - 3, plate_thick ]) linear_extrude(2) text("M25", 
		            size=5,  halign="center", font = "Liberation Sans:style=Bold");
			}

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

		if (TI25_use_threaded_insert == true) {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
		} else {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);		
		}

		// caster mount holes
		translate([ 0, caster_front_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_back_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);

	}
}


/*
 *  
 * 
 * NOTE that the pillars extend "height" above the plate's top surface
 * this uses 28x36 mm o-ring wheels
 * @param caster_post_height:  	height of spacer ring at caster locations to provide room
 *								for screws if using short casters
 * adafruit 1:50 N20 motors are spec-ed at 200 RPM
 * pimoroni 1:20 N20 motors are spec-ed at 1000 RPM 
 */
module plate_motors_n20_enc( pillar_height = 29, caster_post_height=2 ) {
	// these parameters are related to choice of board design
	wheel_x = 9;	// wheel hole "width"
	wheel_y = 39;	// wheel hole "length"
	wheel_center_y = 37;
	motormount_dist_from_ctr_x = 17;	// adafruit N20 motors
	motormount_hole_spacing = 18;
	motormount_lift = 3;
	caster_front_y = 96.5;
	caster_mid_y = 76.5;
	caster_back_y = 8;

	wheel_adj = 4;	// this makes wheel slot fatter to eliminate round corner on outside edge
	difference() {
		union() { 
			component_plate( "E", pillar_height );
			// ADC board
			translate([ -16, adc_y, 1 ])  color([ 0, 0, 1 ]) component_adc_ads7830();

			// TB6612
			translate([ 18, adc_y, 1 ]) color([ 1, 0, 0 ]) component_tb6612();

			// protoboard for motor wiring headers
			translate([ 0, 7, 0 ]) color ([ 1, 0, 0 ]) component_smallmintproto();

			// lift for motor mounts (left)
			if (motormount_lift > 0) {
				translate([ -motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ 0, wheel_center_y, plate_thick ]) 
					roundedbox(plate_x - (2 * wheel_x), 9, 2, motormount_lift);
		        translate([ -5, wheel_center_y - (motormount_hole_spacing/2) - 3, plate_thick ]) linear_extrude(2) text("M25", 
		            size=5,  halign="center", font = "Liberation Sans:style=Bold");
			}

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

		if (TI25_use_threaded_insert == true) {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
		} else {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);		
		}

		// caster mount holes
		translate([ 0, caster_front_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_back_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);

        // clean out spot for caster mount bolt head (useful if board mount is at rear of plate)
        if (caster_post_height == 0) {
			//translate([ 0, caster_front_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
			//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
			translate([ 0, caster_back_y, plate_thick ]) cylinder( d=8, h=5);
        }

		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );

	}
}

/*
 *  
 * 
 * NOTE that the pillars extend "height" above the plate's top surface
 * this uses 28x36 mm o-ring wheels
 * @param caster_post_height:  	height of spacer ring at caster locations to provide room
 *								for screws if using short casters
 * adafruit 1:50 N20 motors are spec-ed at 200 RPM
 * pimoroni 1:20 N20 motors are spec-ed at 1000 RPM 
 */
module plate_motors_n20_enc_tof_qtpy( pillar_height = 29, caster_post_height=2 ) {
	// these parameters are related to choice of board design
	wheel_x = 9;	// wheel hole "width"
	wheel_y = 39;	// wheel hole "length"
	wheel_center_y = 37;
	motormount_dist_from_ctr_x = 17;	// adafruit N20 motors
	motormount_hole_spacing = 18;
	motormount_lift = 3;
	caster_front_y = 96.5;
	caster_mid_y = 76.5;
	caster_back_y = 8;

	wheel_adj = 4;	// this makes wheel slot fatter to eliminate round corner on outside edge
	difference() {
		union() { 
			component_plate( "E", pillar_height );
			// ADC board
			//translate([ -16, adc_y, 1 ])  color([ 0, 0, 1 ]) component_adc_ads7830();

			// TB6612
			translate([ -14, 68, 1 ]) color([ 1, 0, 0 ]) rotate([ 0, 0, 90 ]) component_tb6612();

			// protoboard for motor wiring headers
			translate([ 0, 7, 0 ]) color ([ 1, 0, 0 ]) component_smallmintproto();

			// lift for motor mounts (left)
			if (motormount_lift > 0) {
				translate([ -motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ 0, wheel_center_y, plate_thick ]) 
					roundedbox(plate_x - (2 * wheel_x), 9, 2, motormount_lift);
		        translate([ -5, wheel_center_y - (motormount_hole_spacing/2) - 3, plate_thick ]) linear_extrude(2) text("M25", 
		            size=5,  halign="center", font = "Liberation Sans:style=Bold");
			}

	        // add posts for caster mount screw (if lifted)
	        if (caster_post_height > 0) {
				//translate([ 0, caster_front_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
				//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
				translate([ 0, caster_back_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
	        }

	        // pico for ToF sensors
	        translate([ 18, 73, 2 ]) color([ 1, 0, 0 ])  rotate([ 0, 0, 90 ]) component_qtpy(); 

	        // tof sensor mounts, left and right sides
	      	translate([ 0, 87, 0]) rotate([ 0, 0, 0 ]) adafruit_tof_sensor_vertical( 3 ); 	// front
	      	translate([ 33, 92, 0 ]) rotate([ 0, 0, -90 ]) adafruit_tof_sensor_vertical( 3 ); 	// right
	      	translate([ -33, 92, 0 ]) rotate([ 0, 0, 90 ]) adafruit_tof_sensor_vertical( 3 ); 	// left
	     } 
		
		// wheel holes
		translate([ -(plate_x/2) + (wheel_x/2) - (wheel_adj/2), wheel_center_y, -0.1 ]) 
			roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );
		translate([  (plate_x/2) - (wheel_x/2) + (wheel_adj/2), wheel_center_y, -0.1 ]) 
			roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );

		if (TI25_use_threaded_insert == true) {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
		} else {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);		
		}

		// caster mount holes
		translate([ 0, caster_front_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_back_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);

        // clean out spot for rear caster mount bolt head (useful if board mount is at rear of plate)
        if (caster_post_height == 0) {
			translate([ 0, caster_front_y, plate_thick ]) cylinder( d=7, h=5);
			//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
			translate([ 0, caster_back_y, plate_thick ]) cylinder( d=8, h=5);
        }

		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );

	}
}

/*
 *  
 * 
 * NOTE that the pillars extend "height" above the plate's top surface
 * this uses 28x36 mm o-ring wheels
 * @param caster_post_height:  	height of spacer ring at caster locations to provide room
 *								for screws if using short casters
 * adafruit 1:50 N20 motors are spec-ed at 200 RPM
 * pimoroni 1:20 N20 motors are spec-ed at 1000 RPM 
 */
module plate_motors_n20_enc_tof_mux( pillar_height = 29, caster_post_height=2 ) {
	// these parameters are related to choice of board design
	wheel_x = 9;	// wheel hole "width"
	wheel_y = 39;	// wheel hole "length"
	wheel_center_y = 37;
	motormount_dist_from_ctr_x = 17;	// adafruit N20 motors
	motormount_hole_spacing = 18;
	motormount_lift = 3;
	caster_front_y = 96.5;
	caster_mid_y = 76.5;
	caster_back_y = 8;

	wheel_adj = 4;	// this makes wheel slot fatter to eliminate round corner on outside edge
	difference() {
		union() { 
			component_plate( "E", pillar_height );

			// TB6612
			translate([ -20, 68, 1 ]) color([ 1, 0, 0 ]) rotate([ 0, 0, 90 ]) component_tb6612();

			// protoboard for motor wiring headers (or encoder i/f PCB)
			translate([ 0, 6, 0 ]) color ([ 1, 0, 0 ]) component_smallmintproto();

			// lift for motor mounts (left)
			if (motormount_lift > 0) {
				translate([ -motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ 0, wheel_center_y, plate_thick ]) 
					roundedbox(plate_x - (2 * wheel_x), 9, 2, motormount_lift);
		        translate([ -5, wheel_center_y - (motormount_hole_spacing/2) - 3, plate_thick ]) linear_extrude(2) text("M25", 
		            size=5,  halign="center", font = "Liberation Sans:style=Bold");
			}

	        // add posts for caster mount screw (if lifted)
	        if (caster_post_height > 0) {
				//translate([ 0, caster_front_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
				//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
				translate([ 0, caster_back_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
	        }

	        // i2c mux ToF sensors
	        translate([ 12, 71, 2 ]) color([ 1, 0, 0 ])  component_pca9548(); 

	        // tof sensor mounts, left and right sides
	      	translate([ 0, 87, 0]) rotate([ 0, 0, 0 ]) adafruit_tof_sensor_vertical( 3 ); 	// front
	      	translate([ 33, 92, 0 ]) rotate([ 0, 0, -90 ]) adafruit_tof_sensor_vertical( 3 ); 	// right
	      	translate([ -33, 92, 0 ]) rotate([ 0, 0, 90 ]) adafruit_tof_sensor_vertical( 3 ); 	// left
	     } 
		
		// wheel holes
		translate([ -(plate_x/2) + (wheel_x/2) - (wheel_adj/2), wheel_center_y, -0.1 ]) 
			roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );
		translate([  (plate_x/2) - (wheel_x/2) + (wheel_adj/2), wheel_center_y, -0.1 ]) 
			roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );

		if (TI25_use_threaded_insert == true) {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
		} else {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);		
		}

		// caster mount holes
		translate([ 0, caster_front_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_back_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);

        // clean out spot for rear caster mount bolt head (useful if board mount is at rear of plate)
        if (caster_post_height == 0) {
			translate([ 0, caster_front_y, plate_thick ]) cylinder( d=7, h=5);
			//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
			translate([ 0, caster_back_y, plate_thick ]) cylinder( d=8, h=5);
        }

		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );

	}
}


/*
 *  
 * 
 * NOTE that the pillars extend "height" above the plate's top surface
 * this uses 28x36 mm o-ring wheels
 * @param caster_post_height:  	height of spacer ring at caster locations to provide room
 *								for screws if using short casters
 * adafruit 1:50 N20 motors are spec-ed at 200 RPM
 * pimoroni 1:20 N20 motors are spec-ed at 1000 RPM 
 */
module plate_motors_n20_enc_cam( pillar_height = 29, caster_post_height=2 ) {
	// these parameters are related to choice of board design
	wheel_x = 9;	// wheel hole "width"
	wheel_y = 39;	// wheel hole "length"
	wheel_center_y = 37;
	motormount_dist_from_ctr_x = 17;	// adafruit N20 motors
	motormount_hole_spacing = 18;
	motormount_lift = 3;
	caster_front_y = 96.5;
	caster_mid_y = 76.5;
	caster_back_y = 8;

	wheel_adj = 4;	// this makes wheel slot fatter to eliminate round corner on outside edge
	difference() {
		union() { 
			component_plate( "E", pillar_height );
			// ADC board
			translate([ -16, adc_y, 1 ])  color([ 0, 0, 1 ]) component_adc_ads7830();

			// TB6612
			translate([ 18, adc_y, 1 ]) color([ 1, 0, 0 ]) component_tb6612();

			// protoboard for motor wiring headers
			translate([ 0, 7, 0 ]) color ([ 1, 0, 0 ]) component_smallmintproto();

			// lift for motor mounts (left)
			if (motormount_lift > 0) {
				translate([ -motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ 0, wheel_center_y, plate_thick ]) 
					roundedbox(plate_x - (2 * wheel_x), 9, 2, motormount_lift);
		        translate([ -5, wheel_center_y - (motormount_hole_spacing/2) - 3, plate_thick ]) linear_extrude(2) text("M25", 
		            size=5,  halign="center", font = "Liberation Sans:style=Bold");
			}

	        // add posts for caster mount screw (if lifted)
	        if (caster_post_height > 0) {
				//translate([ 0, caster_front_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
				translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
				translate([ 0, caster_back_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
	        }

	        // camera mount
	        translate([ 0, 88, plate_thick ]) component_pillar(35, 10 );
		}

		// wheel holes
		translate([ -(plate_x/2) + (wheel_x/2) - (wheel_adj/2), wheel_center_y, -0.1 ]) 
			roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );
		translate([  (plate_x/2) - (wheel_x/2) + (wheel_adj/2), wheel_center_y, -0.1 ]) 
			roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );

		if (TI25_use_threaded_insert == true) {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
		} else {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);		
		}

		// caster mount holes
		translate([ 0, caster_front_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_back_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);

        // clean out spot for caster mount bolt head (useful if board mount is at rear of plate)
        if (caster_post_height == 0) {
			//translate([ 0, caster_front_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
			//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
			translate([ 0, caster_back_y, plate_thick ]) cylinder( d=8, h=5);
        }

		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );

	}
}


/*
 * plate_motors_n20_enc_tofp_qtpy  makes plate with pololu PWM distance sensors
 *    and n20 motors with encoder 
 * 
 * NOTE that the pillars extend "height" above the plate's top surface
 * this uses 28x36 mm o-ring wheels
 * @param caster_post_height:  	height of spacer ring at caster locations to provide room
 *								for screws if using short casters
 * adafruit 1:50 N20 motors are spec-ed at 200 RPM
 * pimoroni 1:20 N20 motors are spec-ed at 1000 RPM 
 */
module plate_motors_n20_enc_tofp_qtpy( pillar_height = 29, caster_post_height=2 ) {
	// these parameters are related to choice of board design
	wheel_x = 9;	// wheel hole "width"
	wheel_y = 39;	// wheel hole "length"
	wheel_center_y = 37;
	motormount_dist_from_ctr_x = 17;	// adafruit N20 motors
	motormount_hole_spacing = 18;
	motormount_lift = 3;
	caster_front_y = 96.5;
	caster_mid_y = 76.5;
	caster_back_y = 8;

	wheel_adj = 4;	// this makes wheel slot fatter to eliminate round corner on outside edge
	difference() {
		union() { 
			component_plate( "E", pillar_height );
			// ADC board
			//translate([ -16, adc_y, 1 ])  color([ 0, 0, 1 ]) component_adc_ads7830();

			// TB6612
			translate([ -14, 68, 1 ]) color([ 1, 0, 0 ]) rotate([ 0, 0, 90 ]) component_tb6612();

			// protoboard for motor wiring headers
			translate([ 0, 7, 0 ]) color ([ 1, 0, 0 ]) component_smallmintproto();

			// lift for motor mounts (left)
			if (motormount_lift > 0) {
				translate([ -motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ motormount_dist_from_ctr_x, wheel_center_y, plate_thick ]) 
					roundedbox(8, motormount_hole_spacing + 8, 2, motormount_lift);
				translate([ 0, wheel_center_y, plate_thick ]) 
					roundedbox(plate_x - (2 * wheel_x), 9, 2, motormount_lift);
		        translate([ -5, wheel_center_y - (motormount_hole_spacing/2) - 3, plate_thick ]) linear_extrude(2) text("M25", 
		            size=5,  halign="center", font = "Liberation Sans:style=Bold");
			}

	        // add posts for caster mount screw (if lifted)
	        if (caster_post_height > 0) {
				//translate([ 0, caster_front_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
				//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
				translate([ 0, caster_back_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
	        }

	        // qtpy for ToF sensors
	        translate([ 18, 73, 2 ]) color([ 1, 0, 0 ])  rotate([ 0, 0, 90 ]) component_qtpy(); 

	        // tof sensor mounts, left and right sides
	      	translate([ 0, 85, plate_thick]) rotate([ 0, 0, 0 ]) pololu_tof_sensor_vertical( 3 ); 	// front
	      	translate([ 33, 92, plate_thick ]) rotate([ 0, 0, -90 ]) pololu_tof_sensor_vertical( 3 ); 	// right
	      	translate([ -33, 92, plate_thick ]) rotate([ 0, 0, 90 ]) pololu_tof_sensor_vertical( 3 ); 	// left
	     } 
		
		// wheel holes
		translate([ -(plate_x/2) + (wheel_x/2) - (wheel_adj/2), wheel_center_y, -0.1 ]) 
			roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );
		translate([  (plate_x/2) - (wheel_x/2) + (wheel_adj/2), wheel_center_y, -0.1 ]) 
			roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );

		if (TI25_use_threaded_insert == true) {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=TI25_threaded_insert_dia, h=plate_thick+motormount_lift+0.2);
		} else {
			// motor mount (left)
			translate([ -motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ -motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);

			// motor mount (right)
			translate([ motormount_dist_from_ctr_x, wheel_center_y + (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);
			translate([ motormount_dist_from_ctr_x, wheel_center_y - (motormount_hole_spacing/2), -0.1 ]) 
				cylinder( d=M25_selftap_dia, h=plate_thick+motormount_lift+0.2);		
		}

		// caster mount holes
		translate([ 0, caster_front_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);
		translate([ 0, caster_back_y, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+caster_post_height+0.2);

        // clean out spot for rear caster mount bolt head (useful if board mount is at rear of plate)
        if (caster_post_height == 0) {
			translate([ 0, caster_front_y, plate_thick ]) cylinder( d=7, h=5);
			//translate([ 0, caster_mid_y, -0.1 ]) cylinder( d=mount_cone_top_dia, h=plate_thick+caster_post_height);
			translate([ 0, caster_back_y, plate_thick ]) cylinder( d=8, h=5);
        }

		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );

	}
}