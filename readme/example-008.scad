include <../lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 100;

$fn=60;

module base()
{
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        screw_tabs=[
                [UP, x/2, y, 3]
                ]
    );
}

module side()
{
    rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        screw_tab_holes=[
                [MID, x/2-thickness/2, thickness, 3]
            ]
    );
}

translate([0,0,0]) base();
translate([0,y+thickness+20,-thickness]) side();
translate([x+20,0,0]) base();
translate([x+20,y+thickness,-thickness]) side();

