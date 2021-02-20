#!/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

SOURCE_FILE=$(basename $1)
NAME=${SOURCE_FILE%.scad}
CONVERTED_FILE="$NAME-flat.scad"
DEST_FOLDER="$NAME"

TMPCSG="/tmp/$NAME.csg"
TMPSCAD="/tmp/$NAME.scad"

if [ $# -lt 1 ] ; then
	echo "> ${BOLD}Missing argument. No SCAD file given! Example: ./convert-2d.sh example.scad${NORMAL}" 1>&2
	exit 1
fi

if [ ! -f "$SOURCE_FILE" ]; then
	echo "> ${BOLD}The given $SOURCE_FILE does not exist?${NORMAL}" 1>&2
	exit 1
fi

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

makeFlat(){
	# Create a 2d plan of your 3D model
	echo "> generate ${BOLD}2d flat scad file${NORMAL}"

	openscad_bin  "$SOURCE_FILE -D generate=1 -o $TMPCSG" 2>&1 >/dev/null | sed -e 's/ECHO: \"\[LC\] //' -e 's/"$//' -e '$a\
	;' -e  '/WARNING/d'  >$TMPSCAD

	echo "use <lasercut.scad>;
	\$fn=60;
	module flat(){
	projection(cut = false)
	" > $CONVERTED_FILE

	cat $TMPSCAD >> $CONVERTED_FILE

	echo "
	}

	// uncomment if you need an extruded version for e.g. 3d printing, cnc milling
	//linear_extrude(height=YOUR_HEIGHT_VALUE)
	flat();" >> $CONVERTED_FILE
}

makeFlat


# Exports in others formats (could be very long)
if [ ! -d "$DEST_FOLDER" ]; then
	echo "> create folder ${BOLD}${NAME}${NORMAL}";
	mkdir -p "$DEST_FOLDER"
fi

echo "> save ${BOLD}csg file${NORMAL}";
openscad_bin "./$CONVERTED_FILE -o ./$DEST_FOLDER/$NAME.csg -q"

echo "> save ${BOLD}dxf file${NORMAL}";
openscad_bin "./$CONVERTED_FILE -o ./$DEST_FOLDER/$NAME.dxf -q"

echo "> save ${BOLD}svg file${NORMAL}";
openscad_bin "./$CONVERTED_FILE -o ./$DEST_FOLDER/$NAME.svg -q"

echo "> save ${BOLD}3d stl file${NORMAL}";
openscad_bin "./$SOURCE_FILE -D foo=1 -o ./$DEST_FOLDER/$NAME.stl -q"

#echo "> save ${BOLD}3d stl flat file${NORMAL}";
#openscad_bin "./$CONVERTED_FILE -o ./$DEST_FOLDER/$NAME-3d-flat.stl"

echo "> ${BOLD}done!${NORMAL}";