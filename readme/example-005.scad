include <../lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 50;
z = 75; 


for (sides =[1:6])
{
    color("Gold",0.75) translate([100*(sides-4),0,0]) 
        lasercutoutBox(thickness = thickness, x=x, y=y, z=z, sides=sides);
}