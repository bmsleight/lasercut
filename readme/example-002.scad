include <../lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 100;
points = [[0,0], [x,0], [x,y], [x/2,y], [x/2,y/2], [0,y/2], [0,0]];
lasercutout(thickness=thickness, points = points);
