/*
 * Module: dkb_core.scad
 * this file sets up the common parameters for the user's bot
 *
 * Project:   DonKbot_mm
 * Author(s): Don Korte
 * github:    https://github.com/dnkorte/donkbot
 *
 * this DonKbot library module provides some core functions specific to 
 * robots in the DonKbot family.   It is stored in the same folder as the
 * rest of the DonKbot project files. 
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


/*
 * note that core_config_dimensions.scad and core_robo_functions.scad 
 * are libraries used in several of my projects and are stored
 * in my common openSCAD library in a different folder.  They are
 * able to be referenced because of the OPENSCADPATH environment variable
 * however they could be put in the same folder as the DonKbot folders if desired.
 * 
 * environment variable OPENSCADPATH is defined to that path in:
 *		on linux, store a file called /etc/profile.d/openscadpath.sh with contents:  
 *			export OPENSCADPATH="/home/xxxxx/" 
 *			(note that ~/.bashrc fails because its not run from terminal session)
 *		by Control Panel / System / Advanced System Settings / Environment Variables / User Variable on windows
 * see https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries   for details
 */

/* =========  these modules from core library ======= */
include <core_config_dimensions.scad>;
include <core_robo_functions.scad>;
include <core_parts_wheels.scad>;
include <torus.scad>;			

/* =========  these modules are from local folder ====== */
include <dkb_lib_parts_boards.scad>;
include <dkb_lib_parts_motors.scad>;
include <dkb_lib_parts_switches_batts.scad>;
include <dkb_lib_plate_components.scad>;

// (possibly) over-ride configuration 
TI20_use_threaded_insert = true;
TI25_use_threaded_insert = true;
TI30_use_threaded_insert = true;

// set visualizations flag (normally false, and should definitely be false when rendering for print)
// if true it shows the "bodies" of some parts to aid in visualizing spacing when settiup up plates
// currently used by plate_motors_nema8_stepper() and component_motormount_TT()
show_viz = false;

$fn = 64;

// parameters that are fixed because of pre-defined sizes or external parts
plate_x = 83;
plate_y = 102;

sensor_mount_hole_spacing = 48;

viewslot_line_x = 39;
viewslot_line_y = 10;
sensor_viewslot_offset = 7;		// viewslot (center) distance forward of mount holes

viewslot_side_x = 11;
viewslot_side_y = 5;
viewslot_side_offset_x = 34;
viewslot_side_offset_y = -2.5;

// parameters that are model-specific but needed globally (use mount_cone_top_dia for diameter)
plate_thick = 2;
standoff_x = (plate_x/2)-5;
standoff_spacing = 8;
standoff_y_front = 64;
standoff_y_back = 11;

sens_mount_y_front = 89;
sens_mount_y_back = 79;

// note if using "basic wall sensor", set front to 3, back to 0
// for wall follower and "line sensor mini" use front = 0, back = 8
sens_mount_lift_front = 0;
sens_mount_lift_back = 8;

adc_y = 60.5;

accessory_mount_spacing = 44;
