use <rpi.scad>

module case() {
	// hole positions
	p1 = [4 + 25.5, 4 + 18, 0];
	p2 = [93 - 4 - 5, 64 - 4 - 12.5, 0];
	difference() {
		cube([93, 64, 28]);
		// interior
		translate([2, 2, 2]) cube([93, 64, 28] - [4, 4, 4]);
		// HDMI
		translate([40.5, -1, 8]) cube([17.1, 4, 9]);
		// Ethernet
		translate([90, 5.6, 8]) cube([4, 17.4, 15.6]);
		// USB
		translate([90, 64 - 15.3 - 21.8, 8]) cube([4, 15.3, 17.9]);
		// jack
		translate([93 - 24, 65, 15.9]) rotate([90, 0, 0]) cylinder(d = 8.7, h = 4, $fn = 30);
		// composite
		translate([49.5, 65, 17.8]) rotate([90, 0, 0]) cylinder(d = 10.3, h = 4, $fn = 30);
		// micro USB
		translate([-1, 6.6, 8]) cube([4, 9.6, 5]);
		// SD card
		translate([-1, 64 - 29.8 - 14.5, 2]) cube([4, 29.8, 7.6]);
		// screw holes
		translate(p1 + [0, 0, -1]) cylinder(d = 2.9, h = 4, $fn = 30);
		translate(p2 + [0, 0, -1]) cylinder(d = 2.9, h = 4, $fn = 30);
		// air vent (optional)
		for (x = [40:10:80])
			translate([x, 10, -1]) airhole();
		for (x = [10:10:70])
			translate([x, 39, -1]) airhole();
	}
	// studs
	translate(p1 + [0, 0, 2]) stud(6);
	translate(p2 + [0, 0, 2]) stud(6);
	translate(p1 + [0, 0, 2 + 6 + 1.6]) stud(16.4);
	translate(p2 + [0, 0, 2 + 6 + 1.6]) stud(16.4);
}

module stud(height) {
	difference() {
		cylinder(d = 6.9, h = height, $fn = 30);
		translate([0, 0, -1]) cylinder(d = 2.9, h = height + 2, $fn = 30);
	}
}

module airhole() {
	cube([5, 15, 4]);
	translate([2.5, 0, 0]) cylinder(d = 5, h = 4, $fn = 30);
	translate([2.5, 15, 0]) cylinder(d = 5, h = 4, $fn = 30);
}

module floor() {
	intersection() {
		case();
		translate([-1, -1, -1]) cube([93 + 2, 64 + 2, 8 + 1]);
	}
}

module ceiling() {
	difference() {
		case();
		translate([-1, -1, -1]) cube([93 + 2, 64 + 2, 8 + 1]);
	}
}

module rpi_with_case() {
	case();
	color("Green") translate([4, 4, 8 + 1.6]) rpi();
}

// case();
// rpi_with_case();
floor();
translate([0, -10, 28]) rotate([180, 0, 0]) ceiling();
