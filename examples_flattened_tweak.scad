use <lasercut/lasercut.scad>;
$fn=60;
module flat(){
projection(cut = false)

// screw thread major dia must be < 3.1
// screw thread length must be < 15.5
// nut thickness must be < 3.1
// nut flats must be < 9.3
lasercutout(thickness = 3.1, 
          points = [[0, 0], [100, 0], [100, 75], [0, 75], [0, 0]]
        , simple_tab_holes = [[360, 23.45, 37.5], [360, 73.45, 37.5]]
        , captive_nuts = [[0, 50, 75, 7]]
        , twist_holes = [[270, 50, 18.75, 37.5]]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [100, 0], [100, 75], [0, 75], [0, 0]]
        , simple_tab_holes = [[360, 23.45, 37.5], [360, 73.45, 37.5]]
        , twist_holes = [[270, 50, 18.75, 37.5]]
        , clips = [[0, 50, 75]]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [100, 0], [100, 181.4], [0, 181.4], [0, 0]]
        , simple_tabs = [[0, 75, 181.4], [0, 25, 181.4], [180, 75, 0], [180, 25, 0]]
        , flat_adjust = [105, -356]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [37.5, 0], [37.5, 200], [0, 200], [0, 0]]
        , twist_connect = [[270, 18.75, 6.2], [270, 18.75, 190.7]]
        , flat_adjust = [42.5, -206]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [93.8, 0], [93.8, 193.8], [0, 193.8], [0, 0]]
        , simple_tabs = [[180, -1.55, 0], [180, -1.55, 196.9], [270, 93.8, -1.55]]
        , captive_nut_holes = [[180, 50, 0]]
        , finger_joints = [[0, 1, 2], [180, 1, 2], [90, 1, 2], [270, 0, 2]]
        , clip_holes = [[0, 50, 190.7]]
		, flat_adjust = [105, -203]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [93.8, 0], [93.8, 193.8], [0, 193.8], [0, 0]]
        , simple_tabs = [[180, -1.55, 0], [270, 93.8, -1.55]]
        , finger_joints = [[0, 0, 2], [180, 1, 2], [90, 1, 2], [270, 0, 2]]
        , circles_remove = [[25, 46.9, 100]]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [93.8, 0], [93.8, 43.8], [0, 43.8], [0, 0]]
        , finger_joints = [[0, 1, 2], [180, 0, 2], [90, 1, 2], [270, 0, 2]]
		, flat_adjust = [-105, -52]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [93.8, 0], [93.8, 43.8], [0, 43.8], [0, 0]]
        , simple_tabs = [[0, -1.55, 43.8], [180, 95.35, 0]]
        , finger_joints = [[0, 1, 2], [180, 1, 2], [90, 1, 2], [270, 0, 2]]
		, flat_adjust = [208, -256]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [43.8, 0], [43.8, 193.8], [0, 193.8], [0, 0]]
        , finger_joints = [[0, 0, 2], [180, 1, 2], [90, 0, 2], [270, 1, 2]]
		, flat_adjust = [53, -203]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [43.8, 0], [43.8, 193.8], [0, 193.8], [0, 0]]
        , simple_tabs = [[0, 45.35, 193.8]]
        , finger_joints = [[0, 0, 2], [180, 1, 2], [90, 0, 2], [270, 1, 2]]
        ) 

;
}

flat();
