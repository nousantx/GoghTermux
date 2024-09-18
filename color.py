############################################################
# Gogh Color Scheme <https://gogh-co.github.io/Gogh>
#
# Licensed under the MIT License:
# Copyright (c) Gogh <https://github.com/Gogh-Co/Gogh/blob/master/LICENSE>
#
# Python script to convert the Gogh color scheme -
# into the Termux color definition format.
#
# Written by NOuSantx <https://github.com/nousantx>
############################################################

import json
import os

# Define the output directory for Termux color schemes
# output_dir = '/data/data/com.termux/files/home/.termux/colors' # default termux colors directory
output_dir = 'colors' # custom directory

# Get latest themes.json version of Gogh color: https://github.com/Gogh-Co/Gogh/blob/master/data/themes.json
with open('themes.json', 'r') as file:
  themes = json.load(file)

# Function to convert JSON color format into Termux color definition
def convert_json_theme(theme):
  """
  Convert a JSON theme to Termux color properties format.
  
  Args:
  theme (dict): A dictionary containing theme color definitions.
  
  Returns:
  str: Formatted string of Termux color properties.
  """
  # Create a list of formatted strings for each color property
  format_tx = [
    f"# {theme['name']} | (c) Gogh <https://github.com/Gogh-Co/Gogh/blob/master/LICENSE>",
    f"foreground={theme['foreground']}",
    f"background={theme['background']}",
    f"cursor={theme['cursor']}",
    # Colors 0-15 correspond to the 16 ANSI colors
    f"color0={theme['color_01']}",  # Black
    f"color1={theme['color_02']}",  # Red
    f"color2={theme['color_03']}",  # Green
    f"color3={theme['color_04']}",  # Yellow
    f"color4={theme['color_05']}",  # Blue
    f"color5={theme['color_06']}",  # Magenta
    f"color6={theme['color_07']}",  # Cyan
    f"color7={theme['color_08']}",  # White
    f"color8={theme['color_09']}",  # Bright Black
    f"color9={theme['color_10']}",  # Bright Red
    f"color10={theme['color_11']}", # Bright Green
    f"color11={theme['color_12']}", # Bright Yellow
    f"color12={theme['color_13']}", # Bright Blue
    f"color13={theme['color_14']}", # Bright Magenta
    f"color14={theme['color_15']}", # Bright Cyan
    f"color15={theme['color_16']}"  # Bright White
  ]
  
  # Join the formatted strings with newlines
  return "\n".join(format_tx)

# Create the output directory if it doesn't exist
os.makedirs(output_dir, exist_ok=True)

# Process each theme in the themes list
for theme in themes:
  # Convert the JSON theme to Termux format
  termux_theme = convert_json_theme(theme)
  
  # Create a filename for the theme, replacing spaces with hyphens and adding the .properties extension
  file_name = f"{theme['name'].replace(' ', '-').lower()}.properties"
  
  # Construct the full file path
  file_path = os.path.join(output_dir, file_name)
  
  # Write the converted theme to a file
  with open(file_path, 'w') as out_file:
    out_file.write(termux_theme)
  
  # Print a message indicating successful conversion and saving
  print(f"Theme '{theme['name']}' converted and saved as {file_path}")