include <../lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 100;
r = thickness*2;
lasercutoutSquare(thickness=thickness, x=x, y=y,
    finger_joints=[
            [UP, 1, 4],
            [DOWN, 1, 4]
        ],
    circles_add = [
            [r, x+thickness, y/5],
        ],
    circles_remove = [
            [r, x/2, y/2],
            [1.5, x/2, y*2/3], // Screw-hole
        ],
    slits = [
            [RIGHT,x,y/2,10]
        ],
    cutouts = [
            [x/6, y/6, thickness*5, thickness*2]
        ]
    );
    
