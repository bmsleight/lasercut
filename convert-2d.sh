# Defines where OpenSCAD is installed

openscad_bin() {
  if [ -n "$OPENSCAD_BIN" ]
  then
    $OPENSCAD_BIN $1
  elif [[ "$OSTYPE" == "darwin"* ]]
  then
    /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD $1
  else 
    openscad $1
  fi
}


# Creates a 2d plan of your 3D model

TMPCSG=/tmp/$(basename $1).csg
TMPSCAD=/tmp/$(basename $1).scad

openscad_bin  "$1 -D generate=1 -o $TMPCSG" 2>&1 >/dev/null | sed -e 's/ECHO: \"\[LC\] //' -e 's/"$//' -e '$a\;' -e  '/WARNING/d'  >$TMPSCAD

sed -i.tmp '1 i\
// May need to adjust location of <lasercut.scad> \
use <lasercut.scad>	;\
\$fn=60;\
projection(cut = false)\
' $TMPSCAD

# Exports in others formats (could be very long)

#openscad_bin "./2d_$1 -o ./2d_$1.csg"
#openscad_bin "./2d_$1 -o ./2d_$1.dxf"
#openscad_bin "./2d_$1 -o ./2d_$1.svg"
#openscad_bin "./$1 -o ./3d_$1.stl"

mv $TMPSCAD $(dirname $1)/$(basename $1)_2d.scad
