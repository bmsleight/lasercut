#!/bin/bash

function usage() {
  echo "convert-2d.sh <SCAD_FILE> [dxf|svg|csg|stl]"
}

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

SCAD_FILE=$1
if [ -z "$SCAD_FILE" ]; then
    usage 
    exit 1
fi
if [ ! -r "$SCAD_FILE" ]; then 
    echo "Can not read file $SCAD_FILE"
    exit 1
fi

EXT=$2
[ -z "$EXT" ] && EXT=dxf

SCAD_FILE_WO_EXT=${SCAD_FILE%.*}
SCAD_2D_FILE="${SCAD_FILE_WO_EXT}_2d.scad"
OUTPUT_FILE="${SCAD_FILE_WO_EXT}.${EXT}"

openscad_bin "$1 -D generate=1 --export-format csg -o /dev/null" 2>&1 | \
        sed -e 's/ECHO: \"\[LC\] //' \
        -e 's/"$//' \
        -e '$a\;' \
        -e  '/WARNING/d' \
        -e '/Using default value/d' \
        -e '/^+/d' > $SCAD_2D_FILE

sed -i '1 i\
// May need to adjust location of <lasercut.scad> \
use <lasercut.scad>	;\
\$fn=60;\
projection(cut = false)\
' $SCAD_2D_FILE


openscad_bin "$SCAD_2D_FILE -o $OUTPUT_FILE"

echo "Output files:"
ls -l "$OUTPUT_FILE" "$SCAD_2D_FILE"
