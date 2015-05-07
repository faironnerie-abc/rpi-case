module board() {
    difference() {
        cube([85, 56, 1.6]);
        translate([25.5, 18, 0])cylinder(h = 4, d = 2.9, center = true, $fn = 30);
        translate([85 - 5, 56 - 12.5, 0])cylinder(h = 4, d = 2.9, center = true, $fn = 30);
    }
}

module hdmi() {
    cube([15.1, 11.4, 6.15]);
}

module ethernet() {
    cube([21.8, 15.4, 13]);
}

module usb() {
   cube([17.2, 13.25, 15.3]);
} 

module jack() {
    cube([12, 11.4, 10.2]);
    translate([12 / 2, 11.4 + 3.4 / 2, 3 + 6.7 / 2]) rotate([90, 0, 0])
        cylinder(h = 3.4, d = 6.7, center = true, $fn = 30);
}

module composite() {
    cube([9.8, 10, 13]);
    translate([9.8 / 2, 15, 8.3 / 2 + 4]) rotate([90, 0, 0])
        cylinder(h = 10, d = 8.3, center = true, $fn = 30);
}

module micro_usb() {
    cube([5.6, 7.6, 2.4]);
}

module sd() {
    cube([15, 27.8, 4.5]);
}

module rpi() {
    translate([0, 0, -1.6]) board();
    translate([37.5, -1.2, 0]) hdmi();
    translate([85 - 21.8 + 1, 2, 0]) ethernet();
    translate([85 - 17.2 + 7, 56 - 13.25 - 18.8, 0]) usb();
    translate([85 - 12 - 14, 56 - 11.4, 0]) jack();
    translate([40.6, 56 - 9.8 - 2.1, 0]) composite();
    translate([-0.5, 3.6, 0]) micro_usb();
    translate([0, 56 - 27.8 - 11.5, -4.5]) sd();
}

rpi();
