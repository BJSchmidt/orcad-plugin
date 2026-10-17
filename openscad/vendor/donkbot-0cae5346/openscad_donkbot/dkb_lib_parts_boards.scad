/*
 * Module: dkb_lib_parts_boards.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates "mounts" for typical breakout boards from 
 * Adafruit and others that may be placed on robot chassis
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


module component_tb6612() {
    component_2_post_board( board_tb6612_length, board_tb6612_width, board_tb6612_screw_x, board_tb6612_screw_y, "M25", "TB6612" );
}

module component_a4988( bd_length, bd_width, screw_x, screw_y, mount_size="M3", board_label="", lift=mount_cone_height ) {
    offset = (0.37/4) * 25.4;
    difference() {
        union() {
            roundedbox(board_a4988_length, board_a4988_width, 2, board_thick);

            // mount towers       
            translate([ -(board_a4988_screw_x/2), -(board_a4988_screw_y/2)+offset, 1]) component_mount_cylinder(lift); 
            translate([ -(board_a4988_screw_x/2), +(board_a4988_screw_y/2)+offset, 1]) component_mount_cylinder(lift);
            translate([ +(board_a4988_screw_x/2), -(board_a4988_screw_y/2)+offset, 1]) component_mount_cylinder(lift);
            translate([ +(board_a4988_screw_x/2), +(board_a4988_screw_y/2)+offset, 1]) component_mount_cylinder(lift); 

            // identification
            translate([0, -2.5, board_thick]) linear_extrude(2) text("A4988", 
                size=5,  halign="center", font = "Liberation Sans:style=Bold");
            translate([0, +4, board_thick]) linear_extrude(1.4) text("M2", 
                size=5,  halign="center", font = "Liberation Sans:style=Bold");
        }
            
        // mount tower holes  
        translate([ -(board_a4988_screw_x/2), -(board_a4988_screw_y/2)+offset, -0.1]) M20_threadhole(lift+board_thick+0.2); 
        translate([ -(board_a4988_screw_x/2), +(board_a4988_screw_y/2)+offset, -0.1]) M20_threadhole(lift+board_thick+0.2);
        translate([ +(board_a4988_screw_x/2), -(board_a4988_screw_y/2)+offset, -0.1]) M20_threadhole(lift+board_thick+0.2);
        translate([ +(board_a4988_screw_x/2), +(board_a4988_screw_y/2)+offset, -0.1]) M20_threadhole(lift+board_thick+0.2);

    }
}

module component_adc_ads7830() {
	component_4_post_board( board_ads7830_length, board_ads7830_width, board_ads7830_screw_x, board_ads7830_screw_y, "M25", "ADC" );
}

module component_tof( ) {
    component_4_post_board( board_stemma5_length, board_stemma5_width, board_stemma5_screw_x, board_stemma5_screw_y, "M25", "TOF" );
}

module component_pico_doubler() {
	component_4_post_board( board_pico_doubler_length, board_pico_doubler_width, board_pico_doubler_screw_x, board_pico_doubler_screw_y, "M25", "Pico Doubler" );
}

module component_smallmintproto() {
	component_4_post_board( board_smallmintproto_length, board_smallmintproto_width, board_smallmintproto_screw_x, board_smallmintproto_screw_y, "M3", "SmallMint" );
}

/*
 * mount for adafruit PCA9548   I2C Multiplexer board with Stemma Connectors
 * purchase link: https://www.adafruit.com/product/5626
 * guide: https://learn.adafruit.com/adafruit-pca9548-8-channel-stemma-qt-qwiic-i2c-multiplexer/overview
 */
module component_pca9548() {
    component_4_post_board( board_pca9548_length, board_pca9548_width, board_pca9548_screw_x, board_pca9548_screw_y, "M25", "PCA9548" );
}

/*
 * module component_qtpy generates a "nest" to cradle an Adafruit QTPy module
 * the board is not bolted down, but is placed in the nest and held with 
 * a small dollope of hot glue
 */

module component_qtpy() {
    nest_internal_x = 19;
    nest_internal_y = 22;
    wall_thick = 1.6;
    wall_height = 5;
    center_gap = 12;
    base_thick = 3;     // raises this up over base to provide clearance for body of usb plug

    translate([ 0, 0, base_thick ]) {
        difference() {
            roundedbox ( nest_internal_x + (2*wall_thick), nest_internal_y + (2*wall_thick), 1, wall_height );
            translate([ 0, 0, -0.1 ]) roundedbox ( nest_internal_x, nest_internal_y , 1, wall_height+0.2 );
            translate([ 0, 0, -0.1 ]) roundedbox( center_gap, nest_internal_y + (2*wall_thick) + 2, 1, wall_height+0.2 );
        }
    }
    roundedbox ( nest_internal_x + (2*wall_thick), nest_internal_y + (2*wall_thick), 1, base_thick );
    
    // identification
    translate([0, +5, base_thick ]) linear_extrude(1) text("QTPy", 
        size=5,  halign="center", font = "Liberation Sans:style=Bold");
    translate([0, -2, base_thick ]) linear_extrude(1) text("Hot", 
        size=4,  halign="center", font = "Liberation Sans:style=Bold");
    translate([0, -8, base_thick ]) linear_extrude(1) text("Glue", 
        size=4,  halign="center", font = "Liberation Sans:style=Bold");
}

/*
 * tof sensor mount, adafruit_tof_sensor_vertical orientation
 * this is generated in the XZ plane, centered across X 
 * this for Adafruit sensors, such as:
 *      https://www.adafruit.com/product/3967   https://learn.adafruit.com/adafruit-vl53l1x/overview
 * @param lift:  number of mm that bottom of sensor is above mount surface
 */
module adafruit_tof_sensor_vertical( lift = 2 ) {
    tower_width = board_stemma5_width;
    tower_height = board_stemma5_length + lift;
    tower_thick = 3;
    mount_width = 7;    // width of board mounting block
    mount_height = 3;   // how much sensor board is lifted off baseplate
    vertical_ctr = tower_height/2;
    screw_sep = board_stemma5_screw_x / 2;

    translate([ -tower_width/2, 0, 0 ]) difference() {
        union() {
            cube([ tower_width, tower_thick, tower_height ]);
            translate([ tower_width - mount_width, tower_thick, 0 ]) cube([ mount_width, mount_height, tower_height ]);

            // identification
            translate([6.5, tower_thick, 15]) rotate([ 90, 0, 180 ]) linear_extrude(2) text("ToF", 
                size=5,  halign="center", font = "Liberation Sans:style=Bold");
            translate([6.5, tower_thick, 8]) rotate([ 90, 0, 180 ]) linear_extrude(1.4) text("M25", 
                size=4,  halign="center", font = "Liberation Sans:style=Bold");
        }

        if (TI25_use_threaded_insert) {
            translate([ tower_width - (mount_width/2), -0.1, vertical_ctr + screw_sep ]) rotate([ -90, 0, 0 ]) 
                cylinder( d= TI25_threaded_insert_dia, h=8.1);
            translate([ tower_width - (mount_width/2), -0.1, vertical_ctr - screw_sep ]) rotate([ -90, 0, 0 ]) 
                cylinder( d= TI25_threaded_insert_dia, h=8.1);
        } else {
            translate([ tower_width - (mount_width/2), -0.1, vertical_ctr + screw_sep ]) rotate([ -90, 0, 0 ]) 
                cylinder( d= M25_selftap_dia, h=8.1);
            translate([ tower_width - (mount_width/2), -0.1, vertical_ctr - screw_sep ]) rotate([ -90, 0, 0 ]) 
                cylinder( d= M25_selftap_dia, h=8.1);
        }
    }
}

/*
 * tof sensor mount, pololu pwm distance sensor  ToF
 * this is generated in the XZ plane, centered across X 
 * this for Pololu sensors, such as:
 *     https://www.pololu.com/product/4064
 * @param lift:  number of mm that bottom of sensor is above mount surface
 */
module pololu_tof_sensor_vertical( lift = 2 ) {
    tower_width = 12;
    tower_height = 18 + lift;
    tower_thick = 3;
    screw_offset = 3;   // mount hole distance above bottom

    translate([ -tower_width/2, 0, 0 ]) difference() {
        union() {
            cube([ tower_width, tower_thick, tower_height ]);

            // identification
            translate([6.5, tower_thick, 16]) rotate([ 90, 0, 180 ]) linear_extrude(1.4) text("ToF", 
                size=4,  halign="center", font = "Liberation Sans:style=Bold");
            translate([6.5, tower_thick, 11]) rotate([ 90, 0, 180 ]) linear_extrude(1.4) text("M2", 
                size=4,  halign="center", font = "Liberation Sans:style=Bold");

            // mount standoff for board
            translate([ tower_width/2, tower_thick, lift+screw_offset ]) rotate([ -90, 0, 0 ]) cylinder (d=mount_cone_top_dia, h=4);
        }

        if (TI25_use_threaded_insert) {
            translate([ tower_width/2, -0.1,lift+screw_offset ]) rotate([ -90, 0, 0 ]) 
                cylinder( d= TI20_threaded_insert_dia, h=8.1);
        } else {
            translate([ tower_width/2, -0.1, lift+screw_offset ]) rotate([ -90, 0, 0 ]) 
                cylinder( d= M2_selftap_dia, h=8.1);
        }
    }
}

/*
 **************************************************************************
 * module component_pico() generates mount for raspberry pi Pico 1 or Pico W board
 * purchase link: 
 * info link: https://datasheets.raspberrypi.com/pico/pico-datasheet.pdf
 **************************************************************************
 */
module component_pico() {
	component_4_post_board( board_pico_length, board_pico_width, board_pico_screw_x, board_pico_screw_y, "M2", "Pico" );
}

/*
 **************************************************************************
 * module component_oled32() generates mount for adafruit 128 x 32 oled display
 * purchase link: https://www.adafruit.com/product/4440
 * info link: https://learn.adafruit.com/monochrome-oled-breakouts/downloads
 * NOTE: this is raised a little bit (9 mm) because the bottom is a little bit fat
 **************************************************************************
 */
module component_oled32() {
	component_4_post_board( board_oled32_length, board_oled32_width, board_oled32_screw_x, board_oled32_screw_y, "M25", "OLED32", 9 );
}

/*
 **************************************************************************
 * module component_i2_hub() generates mount for adafruit 5 port i2c hub
 * purchase link: https://www.adafruit.com/product/5625
 * info link: https://learn.adafruit.com/qwiik-stemma-qt-5-port-hub
 **************************************************************************
 */
module component_i2c_hub() {
	component_4_post_board( board_stemma5_length, board_stemma5_width, board_stemma5_screw_x, board_stemma5_screw_y, "M25", "I2C" );
}

/*
 **************************************************************************
 * module component_feather() generates mount for any Feather board
 * purchase link: https://www.adafruit.com/search?q=feather+rp2040  rp2040
 * info link: https://learn.adafruit.com/adafruit-feather-rp2040-pico
 *
 * purchase link: https://www.adafruit.com/product/5477   esp32-s3
 * info link: https://learn.adafruit.com/adafruit-esp32-s3-feather
 **************************************************************************
 */
module component_feather( lift = mount_cone_height ) {
	component_4_post_board( board_feather_length, board_feather_width, board_feather_screw_x, board_feather_screw_y, "M25", "Feather", lift );
}


/*
 **************************************************************************
 * module component_sparkfun_navswitch() generates mount for any Feather board
 * purchase link: https://www.sparkfun.com/sparkfun-qwiic-navigation-switch.html
 **************************************************************************
 */
module component_sparkfun_nav_switch( lift = mount_cone_height ) {
    component_4_post_board( board_sparkfun_nav_switch_length, board_sparkfun_nav_switch_width, board_sparkfun_nav_switch_screw_x, board_sparkfun_nav_switch_screw_y, "M3", "NavSw", lift );
}


/*
 **************************************************************************
 * module component_feather() generates mount for any Feather board
 * purchase link: https://www.adafruit.com/product/5345 ESP32-S2
 * info link: https://learn.adafruit.com/esp32-s2-reverse-tft-feather

 * purchase link: https://www.adafruit.com/product/5691 ESP32-S3
 * info link: https://learn.adafruit.com/esp32-s3-reverse-tft-feather

 * NOTE: Adafruit Reverse TFT Feather requires 10 mm lift because its fat 
 *       on the bottom most other boards are fine with default 7.
 *		 also it has M2 screws on one end, and M2.5 screws on button end
 **************************************************************************
 */
module component_feather_reverse_tft() {
	component_4_post_board( board_feather_length, board_feather_width, board_feather_screw_x, board_feather_screw_y, "M25", "Feather", 10 );
    translate([-22, -2, 1]) linear_extrude(2) text("M2", 
        size=4,  halign="center", font = "Liberation Sans:style=Bold");
    translate([21, -2, 1]) linear_extrude(2) text("M25", 
        size=4,  halign="center", font = "Liberation Sans:style=Bold");
    translate([ 0, -10, 1]) linear_extrude(2) text("Reverse TFT", 
        size=4,  halign="center", font = "Liberation Sans:style=Bold");
}

/*
 **************************************************************************
 * module component_rotary_encoder() generates mount for adafruit stemma rotary encoder board
 * purchase link: https://www.adafruit.com/product/4991
 * info link: https://learn.adafruit.com/adafruit-i2c-qt-rotary-encoder *
 **************************************************************************
 */
module component_rotary_encoder() {
	component_4_post_board( board_rotenc_adafruit_length, board_rotenc_adafruit_width, board_rotenc_adafruit_screw_x, board_rotenc_adafruit_screw_y, "M25", "RotEnc" );
}


/*
 **************************************************************************
 * module component_matrix() generates mount for 8x8 bicolor LED matrix
 * purchase link: https://www.adafruit.com/product/902
 * info link:https://learn.adafruit.com/adafruit-led-backpack/bi-color-8x8-matrix
 **************************************************************************
 */
module component_matrix() {
    component_4_post_board( board_matrix_length, board_matrix_width, board_matrix_screw_x, board_matrix_screw_y, "M20", "8x8 Matrix" );
}


/*
 * ***************************************************************************
 * this makes a base for DTS power distribution stripboard
 * its base is 1mm thick, and 12.7mm x 50.8mm (0.5 x 2in) 
 * it has 2 M3 threaded insert mounts on 48mm  spacing
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, and "holed" from the design
 * IMPORTANT: this should be placed on the top surface of the plate, but 
 *     its holes extend downward through the plate so that this can be 
 *     placed lower than the thickness of the threaded inserts
 * 	(dupont wires plugged into board need 23 clearance above top of the pillars)
 *
 * NOTE a fixture to help position header pins for soldering is in dkb_parts_misc.scad
 *
 * ***************************************************************************
 */

module component_dts_pwrdist(height, mode="adds") {
    // the "mount" itself handles the add/holes issues 
    //translate([ -(board_dts_pwrdist_mount_spacing/2), 0, 1]) M3_mount_cyl_with_bolthole(7);
    //translate([ +(board_dts_pwrdist_mount_spacing/2), 0, 1]) M3_mount_cyl_with_bolthole(7);
    
    if (mode == "holes") {
        if (TI30_use_threaded_insert == true) {
		    translate([ -(board_dts_pwrdist_mount_spacing/2), 0, -(plate_thick+0.1) ]) 
		    	cylinder( d=TI30_threaded_insert_dia, h=height+plate_thick+0.2);
		    translate([ +(board_dts_pwrdist_mount_spacing/2), 0, -(plate_thick+0.1) ]) 
		    	cylinder( d=TI30_threaded_insert_dia, h=height+plate_thick+0.2);
        } else {
		    translate([ -(board_dts_pwrdist_mount_spacing/2), 0, -(plate_thick+1.1) ]) 
		    	cylinder( d=M3_selftap_dia, h=height+plate_thick+0.2);
		    translate([ +(board_dts_pwrdist_mount_spacing/2), 0, -(plate_thick+1.1)]) 
		    	cylinder( d=M3_selftap_dia, h=height+plate_thick+0.2);
        }
    }
    
    if (mode == "adds") {
        roundedbox(board_dts_pwrdist_length, board_dts_pwrdist_width, 2, 1);

	    translate([ -(board_dts_pwrdist_mount_spacing/2), 0, 0 ]) cylinder( d=mount_cone_top_dia, h=height);
	    translate([ +(board_dts_pwrdist_mount_spacing/2), 0, 0 ]) cylinder( d=mount_cone_top_dia, h=height);
           
        translate([0, +2, 0]) linear_extrude(2) text("Pwr Dist v3", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");

        translate([0, -6, 0]) linear_extrude(2) text("M3", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}