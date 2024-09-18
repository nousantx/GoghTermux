# Gogh for Termux

Now you can use [Gogh Color](https://github.com/Gogh-Co/Gogh) in termux app with this simple setup.

## Steps

### Clone this Repository

You may need to clone this repository to use the scripts from this repository to build and setting color:

```sh
git clone https://github.com/nousantx/GoghTermux

cd GoghTermux
```

### Building Colors

You need to build the color schemes with python or javascript code in this repository:

Using python:

```sh
python color.py
```

Or use `nodejs` if you don't have python on your terminal:

```sh
node color.js
```

The default output directory is `./colors`, and you may need to list with `ls` command to make sure the colors scheme is successfully generated.

## Set Color Scheme

After the colors is generated, you can use the `setcolor.sh` script to apply the color you desired:

```sh
sh setcolor.sh
# or
bash setcolor.sh
```

After running the scripts, you will get all color schemes list with its number, you can type the number of the color scheme you want.

You can also find the color name in the [official Gogh website](https://gogh-co.github.io/Gogh).

Tips: You can also make it easier to find exact color name with `grep` command, example:

```sh
# bash setcolor.sh | grep <color_name>
bash setcolor.sh | grep tokyo
```

And then wait a bit for the script to run and showing the `Enter a number` section, and done!

### Manual Installation

Let's say you can't run the `setcolor.sh` file, you can manually install the color like this:

```sh
# make sure you're inside GoghTermux directory and already build the colors
cp colors/<color_scheme> ~/.termux/colors.properties
```

This is the example:

```sh
cp colors/zenburn.properties ~/.termux/colors.properties
```

And then, you need to run `termux-reload-settings` command to load new color scheme.

### Get the Latest `themes.json` File (optional)

This repository also contains `themes.json` file, but it may be updated again in the future, so you can always find the newest version [here](https://github.com/Gogh-Co/Gogh/blob/master/data/themes.json).
