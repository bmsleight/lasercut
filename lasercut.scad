UP = 0;
DOWN = 180;
LEFT = 90;
RIGHT = 270;
MID = 360;

generate = $generate == undef ? 0: $generate; 

if (generate == 1)
{
    // openscad examples.scad -D generate=1 -o /tmp/d.csg 2>&1 >/dev/null  | sed 's/ECHO: \"\[LC\] //' | sed 's/"$//' | sed '$a;' >./generate.scad ; openscad ./generate.scad -o generate.dxf
    // (from http://forum.openscad.org/Sharing-Dump-echo-output-to-a-file-td12529.html)
    echo("[LC] use <lasercut.scad>; \nprojection(cut = false) \n\t");
}


module lasercutoutSquare(thickness=3.1, x=0, y=0, 
        simple_tabs=[], simple_tab_holes=[], 
        captive_nuts=[], captive_nut_holes = [],
        finger_joints = [],
        circles_add = [],
        circles_remove = [],
        slits = [],
        cutouts = [],
)
{
    points = [[0,0], [x,0], [x,y], [0,y], [0,0]];
lasercutout(thickness=thickness,  
        points = points, 
        simple_tabs = simple_tabs, 
        simple_tab_holes = simple_tab_holes, 
        captive_nuts = captive_nuts, 
        captive_nut_holes = captive_nut_holes,
        finger_joints = finger_joints,
        circles_add = circles_add,
        circles_remove = circles_remove,
        slits = slits,
        cutouts = cutouts
    );
}

module lasercutout(thickness=3.1,  points= [], 
        simple_tabs=[], simple_tab_holes=[], 
        captive_nuts=[], captive_nut_holes = [],
        finger_joints = [],
        circles_add = [],
        circles_remove = [],
        slits = [],
        cutouts = [],
)
{
    path_total = len(points);
    path = [ for (p = [0 : 1 : path_total]) p ];

    function max_y(points) = max([for (a = [0:1:len(points)-1])  points[a][1]]);    
    function min_y(points) = min([for (a = [0:1:len(points)-1])  points[a][1]]);    
    function max_x(points) = max([for (a = [0:1:len(points)-1])  points[a][0]]);    
    function min_x(points) = min([for (a = [0:1:len(points)-1])  points[a][0]]);    
    
    max_y = max_y(points);
    min_y = min_y(points);
    max_x = max_x(points);
    min_x = min_x(points);
    
    difference() 
    { 
        union() 
        {
            linear_extrude(height = thickness , center = false)  polygon(points=points, path=path);
            for (t = [0:1:len(simple_tabs)-1]) 
            {
                simpleTab(simple_tabs[t][0], simple_tabs[t][1], simple_tabs[t][2], thickness);
            }
            for (t = [0:1:len(captive_nuts)-1]) 
            {
                captiveNutTab(captive_nuts[t][0], captive_nuts[t][1], captive_nuts[t][2], thickness);
            }    
            for (t = [0:1:len(circles_add)-1]) 
            {
                circlesAdd(circles_add[t][0], circles_add[t][1], circles_add[t][2], thickness);
            }    
            for (t = [0:1:len(finger_joints)-1]) 
            {
                fingerJoint(finger_joints[t][0], finger_joints[t][1], finger_joints[t][2], thickness, max_y, min_y, max_x, min_x) ;
            }    
            
        } // end union

        for (t = [0:1:len(simple_tab_holes)-1]) 
        {
               simpleTabHole(simple_tab_holes[t][0], simple_tab_holes[t][1], simple_tab_holes[t][2], thickness);
        }
        for (t = [0:1:len(captive_nuts)-1]) 
        {
            captiveNutBoltHole(captive_nuts[t][0], captive_nuts[t][1], captive_nuts[t][2], thickness);
        }
        for (t = [0:1:len(captive_nut_holes)-1]) 
        {
            captiveNutHole(captive_nut_holes[t][0], captive_nut_holes[t][1], captive_nut_holes[t][2], thickness);
        }    
        for (t = [0:1:len(circles_remove)-1]) 
        {
            circlesRemove(circles_remove[t][0], circles_remove[t][1], circles_remove[t][2], thickness);
        }    
        for (t = [0:1:len(slits)-1]) 
        {
               simpleSlit(slits[t][0], slits[t][1], slits[t][2], slits[t][3], thickness);
        }
        for (t = [0:1:len(cutouts)-1]) 
        {
               simpleCutouts(cutouts[t][0], cutouts[t][1], cutouts[t][2], cutouts[t][3], thickness);
        }
        
    }
    
    if ($children) translate([0, max_y(points) + thickness*3, 0])
            children();

    if (generate == 1)
    {
        output = str(
        "[LC] lasercutout(thickness=", thickness, ", \n 
            points= ", points, ", \n
            simple_tabs = ",simple_tabs,", \n
            simple_tab_holes = ",simple_tab_holes,", \n
            captive_nuts = ",captive_nuts,", \n
            captive_nut_holes = ",captive_nut_holes,", \n
            finger_joints = ",finger_joints,", \n
            circles_add = ",circles_add,", \n
            circles_remove = ",circles_remove,", \n
            slits = ",slits,", \n
            cutouts = ",cutouts,") \n"
        );
        echo(output);
    }
}



module simpleTab(angle, x, y, thickness)
{
    translate([x,y,0]) rotate([0,0,angle]) translate([-thickness/2,0,0]) cube([thickness, thickness, thickness]); 
}

module simpleTabHole(angle, x, y, thickness)
{
     // Special case does not go past edge - so make only 1 thickness y
     if (angle == 360)
     {
         translate([x,y,0]) rotate([0,0,0]) translate([0,0,-thickness]) cube([thickness, thickness, thickness*3]); 
     }
     else
     {
         translate([x,y,0]) rotate([0,0,angle-180]) translate([-thickness/2,-thickness,-thickness]) cube([thickness, thickness*2, thickness*3]); 
     }
}

module captiveNutBoltHole(angle, x, y, thickness)
{
    translate([x,y,0]) rotate([0,0,angle-180]) union() 
    {
        translate([-thickness/2,-thickness,-thickness]) cube([thickness, thickness*4, thickness*3]); 
        translate([-thickness/2-thickness,thickness,-thickness]) cube([thickness*3, thickness, thickness*3]); 
    }
}

module fingerJoint(angle, start_up, fingers, thickness, max_y, min_y, max_x, min_x)
{
    if ( angle == UP )
    {
        range_min = min_x; 
        range_max = max_x; 
        t_x = min_x;
        t_y = max_y;
        fingers(angle, start_up, fingers, thickness, range_min, range_max, t_x, t_y);
    }
    if ( angle == DOWN )
    {
        range_min = min_x; 
        range_max = max_x; 
        t_x = max_x;
        t_y = min_y;
        fingers(angle, start_up, fingers, thickness, range_min, range_max, t_x, t_y);
    }
    if ( angle == LEFT )
    {
        range_min = min_y; 
        range_max = max_y; 
        t_x = min_x;
        t_y = min_y;
        fingers(angle, start_up, fingers, thickness, range_min, range_max, t_x, t_y);
    }
    if ( angle == RIGHT )
    {
        range_min = min_y; 
        range_max = max_y; 
        t_x = max_x;
        t_y = max_y;
        fingers(angle, start_up, fingers, thickness, range_min, range_max, t_x, t_y);
    }

}

module fingers(angle, start_up, fingers, thickness, range_min, range_max, t_x, t_y)
{
    // The tweaks to y translate([0, -thickness,0]) ... thickness*2 rather than *1
    // Are to avoid edge cases and make the dxf export better.
    // All fun
    translate([t_x, t_y,0]) rotate([0,0,angle]) translate([0, -thickness,0])
    {
        for ( i = [range_min : (range_max-range_min)/fingers : range_max - (range_max-range_min)/fingers] )
        {
            if(start_up == 1) 
                {
                    translate([i,0,0]) cube([ (range_max-range_min)/(fingers*2), thickness*2, thickness]);
                }
            else 
            {
                    translate([i+(range_max-range_min)/(fingers*2),0,0]) cube([ (range_max-range_min)/(fingers*2), thickness*2, thickness]);
                
            }
        }
    }

}

module captiveNutTab(angle, x, y, thickness)
{
    translate([x,y,0]) rotate([0,0,angle]) union()
    {
        translate([-thickness/2+thickness*2,-thickness,0]) cube([thickness*3, thickness*2, thickness]); 
        translate([-thickness/2-thickness*4,-thickness,0]) cube([thickness*3, thickness*2, thickness]); 
    }
}

module captiveNutHole(angle, x, y, thickness)
{
    translate([x,y,0]) rotate([0,0,angle]) union()
    {
        translate([-thickness/2,-thickness*2,-thickness]) cube([thickness, thickness, thickness*3]); 
        translate([-thickness/2+thickness*2,-thickness*2,-thickness]) cube([thickness*3, thickness, thickness*3]); 
        translate([-thickness/2-thickness*4,-thickness*2,-thickness]) cube([thickness*3, thickness, thickness*3]); 
    }
}

module circlesAdd(radius, x, y, thickness)
{
    translate([x,y,0]) cylinder(h=thickness, r=radius);
}

module circlesRemove(radius, x, y, thickness)
{
    translate([x,y,-thickness]) cylinder(h=thickness*3, r=radius);
}


module simpleSlit(angle, x, y, length, thickness)
{
     translate([x,y,0]) rotate([0,0,angle-180]) translate([-thickness/2,-thickness,-thickness]) cube([thickness, length+thickness, thickness*3]); 
}

module simpleCutouts(x, y, width, height, thickness)
{
     translate([x,y,0]) rotate([0,0,0]) translate([0,0,-thickness]) cube([width, height, thickness*3]);     
}

module lasercutoutBox(thickness = 3.1, x=0, y=0, z=0, sides=6,
        simple_tab_holes_a=[], 
        captive_nuts_a=[], captive_nut_holes_a=[],
        circles_add_a=[],
        circles_remove_a=[],
        slits_a = [],
        cutouts_a = [],
)
{
    if (sides==4)
    {
        fj = [
            [ [UP, 1, 4], [DOWN, 1, 4],    ],
            [ [UP, 0, 4], [DOWN, 1, 4],    ],
            [ [UP, 1, 4], [DOWN, 0, 4],    ],
            [ [UP, 1, 4], [DOWN, 1, 4],    ],
        ];
        translate([0,thickness,0]) lasercutoutBoxAdjustedFJ(thickness = thickness, x=x, y=y-thickness*2 , z=z-thickness*2, sides=sides, fj=fj,
            simple_tab_holes_a=simple_tab_holes_a, 
            captive_nuts_a=captive_nuts_a, captive_nut_holes_a=captive_nut_holes_a,
            circles_add_a=circles_add_a,
            circles_remove_a=circles_remove_a,
            slits_a=slits_a,
            cutouts_a=cutouts_a);
    }
    if (sides==5)
    {
        st = [
        [[DOWN, -thickness/2, 0], [DOWN, -thickness/2, y-thickness] ],
        [[DOWN, -thickness/2, 0], ],
        [[UP, -thickness/2, z-thickness*2], ],
        ];
        fj = [
            [ [UP, 1, 4], [DOWN, 1, 4], [LEFT, 1, 4],   ],
            [ [UP, 0, 4], [DOWN, 1, 4], [LEFT, 1, 4],   ],
            [ [UP, 1, 4], [DOWN, 0, 4], [LEFT, 1, 4],   ],
            [ [UP, 1, 4], [DOWN, 1, 4], [LEFT, 1, 4],   ],
            [ [UP, 0, 4], [DOWN, 1, 4], [LEFT, 0, 4], [RIGHT, 1, 4]  ],
        ];
        
        translate([thickness,thickness,0]) lasercutoutBoxAdjustedFJ(thickness = thickness, x=x-thickness, y=y-thickness*2 , z=z-thickness*2, sides=sides, fj=fj, st=st,
            simple_tab_holes_a=simple_tab_holes_a, 
            captive_nuts_a=captive_nuts_a, captive_nut_holes_a=captive_nut_holes_a,
            circles_add_a=circles_add_a,
            circles_remove_a=circles_remove_a,
            slits_a=slits_a,
            cutouts_a=cutouts_a);
        }
    if (sides==6)
    {
        st = [
        [[DOWN, -thickness/2, 0], [DOWN, -thickness/2, y-thickness] , [RIGHT, x-thickness*2, -thickness/2]],
        [[DOWN, -thickness/2, 0], [RIGHT, x-thickness*2, -thickness/2]],
        [[UP, -thickness/2, z-thickness*2], [DOWN, x-thickness*1.5, 0], ],
        [[UP, z-thickness*1.5, y-thickness*2], ],
        ];
        fj = [
            [ [UP, 1, 4], [DOWN, 1, 4], [LEFT, 1, 4], [RIGHT, 0, 4]  ],
            [ [UP, 0, 4], [DOWN, 1, 4], [LEFT, 1, 4], [RIGHT, 0, 4]  ],
            [ [UP, 1, 4], [DOWN, 0, 4], [LEFT, 1, 4], [RIGHT, 0, 4]  ],
            [ [UP, 1, 4], [DOWN, 1, 4], [LEFT, 1, 4], [RIGHT, 0, 4]  ],
            [ [UP, 0, 4], [DOWN, 1, 4], [LEFT, 0, 4], [RIGHT, 1, 4]  ],
            [ [UP, 0, 4], [DOWN, 1, 4], [LEFT, 0, 4], [RIGHT, 1, 4]  ],
        ];
        translate([thickness,thickness,0]) lasercutoutBoxAdjustedFJ(thickness = thickness, x=x-thickness*2, y=y-thickness*2 , z=z-thickness*2, sides=sides, fj=fj, st=st,
            simple_tab_holes_a=simple_tab_holes_a, 
            captive_nuts_a=captive_nuts_a, captive_nut_holes_a=captive_nut_holes_a,
            circles_add_a=circles_add_a,
            circles_remove_a=circles_remove_a,
            slits_a=slits_a,
            cutouts_a=cutouts_a);
    }    
}


module lasercutoutBoxAdjustedFJ(thickness = 3.1, x=0, y=0, z=0, sides=6, fj=[], st=[],
        simple_tab_holes_a=[], 
        captive_nuts_a=[], captive_nut_holes_a = [],
        circles_add_a = [],
        circles_remove_a = [],
        slits_a = [],
        cutouts_a = [])
{
    translate([0,0,0]) lasercutoutSquare(x=x, y=y, simple_tabs = st[0], finger_joints = fj[0],
                                simple_tab_holes=simple_tab_holes_a[0], captive_nuts=captive_nuts_a[0],
                                captive_nut_holes = captive_nut_holes_a[0],
                                circles_add = circles_add_a[0], circles_remove = circles_remove_a[0],
                                slits = slits_a[0],
                                cutouts = cutouts_a[0]);

    translate([0,0,z+thickness]) lasercutoutSquare(x=x, y=y, simple_tabs = st[1], finger_joints = fj[1],
                                simple_tab_holes=simple_tab_holes_a[1], captive_nuts=captive_nuts_a[1],
                                captive_nut_holes = captive_nut_holes_a[1],
                                circles_add = circles_add_a[1], circles_remove = circles_remove_a[1],
                                slits = slits_a[1],
                                cutouts = cutouts_a[1]);

    translate([0,0,thickness]) rotate([90,0,0]) lasercutoutSquare(x=x, y=z, finger_joints = fj[2],
                                simple_tab_holes=simple_tab_holes_a[2], captive_nuts=captive_nuts_a[2],
                                captive_nut_holes = captive_nut_holes_a[2],
                                circles_add = circles_add_a[2], circles_remove = circles_remove_a[2],
                                slits = slits_a[2],
                                cutouts = cutouts_a[2]);

    translate([0,y+thickness,thickness]) rotate([90,0,0]) lasercutoutSquare(x=x, y=z, simple_tabs = st[2], 
                                finger_joints = fj[3],
                                simple_tab_holes=simple_tab_holes_a[3], captive_nuts=captive_nuts_a[3],
                                captive_nut_holes = captive_nut_holes_a[3],
                                circles_add = circles_add_a[3], circles_remove = circles_remove_a[3],
                                slits = slits_a[3],
                                cutouts = cutouts_a[3]);
    
    if (sides>4)
    {
        translate([0,0,thickness]) rotate([0,-90,0]) lasercutoutSquare(x=z, y=y, finger_joints = fj[4],
                                simple_tab_holes=simple_tab_holes_a[4], captive_nuts=captive_nuts_a[4],
                                captive_nut_holes = captive_nut_holes_a[4],
                                circles_add = circles_add_a[4], circles_remove = circles_remove_a[4],
                                slits = slits_a[4],
                                cutouts = cutouts_a[4]);
        }
    
    if (sides>5)
    {
        translate([x+thickness,0,thickness]) rotate([0,-90,0]) lasercutoutSquare(x=z, y=y, 
                                simple_tabs = st[3], finger_joints = fj[5],
                                simple_tab_holes=simple_tab_holes_a[5], captive_nuts=captive_nuts_a[5],
                                captive_nut_holes = captive_nut_holes_a[5],
                                circles_add = circles_add_a[5], circles_remove = circles_remove_a[5],
                                slits = slits_a[5],
                                cutouts = cutouts_a[5]);
    }
}
