use <rpi.scad>

$fn = 20;

// case dimensions
l = 93;
w = 64;
h = 28;

module case() {
	// hole positions
	p1 = [4 + 25.5, 4 + 18, 0];
	p2 = [l - 4 - 5, w - 4 - 12.5, 0];

	difference() {
		cube([l, w, h]);
		// interior
		translate([2, 2, 2]) cube([l, w, h] - [4, 4, 4]);
		// HDMI
		translate([40.5, -1, 8]) cube([17.1, 4, 9]);
		// Ethernet
		translate([l - 3, 5, 8]) cube([4, 17.4, 15.6]);
		// USB
		translate([l - 3, w - 21.8 - 15.3, 8]) cube([4, 15.3, 17.9]);
		// jack
		translate([l - 24, w + 1, 15.9]) rotate([90, 0, 0])
			cylinder(d = 8.7, h = 4);
		// composite
		translate([49.5, w + 1, 17.8]) rotate([90, 0, 0])
			cylinder(d = 10.3, h = 4);
		// micro USB
		translate([-1, 6.6, 8]) cube([4, 9.6, 5]);
		// SD card
		translate([-1, w - 29.8 - 14.5, 2]) cube([4, 29.8, 7.6]);
		// screw holes
		translate(p1 + [0, 0, -1]) cylinder(d = 2.9, h = 4);
		translate(p2 + [0, 0, -1]) cylinder(d = 2.9, h = 4);
		// air vent (optional)
		for (x = [40:10:80])
			translate([x, 10, -1]) airhole();
		for (x = [10:10:70])
			translate([x, w - 25, -1]) airhole();
		// fablab logo
		translate([p1[0] + 5, (w - 35) / 2, h - 3]) 
			linear_extrude(height = 4) import("../img/fabcube.dxf");
	}
	// studs
	translate(p1 + [0, 0, 2]) stud(6);
	translate(p2 + [0, 0, 2]) stud(6);
	translate(p1 + [0, 0, 9.6]) stud(16.4);
	translate(p2 + [0, 0, 9.6]) stud(16.4);
}

module stud(height) {
	difference() {
		cylinder(d = 6.9, h = height);
		translate([0, 0, -1]) cylinder(d = 2.9, h = height + 2);
	}
}

module airhole() {
	cube([5, 15, 4]);
	translate([2.5, 0, 0]) cylinder(d = 5, h = 4);
	translate([2.5, 15, 0]) cylinder(d = 5, h = 4);
}

module rpi_with_case() {
	% case();
	translate([4, 4, 8 + 1.6]) rpi();
}

module floor() {
	intersection() {
		case();
		translate([-1, -1, -1]) cube([l, w, 9] + [2, 2, 1]);
	}
}

module ceiling() {
	difference() {
		case();
		translate([-1, -1, -1]) cube([l, w, 9] + [2, 2, 1]);
	}
}

// case();
// rpi_with_case();

floor();
translate([0, -10, h]) rotate([180, 0, 0]) ceiling();
