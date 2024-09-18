#!/data/data/com.termux/files/usr/bin/bash

DIR=$(
  cd "$(dirname "$0")"
  pwd
)
COLORS_DIR="$HOME/.termux/colors"
count=0

# Function to apply color scheme
apply_color_scheme() {
  local scheme="$1"
  cp -fr "$scheme" "/data/data/com.termux/files/home/.termux/colors.properties"
  termux-reload-settings
  echo -e "\e[32mApplied color scheme: $scheme\e[0m"
  exit 0
}

# Function to format scheme names (remove .properties and capitalize first letter)
format_scheme_name() {
  local scheme="$1"
  scheme=$(basename "$scheme" .properties)
  scheme=${scheme//-/ }
  echo "$scheme" | awk '{ for (i=1; i<=NF; ++i) $i=toupper(substr($i,1,1)) tolower(substr($i,2)); print }'
}

# Function to list available color schemes
list_schemes() {
  echo "Available color schemes:"
  count=0
  for colors in "$COLORS_DIR"/*; do
    scheme_name=$(format_scheme_name "$colors") # Format the scheme name
    echo -e "(\e[33m$count\e[0m) $scheme_name"
    count=$((count + 1))
  done
  exit 0
}

# Check for flags
if [ $# -gt 0 ]; then
  case "$1" in
    -h | --help | help)
      echo -e "\e[33mUsage:\e[0m"
      echo -e "\e[2msetcolor.sh\e[0m \e[33m-l | --list | list\e[0m"
      echo -e "\e[2msetcolor.sh\e[0m \e[33m-n | --number <number>\e[0m"
      echo -e "\e[2msetcolor.sh\e[0m \e[33m-f | --file | file <color_file>\e[0m"
      echo -e "\n\e[33mExample:\e[0m"
      echo -e "\e[2msetcolor.sh\e[0m \e[33m-l\e[0m"
      echo -e "\e[2msetcolor.sh\e[0m \e[33m-n 42\e[0m"
      echo -e "\e[2msetcolor.sh\e[0m \e[33m-f ./colors/tokyo-night.properties\e[0m"
      exit 1
      ;;
    -l | --list | list)
      list_schemes
      ;;
    -n | --number | number)
      if [[ "$2" =~ ^[0-9]+$ ]]; then
        for colors in "$COLORS_DIR"/*; do
          if [ $count -eq "$2" ]; then
            apply_color_scheme "$colors"
          fi
          count=$((count + 1))
        done
        echo -e "\e[31mError: Color scheme number $2 not found.\e[0m"
        exit 1
      else
        echo -e "\e[31mError: Please provide a valid number after -n or --number.\e[0m"
        exit 1
      fi
      ;;
    -f | --file | file)
      if [ -f "$2" ]; then
        apply_color_scheme "$2"
      else
        echo -e "\e[31mError: Invalid file or path. Please provide a valid color file.\e[0m"
        exit 1
      fi
      ;;
    *)
      echo -e "\e[31mError: Unknown option '$1'. Use '-h | --help | help' flag for available options."

      exit 1
      ;;
  esac
fi

# If no argument, proceed with interactive selection
echo -e "Choose scheme you want to use from the list below:"
declare -a colors_name
for colors in "$COLORS_DIR"/*; do
  colors_name[count]=$(format_scheme_name "$colors")
  echo -e "(\e[33m$count\e[0m) ${colors_name[count]}"
  count=$((count + 1))
done
count=$((count - 1))

while true; do
  read -p 'Enter a number, leave blank to not change: ' number
  if [[ -z "$number" ]]; then
    break
  elif ! [[ "$number" =~ ^[0-9]+$ ]]; then
    echo -e "\e[31mPlease enter the correct number!\e[0m"
  elif ((number >= 0 && number <= count)); then
    choice="${colors_name[number]}"
    apply_color_scheme "$COLORS_DIR/$choice.properties"
  else
    echo -e "\e[31mPlease enter the correct number!\e[0m"
  fi
done
