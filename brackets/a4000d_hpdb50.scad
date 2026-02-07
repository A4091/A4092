
$fn = 128;  // smoothness of corners
$thickness = 1.8;
//$holeoffset = -1.3;
$holeoffset = 0;

module rounded_plate(size, radius) {
    hull() {
        for (x = [-1, 1], y = [-1, 1])
            translate([x * (size.x/2 - radius), y * (size.y/2 - radius), 0])
                cylinder(h = size.z, r = radius, center = false);
    }
}

color ("beige") translate ([0,0,0])
    difference () {
        difference() {
            rounded_plate([72, 20, $thickness], radius = 3);
            union() {
                translate ([-33,$holeoffset,-0.1])
                    cylinder(h = $thickness + 0.2, r = 1.5, center = false);
                translate ([33,$holeoffset,-0.1])
                    cylinder(h = $thickness+0.2, r = 1.5, center = false);
            }
        };
 
        translate ([-49.1,-11.1,0]) union()
        {
            translate([27.85,7.35,-0.1])
                cube([42.5,7.5,$thickness + 0.2]);
            translate([26.05,11.1,-0.1])
            {
                scale([2.6/2.4, 1, 1])
                    cylinder(d=2.4, h=$thickness + 0.2, $fn=15);
                translate([46.1,0,0])
                    scale([2.6/2.4, 1, 1])
                        cylinder(d=2.4, h=$thickness + 0.2, $fn=15);
            }
        }
    }
