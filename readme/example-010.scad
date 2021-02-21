include <../lasercut.scad>; 

// From http://msraynsford.blogspot.co.uk/2012/06/panel-joinery-10.html

$fn=60;
thickness = 3.1;
x = 100;
y = 150;
x_beam = 50;

module beam()
{
    lasercutoutSquare(thickness=thickness, x=x_beam, y=y,
        twist_connect=[
            [RIGHT,x/2,y/2],
            [RIGHT,x/2,y/4,x_beam/2]
            ]
    );
}

module crossBeam()
{
    rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        twist_holes=[
            [RIGHT, x/2, y*3/4, x_beam, x_beam/2],
            [UP, x/2, y/4, x_beam]
            ]
    );
}


rotate([-90,0,0])  crossBeam();
translate([x+thickness,0,0]) beam();


translate([0,y+75,0]) crossBeam();
translate([(x-x_beam)/2,y/2+75-thickness,y*1/4-thickness/2]) rotate([0,0,0]) beam();
translate([x/2-thickness/2,y*3/4+75-thickness,y*3/4+x_beam/2]) rotate([0,90,0]) beam();
