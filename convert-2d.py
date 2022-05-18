"""
Process a lasercut box to enable its production on a laser cutter, 3D printer, or other comparable device

Processes a given 3D OpenSCAD scad file using the lasercut library to create a file with the sides that can be used
by a laser cutter. Or if ff a value for extrusion thickness is given, the exported file would be 3D and
could be used by a 3D printer

The OpenSCAD executable is expected to be at the default location for the current operating system
    - Linux - openscad
    - OSX - /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
    - Windows - "Program Files\\OpenSCAD\\openscad.exe" or "Program Files(x86)\\OpenSCAD\\openscad.exe"
The path to the executable can also be set via the "OPENSCAD_BIN" environmental variable or the --openscadbin option
"""

import os
import argparse
import subprocess
import textwrap

extensions_3d = ['.stl', '.off', '.amf', '.3mf']
extensions_2d = ['.dxf', '.svg', '.pdf']
extensions_valid = ['.scad', '.csg'] + extensions_3d + extensions_2d


def exit_with_error(error_str: str) -> None:
    """
    Print the given string before exiting the script
    :param error_str: String to print
    :return: None
    """
    print(error_str)
    exit(1)


def get_openscad_path() -> str:
    """
    Tries to determine the path to the openscad binary

    Can determine path if OS is OSX, Windows (32-bit and 64-bit installations),
    and Linux. Path is based on OS. The default installation paths are checked.

    If the environmental value "OPENSCAD_BIN" is set that value will be used
    without checking if the binary exists there.

    :return: Expected path to openscad
    """
    out_path = None
    enviro_val = os.environ.get("OPENSCAD_BIN")
    if enviro_val is not None:
        if not os.path.isfile(enviro_val):
            exit_with_error(f'Invalid environmental value for the path to '
                            f'OpenSCAD binary, OPENSCAD_BIN: "{enviro_val}"')
        out_path = enviro_val
    else:
        import platform

        python_platform = platform.platform()

        if "Darwin" in python_platform:
            # OSX
            out_path = "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

        elif "Windows" in python_platform:
            # Windows. Determine if openSCAD is 32-bit or 64-bit
            prog_files_32_path = os.environ["PROGRAMFILES"]
            prog_files_64_path = os.environ["ProgramW6432"]
            prog_files_openscad = "OpenSCAD/openscad.exe"

            openscad_32_path = os.path.join(prog_files_32_path, prog_files_openscad)
            if os.path.isfile(openscad_32_path):
                out_path = os.path.normpath(openscad_32_path)

            elif prog_files_64_path is not None:
                openscad_64_path = os.path.join(prog_files_64_path, prog_files_openscad)

                if os.path.isfile(openscad_64_path):
                    out_path = os.path.normpath(openscad_64_path)

        else:
            # Assume Linux. See if the openscad exists on the path
            from shutil import which

            if which("openscad") is not None:
                out_path = "openscad"

    return out_path


def process_scad_file(in_scad_path: str, out_scad_path: str, library_path: str, extrusion_thick: float = 0) -> None:
    """
    Process the input 3D OpenSCAD file to generate a file of each piece pieces

    The output of OpenSCAD needs is processed in order to make it a valid .scad file.

    :param in_scad_path: Path of the 3D OpenSCAD file to process
    :param out_scad_path: Where to put the generated OpenSCAD file
    :param library_path: Path to the lasercut.scad library. Value is placed directly in "include <XXX>" string
    :param extrusion_thick: If value is greater than 0, this is the number of mm to extrude the flattened surfaces.
        If value is less than or equal to 0, outputted file will be 2D.
    :return: None
    """

    # A file is needed for OpenSCAD to open and run the lasercut specific
    # generator. It will be deleted.
    temp_file_base_name = os.path.splitext(os.path.basename(out_scad_path))[0]
    temp_file_base_name = f"temp_{temp_file_base_name}.csg"
    temp_csg = os.path.join(os.path.dirname(out_scad_path),
                            temp_file_base_name)

    print(f'Processing "{os.path.basename(in_scad_path)}"')
    cmd_output = subprocess.run(
        f'"{openscad_path}" "{in_scad_path}" -D generate=1 -o "{temp_csg}"',
        capture_output=True,
    )

    # The CSG file was only used to get the output, delete it immediately
    os.remove(temp_csg)

    if cmd_output.returncode != 0:
        exit_with_error(f"Failed to convert to csg file.\nError: {cmd_output.stderr}")

    # Process the outputted text (rendered text via stderr)
    output_file_contents = cmd_output.stderr.decode()
    output_file_contents = output_file_contents.replace("\r\n", "\n")

    # Strip the string 'ECHO: "[LC] ' and its closing '"' and remove warnings
    import re

    output_file_contents = re.sub(r'ECHO: "\[LC] ', "", output_file_contents)
    output_file_contents = re.sub(r'"\n', "\n", output_file_contents)
    output_file_contents = re.sub(r"WARNING.*", "", output_file_contents)
    output_file_contents += ";"

    # Add the library and some other basic commands to make a working scad file
    scad_header = f'use <{library_path}>;\n'\
                  '$fn=60;\n'\
                  'module flat(){\n'\
                  'projection(cut = false)\n\n'

    output_file_contents = scad_header + output_file_contents

    # Close flat()
    output_file_contents += "\n}\n\n"

    # If a thickness was given, extrude the module
    if extrusion_thick > 0:
        output_file_contents += f"linear_extrude(height={extrusion_thick})\n"

    output_file_contents += "flat();\n"

    # Write the output file
    with open(out_scad_path, "w") as outfile:
        outfile.write(output_file_contents)


# Start the actual script
parser = argparse.ArgumentParser("Convert a 3D OpenSCAD lasercut box to a 2D OpenSCAD file for ready for cutting")
parser.add_argument('source',
                    type=str,
                    help='Path to the 3D OpenSCAD to convert. Must be a scad or csg file')

parser.add_argument('output',
                    nargs='?',
                    type=str,
                    help='Path to output file. File extension determines type. '
                         'Valid types are scad, svg, dxf, stl, and any other export types supported by OpenSCAD.'
                         'If an invalid file type is given, a scad file will be created at the given location.'
                         'If no path is given, the output file will be put in the same folder as the source with'
                         'a "2D" suffix/')

parser.add_argument('--extrude', '-x',
                    type=float,
                    default=0,
                    help='If 3D printing or using another system that needs thickness, this is the number of mm'
                         'to extrude the outputted shapes. If 0 or less this will be ignored. Output file type '
                         f'cannot be 2D ({", ".join(extensions_2d)}) when this is set.')
parser.add_argument('--keep', '-k',
                    action='store_true',
                    help='Keep the intermediate scad file if output type is not already scad')

parser.add_argument('--library', '-l',
                    default='lasercut/lasercut.scad',
                    help='Path to the lasercut.scad library. Value is place in the include <XXX> string.')

parser.add_argument('--openscadbin', '-b',
                    type=str,
                    help='Use the OpenSCAD executable at the given path instead of the default path for the OS')

args = parser.parse_args()

# Verify that the given file exists, and that it is a valid source file
source_abs_path = os.path.normcase(os.path.abspath(args.source))
if not os.path.isfile(source_abs_path):
    exit_with_error(f"Invalid source file: {args.source}")
else:
    not_ext, ext = os.path.splitext(source_abs_path)
    if ext != '.scad':
        exit_with_error('Source file must be a "scad" file')

# Get the path to openSCAD
if args.openscadbin is not None:
    openscad_path = args.openscadbin

    if not os.path.isfile(openscad_path):
        exit_with_error(f'Could not find the OpenSCAD binary at the given path, "{openscad_path}"')
else:
    openscad_path = get_openscad_path()

if openscad_path is None:
    exit_with_error("Could not find the openscad executable")

# Generate an output file name based on the source file in case none is given
source_basename = os.path.basename(source_abs_path)
source_base_no_ext = os.path.splitext(source_basename)[0]
output_file_base = f"{source_base_no_ext}_flattened"

# Create an output path is none was given
processed_scad_path = None
output_abs_path = None
generate_non_scad_file = False
output_extension = None

if args.output is None:
    # Default to a scad file in the same directory as the source
    source_folder = os.path.dirname(source_abs_path)
    processed_scad_path = os.path.join(source_folder, f"{output_file_base}.scad")
else:
    output_dir = os.path.abspath(os.path.dirname(args.output))
    if not os.path.isdir(output_dir) \
            and not os.path.isdir(args.output):
        # An invalid output directory was given
        exit_with_error(f"Output directory does not exist: {output_dir}")

    if os.path.isdir(args.output):
        # The given output is only a directory, generate the output file name from the source
        processed_scad_path = os.path.join(args.output, f"{output_file_base}.scad")

    else:
        output_abs_path = os.path.normcase(os.path.abspath(args.output))
        output_no_ext, output_extension = os.path.splitext(output_abs_path)

        if output_extension not in extensions_valid:
            # If an invalid extension is given, default to scad
            output_extension = '.scad'

        elif args.extrude > 1 and output_extension in extensions_2d:
            # Cannot export to a 2D format when the contents are 3D (extruded)
            exit_with_error(f'Cannot export to a 2D format, "{output_extension}", '
                            f'when extrude, "{args.extrude}", is greater than 0')

        generate_non_scad_file = output_extension != '.scad'

        processed_scad_path = output_no_ext + '.scad'


processed_scad_path = os.path.normcase(processed_scad_path)
output_abs_path = os.path.normcase(output_abs_path)

# Keep the intermediate file if it already exists or the user wanted it kept
keep_intermediate_file = args.keep or os.path.isfile(processed_scad_path)

# The source file must be different than the intermediate SCAD file and the output file
# If the output file is a SCAD file it will already be equal to processed_scad_path
if source_abs_path == processed_scad_path:
    exit_with_error("Source path and processed SCAD path are the same. Please change your output file name.")

# Process the input openscad file
process_scad_file(source_abs_path, processed_scad_path,
                  library_path=args.library, extrusion_thick=args.extrude)

# Render the file as the desired file type
if generate_non_scad_file:

    print(f"Rendering and exporting as {output_extension}")

    output = subprocess.run(
        f'"{openscad_path}" "{processed_scad_path}" -o "{output_abs_path}"',
        capture_output=True,
    )

    if output.returncode != 0:
        exit_with_error(f"Failed to convert to {output_extension}:\n{output.stderr}")

    # Delete the intermediate, processed scad file if not requested otherwise
    if not keep_intermediate_file:
        os.remove(processed_scad_path)
