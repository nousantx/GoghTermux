/*!
 * Gogh Color Scheme <https://gogh-co.github.io/Gogh>
 *
 * Licensed under the MIT License:
 * Copyright (c) Gogh <https://github.com/Gogh-Co/Gogh/blob/master/LICENSE>
 *
 * Javascript code to convert the Gogh color scheme -
 * into the Termux color definition format.
 *
 * Written by NOuSantx <https://github.com/nousantx>
 */

const fs = require("fs");
const path = require("path");

// Output directory
// const outputDir = "/data/data/com.termux/files/home/.termux/colors"; // default termux colors directory
const outputDir = "colors"; // custom directory

// Get latest themes.json version of Gogh color: https://github.com/Gogh-Co/Gogh/blob/master/data/themes.json
const themes = JSON.parse(fs.readFileSync("themes.json", "utf-8"));

// Convert JSON color format into Termux color definition
function convertJsonTheme(theme) {
  const formatTx = [
    `#${theme.name} | (c) Gogh <https://github.com/Gogh-Co/Gogh/blob/master/LICENSE>`,
    `foreground=${theme.foreground}`,
    `background=${theme.background}`,
    `cursor=${theme.cursor}`,
    `color0=${theme.color_01}`,
    `color1=${theme.color_02}`,
    `color2=${theme.color_03}`,
    `color3=${theme.color_04}`,
    `color4=${theme.color_05}`,
    `color5=${theme.color_06}`,
    `color6=${theme.color_07}`,
    `color7=${theme.color_08}`,
    `color8=${theme.color_09}`,
    `color9=${theme.color_10}`,
    `color10=${theme.color_11}`,
    `color11=${theme.color_12}`,
    `color12=${theme.color_13}`,
    `color13=${theme.color_14}`,
    `color14=${theme.color_15}`,
    `color15=${theme.color_16}`
  ];

  return formatTx.join("\n");
}

// Create directory if it doesn't exist
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

// Convert and save each theme
themes.forEach(theme => {
  const termuxTheme = convertJsonTheme(theme);
  const fileName = `${theme.name.replace(/ /g, "-").toLowerCase()}.properties`;
  const filePath = path.join(outputDir, fileName);

  fs.writeFileSync(filePath, termuxTheme);
  console.log(`Theme '${theme.name}' converted and saved as ${filePath}`);
});
