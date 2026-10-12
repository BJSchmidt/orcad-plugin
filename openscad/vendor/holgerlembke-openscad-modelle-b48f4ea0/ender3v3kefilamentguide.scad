/*
    
    Filament Guide für Ender 3 V3 KE
    für seitliche Rolleninstallation
    
*/

$fn = $preview ? 20 : 300;


winkelh = 50.0;
winkell = 40.0;
winkelb = 40.0;
winkeldl = 10.0;
winkeldo = 7.0;

kantrund = 2.0;

beflochdm = 5.0;     // Befestigungsloch Rahmen (oben)
beflochkdm = 10.0;     // Befestigungslochkopf Rahmen (oben)
beflochabs = 20.0;   // Abstand der Befestigungslöcher
belochkh = 3.0; // Kopfhöhe der Schraube

kupplungaussen = 25.0;
kupplungh = 18.0;

sensorzdm = 8.2; // der Zapfen an der Unterseite
sensorl = 40.0;
sensorb = 32.0;
sensorh = 20.0;

difference() {
    halter();
    rotate([-5,0,0]) translate([-21,1,40]) rotate([0,90,0]) sensor();
}    
// rotate([-5,0,0]) translate([-21,1,40]) rotate([0,90,0]) sensor();

//translate([0,-50,0]) halterungsdemo();


//************************************************************************
module halter() {
    difference() {
        cube([winkelb,winkell,winkelh]);
        union() {
            // Winkel
            translate([winkeldl,0,0]) cube([winkelb-winkeldl,winkell,winkelh-winkeldo]);
            
            // Rundungskante
            translate([0,0,winkelh-kantrund/2]) cube([kantrund/2,winkell,kantrund/2]);

            // Befestigungslöcher
            translate([winkeldl+(winkelb-winkeldl)/2.0,(winkell-beflochabs)/2.0,winkelh-winkeldo]) cylinder(d=beflochdm,h=winkeldo);
            translate([winkeldl+(winkelb-winkeldl)/2.0,(winkell+beflochabs)/2.0,winkelh-winkeldo]) cylinder(d=beflochdm,h=winkeldo);

            translate([winkeldl+(winkelb-winkeldl)/2.0,(winkell-beflochabs)/2.0,winkelh-belochkh]) cylinder(d=beflochkdm,h=winkeldo);
            translate([winkeldl+(winkelb-winkeldl)/2.0,(winkell+beflochabs)/2.0,winkelh-belochkh]) cylinder(d=beflochkdm,h=winkeldo);
        }
    }
    translate([kantrund/2,0,winkelh-kantrund/2]) rotate([-90,0,0]) cylinder(d=kantrund,h=winkell);
    
    kfl = 13.0;
    kfh = 17.0;
    kdr = 8.0;
    color("green") 
    translate([-kupplungaussen,winkell-kupplungh-kfl,winkelh-kupplungh-kantrund+kfh]) 
    rotate([-15,0,0])
    difference() {
        union() {
            cube([kupplungaussen,kupplungaussen,kupplungh]);
            translate([kupplungaussen,0,kdr-3]) rotate([-90,0,0]) cylinder(d=kdr,h=kupplungaussen);
        }
        translate([kupplungaussen/2.0,kupplungaussen/2.0,0]) kupplung();
    }
    
    
}

//************************************************************************
module halterungsdemo() {
    color("gray") import("j:/filseguide.stl");
    //translate([15,30,0]) cylinder(d=4,h=4);
/*
   loch: 15,10
   loch: 15,30

   d= 5
   d= 9.5
*/
}

//************************************************************************
// Negativ-Element der Schlauchkupplung
module kupplung() {
    offs = 0.2;
    cylinder(d=10.0+offs, h=6.6);
    translate([0,0,6]) cylinder(d=11.8+offs,h=20.0,$fn=6);
}

//************************************************************************
// der Filament-Ende-Sensor
module sensor() {
    color("gray") {
        cube([sensorl,sensorb,sensorh]);
        translate([sensorl/2.0,sensorb/2.0,sensorh]) cylinder(d=sensorzdm,h=12.5);
        
        translate([-10,sensorb/2.0,7.9]) rotate([0,90,0]) cylinder(d=2.0,h=60);
    }
}

/*
sensorzdm = 7.2; // der Zapfen an der Unterseite
sensorl = 40.0;
sensorb = 32.0;
sensorh = 20.0;
*/










