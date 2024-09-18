#!/data/data/com.termux/files/usr/bin/bash
DIR=`cd $(dirname $0); pwd`
COLORS_DIR="./colors"
count=0

echo -e "Choose scheme you want to use from the list below";

for colors in "$COLORS_DIR"/*; do
  colors_name[count]=$( echo $colors | awk -F'/' '{print $NF}' )
  echo -e "(\e[33m$count\e[0m) ${colors_name[count]}";
  count=$(( $count + 1 ));
done;
count=$(( $count - 1 ));

while true; do
  read -p 'Enter a number, leave blank to not to change: ' number;
  if [[ -z "$number" ]]; then
    break;
  elif ! [[ $number =~ ^[0-9]+$ ]]; then
    echo "Please enter the right number!";
  elif (( $number>=0 && $number<=$count )); then
    eval choice=${colors_name[number]};
    cp -fr "$COLORS_DIR/$choice" "/data/data/com.termux/files/home/.termux/colors.properties";
    break;
  else
    echo "Please enter the right number!";
  fi
done

# Reload / apply new color schemes setting
termux-reload-settings
