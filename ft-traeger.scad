// Fischertechnik Statik-Träger
//

// constants
b=8;    // width of the strip
d=3;    // thickness
$fn=30;

strebe(3,is_crosstype=true);


module strebe (n,is_crosstype=false)
{
    pitch   = is_crosstype ? 21.2 : 15;
    marking = is_crosstype ? "X"  : "l";

    l = (n-1)*pitch;   // total length of strip

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
//    translate([0,0,-0.5]) cube([3,0.5,1],center=true);
    mark_type(marking);
}

// last hole: add the dimension
translate([l-pitch/2,0,0]) {
    linear_extrude(1) text(str(l),size=3,halign="center",valign="center");
    // add the "-" marker on the back side
//    translate([0,0,-0.5]) cube([3,0.5,1],center=true);
    mark_type(marking);
}
}


module loch () {
    difference(){
        cylinder(h=1,d=b,center=true);
        cube([b-2,2.5,2],center=true);
        cylinder(h=2,d=4,center=true);
    }
}

// emboss the type marker ("-" or "x")
module mark_type (marking) {
    translate([0,0,-1])
    linear_extrude(1)
        rotate(90)
            text(marking,size=3,halign="center",valign="center");
}
