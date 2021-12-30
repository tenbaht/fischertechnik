// Fischertechnik Statik-Träger
//

// parameters
l=30;   // total length of strip
n=3;    // number of holes

// constants
b=8;    // width of the strip
d=3;    // thickness
$fn=30;
pitch=l/(n-1);  // distance between two holes

difference(){
// define the solid strip with round ends
    union(){
        translate([0,-b/2,-d/2])
            cube([l,b,d]);
        cylinder(h=d,r=b/2,center=true);
        translate([l,0,-d/2])
            cylinder(h=d,r=b/2);
    }

    // drill holes into the solid strip
    for (i=[0:n-1])
        translate([i*pitch,0,0])
            cylinder(h=d+0.01,d=b-2,center=true);

    // remove material between the holes
    for (i=[1:n-1])
        translate([(i-0.5)*pitch,0,0])
            cube([pitch-b,b-3,d+0.01],center=true);
}

// fill the holes with the holding structure
for (i=[0:n-1])
    translate([i*pitch,0,0]) loch();

// fill the rectangular holes again to change them into pockets
for (i=[1:n-1])
    translate([(i-0.5)*pitch,0,0])
    // 1mm overlap
        cube([pitch-b+1,b-2,1],center=true);



// first hole: add the brand name
translate([pitch/2,0,0]) {
    linear_extrude(1) text("MM",size=3,halign="center",valign="center");
    // add the "-" marker on the back side
    translate([0,0,-0.5]) cube([3,0.5,1],center=true);
}

// last hole: add the dimension
translate([l-pitch/2,0,0]) {
    linear_extrude(1) text("30",size=3,halign="center",valign="center");
    // add the "-" marker on the back side
    translate([0,0,-0.5]) cube([3,0.5,1],center=true);
}

module loch () {
    difference(){
        cylinder(h=1,d=b,center=true);
        cube([b-2,2.5,2],center=true);
        cylinder(h=2,d=4,center=true);
    }
}
