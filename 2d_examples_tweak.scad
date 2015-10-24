use <lasercut.scad>; $fn=60; 
 projection(cut = false) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [100, 0], [100, 75], [0, 75], [0, 0]]
        , simple_tab_holes = [[360, 23.45, 37.5], [360, 73.45, 37.5]]
        , captive_nuts = [[0, 50, 75]]
        , twist_holes = [[270, 50, 18.75, 37.5]]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [100, 0], [100, 75], [0, 75], [0, 0]]
        , simple_tab_holes = [[360, 23.45, 37.5], [360, 73.45, 37.5]]
        , captive_nuts = [[0, 50, 75]]
        , twist_holes = [[270, 50, 18.75, 37.5]]
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
        , captive_nut_holes = [[0, 50, 193.8], [180, 50, 0]]
        , finger_joints = [[0, 1, 4], [180, 1, 4], [90, 1, 4], [270, 0, 4]]
        , flat_adjust = [105, -203]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [93.8, 0], [93.8, 193.8], [0, 193.8], [0, 0]]
        , simple_tabs = [[180, -1.55, 0], [270, 93.8, -1.55]]
        , finger_joints = [[0, 0, 4], [180, 1, 4], [90, 1, 4], [270, 0, 4]]
        , circles_remove = [[25, 50, 100]]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [93.8, 0], [93.8, 43.8], [0, 43.8], [0, 0]]
        , finger_joints = [[0, 1, 4], [180, 0, 4], [90, 1, 4], [270, 0, 4]]
        , flat_adjust = [-105, -52]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [93.8, 0], [93.8, 43.8], [0, 43.8], [0, 0]]
        , simple_tabs = [[0, -1.55, 43.8], [180, 95.35, 0]]
        , finger_joints = [[0, 1, 4], [180, 1, 4], [90, 1, 4], [270, 0, 4]]
        , flat_adjust = [208, -256]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [43.8, 0], [43.8, 193.8], [0, 193.8], [0, 0]]
        , finger_joints = [[0, 0, 4], [180, 1, 4], [90, 0, 4], [270, 1, 4]]
        , flat_adjust = [53, -203]
        ) 

lasercutout(thickness = 3.1, 
          points = [[0, 0], [43.8, 0], [43.8, 193.8], [0, 193.8], [0, 0]]
        , simple_tabs = [[0, 45.35, 193.8]]
        , finger_joints = [[0, 0, 4], [180, 1, 4], [90, 0, 4], [270, 1, 4]]
        ) 

;
