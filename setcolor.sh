#!/data/data/com.termux/files/usr/bin/bash

DIR=$(
  cd "$(dirname "$0")"
  pwd
)
COLORS_DIR="./output_examples"
count=0

# Color helper
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Function to apply color scheme
apply_color_scheme() {
  local scheme="$1"
  cp -fr "$scheme" "/data/data/com.termux/files/home/.termux/colors.properties"
  termux-reload-settings
  echo -e "${GREEN}Applied color scheme: $scheme${RESET}"
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
  echo -e "${YELLOW}Available color schemes:${RESET}"
  count=0
  for colors in "$COLORS_DIR"/*; do
    scheme_name=$(format_scheme_name "$colors")
    echo -e "(${YELLOW}$count${RESET}) $scheme_name"
    count=$((count + 1))
  done
  exit 0
}

# Function to display help message
show_help() {
  echo -e "${YELLOW}Usage:${RESET}"
  echo -e "  setcolor.sh                           # Interactive mode"
  echo -e "  setcolor.sh ${YELLOW}-l | --list${RESET}               # List all available color schemes"
  echo -e "  setcolor.sh ${YELLOW}-n | --number <number>${RESET}    # Apply a color scheme by number"
  echo -e "  setcolor.sh ${YELLOW}-f | --file <color_file>${RESET}  # Apply a specific color file"
  echo -e "  setcolor.sh ${YELLOW}-h | --help${RESET}               # Show this help message"
  echo -e "\n${YELLOW}Examples:${RESET}"
  echo -e "  setcolor.sh ${YELLOW}-l${RESET}"
  echo -e "  setcolor.sh ${YELLOW}-n 2${RESET}"
  echo -e "  setcolor.sh ${YELLOW}-f ./colors/tokyo-night.properties${RESET}"
  exit 0
}

# Check for flags
if [ $# -gt 0 ]; then
  case "$1" in
    -h | --help | help)
      show_help
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
        echo -e "${RED}Error: Color scheme number $2 not found.${RESET}"
        exit 1
      else
        echo -e "${RED}Error: Please provide a valid number after -n or --number.${RESET}"
        exit 1
      fi
      ;;
    -f | --file | file)
      if [ -f "$2" ]; then
        apply_color_scheme "$2"
      else
        echo -e "${RED}Error: Invalid file or path. Please provide a valid color file.${RESET}"
        exit 1
      fi
      ;;
    *)
      echo -e "${RED}Error: Unknown option '$1'. Use '-h | --help | help' flag for available options.${RESET}"
      exit 1
      ;;
  esac
fi

# If no argument, proceed with interactive selection
echo -e "Choose a scheme you want to use from the list below:"
declare -a colors_name
declare -a colors_files
for colors in "$COLORS_DIR"/*; do
  colors_name[count]=$(format_scheme_name "$colors")
  colors_files[count]="$colors"
  echo -e "(${YELLOW}$count${RESET}) ${colors_name[count]}"
  count=$((count + 1))
done

count=$((count - 1))

while true; do
  read -p 'Enter a number, leave blank to not change: ' number
  if [[ -z "$number" ]]; then
    break
  elif ! [[ "$number" =~ ^[0-9]+$ ]]; then
    echo -e "${RED}Please enter a valid number!${RESET}"
  elif ((number >= 0 && number <= count)); then
    apply_color_scheme "${colors_files[number]}"
  else
    echo -e "${RED}Please enter a valid number!${RESET}"
  fi
done
