// May need to adjust location of <lasercut.scad> 
use <../lasercut.scad>	;
$fn=60;
projection(cut = false)

lasercutout(thickness = 3.1, 
          points = [[0, 0], [123.8, 0], [123.8, 93.8], [0, 93.8], [0, 0]]
        , simple_tabs = [[180, -1.55, 0], [180, -1.55, 96.9], [270, 123.8, -1.55]]
        , finger_joints = [[0, 1, 2], [180, 1, 2], [90, 1, 2], [270, 0, 2]]
        , milling_bit = 6.35
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [123.8, 0], [123.8, 93.8], [0, 93.8], [0, 0]]
        , simple_tabs = [[180, -1.55, 0], [270, 123.8, -1.55]]
        , finger_joints = [[0, 0, 2], [180, 1, 2], [90, 1, 2], [270, 0, 2]]
        , milling_bit = 6.35
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [123.8, 0], [123.8, 58.8], [0, 58.8], [0, 0]]
        , finger_joints = [[0, 1, 2], [180, 0, 2], [90, 1, 2], [270, 0, 2]]
        , milling_bit = 6.35
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [123.8, 0], [123.8, 58.8], [0, 58.8], [0, 0]]
        , simple_tabs = [[0, -1.55, 58.8], [180, 125.35, 0]]
        , finger_joints = [[0, 1, 2], [180, 1, 2], [90, 1, 2], [270, 0, 2]]
        , milling_bit = 6.35
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [58.8, 0], [58.8, 93.8], [0, 93.8], [0, 0]]
        , finger_joints = [[0, 0, 2], [180, 1, 2], [90, 0, 2], [270, 1, 2]]
        , milling_bit = 6.35
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [58.8, 0], [58.8, 93.8], [0, 93.8], [0, 0]]
        , simple_tabs = [[0, 60.35, 93.8]]
        , finger_joints = [[0, 0, 2], [180, 1, 2], [90, 0, 2], [270, 1, 2]]
        , milling_bit = 6.35
        ) 

;
