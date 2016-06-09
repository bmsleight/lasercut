# Defines where OpenSCAD is installed

openscad_bin() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD $1
  else
    openscad $1
  fi
}


# Creates a 2d plan of your 3D model

openscad_bin "$1 -D generate=1 -o /tmp/$1.csg" 2>&1 >/dev/null | sed -e 's/ECHO: \"\[LC\] //' -e 's/"$//' -e '$a\
;' >./2d_$1

sed -i.tmp '1 i\
use <lasercut.scad>;\
\$fn=60;\
projection(cut = false)\
' ./2d_$1

rm 2d_$1.tmp

# Exports in others formats (could be very long)

#openscad_bin "./2d_$1 -o ./2d_$1.csg"
#openscad_bin "./2d_$1 -o ./2d_$1.dxf"
#openscad_bin "./2d_$1 -o ./2d_$1.svg"
#openscad_bin "./$1 -o ./3d_$1.stl"
