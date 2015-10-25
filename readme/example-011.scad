include <../lasercut.scad>; 

// Loosley based upon http://www.deferredprocrastination.co.uk/blog/2013/so-whats-a-practical-laser-cut-clip-size/

$fn=60;
thickness = 3.1;
x = 50;
y = 75;
x_beam = 20;

module beam()
{
    lasercutoutSquare(thickness=thickness, x=x_beam, y=y,
        clips=[
            [UP,x_beam/2,y]
            ]
    );
}

module crossBeam()
{
    rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        clip_holes=[
            [DOWN, x/2, y/4, x_beam]
            ]
    );
}


rotate([-90,0,0])  crossBeam();
translate([x+thickness,0,0]) beam();

translate([0,y*3/2+50,0]) crossBeam();
translate([(x-x_beam)/2,y/2+50-thickness,y/4]) rotate([0,0,0]) beam();

