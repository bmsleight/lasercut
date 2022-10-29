#!/bin/bash

# Defines where OpenSCAD is installed
openscad_bin() {
  set +x
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

SCAD_FILE=$1
SCAD_FILE_WO_EXT=${SCAD_FILE%.*}

# Creates a 2d plan of your 3D model
TMPCSG=/tmp/$SCAD_FILE_WO_EXT.csg
TMPSCAD=/tmp/$SCAD_FILE_WO_EXT.scad
SCAD_2D_FILE="${SCAD_FILE_WO_EXT}_2d.scad"

openscad_bin "$1 -D generate=1 -o $TMPCSG" 2>&1 >/dev/null | \
        sed -e 's/ECHO: \"\[LC\] //' -e 's/"$//' -e '$a\;' -e  '/WARNING/d' -e '/Using default value/d' -e '/set +x/d'  >$TMPSCAD

sed -i.tmp '1 i\
// May need to adjust location of <lasercut.scad> \
use <lasercut.scad>	;\
\$fn=60;\
projection(cut = false)\
' $TMPSCAD

mv $TMPSCAD $SCAD_2D_FILE

# Exports in others formats (could be very long)
#openscad_bin "./$SCAD_2D_FILE -o ${SCAD_FILE_WO_EXT}.stl"
#openscad_bin "./$SCAD_2D_FILE -o ${SCAD_FILE_WO_EXT}.csg"
#openscad_bin "./$SCAD_2D_FILE -o ${SCAD_FILE_WO_EXT}.svg"
openscad_bin "./$SCAD_2D_FILE -o ${SCAD_FILE_WO_EXT}.dxf"



