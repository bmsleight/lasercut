include <../lasercut.scad>; 

$fn=60;
thickness = 3.1;
x = 50;
y = 100;
lasercutoutSquare(thickness=thickness, x=x, y=y,
    bumpy_finger_joints=[
            [UP, 1, 4],
            [DOWN, 1, 4]
        ]
    );


translate([0,y+20,thickness]) rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        finger_joints=[
                [UP, 1, 4],
                [DOWN, 1, 4]
            ]
    );