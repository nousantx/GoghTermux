# Gogh for Termux

Now you can use [Gogh Color](https://github.com/Gogh-Co/Gogh) in termux app with this simple setup.

## Installation

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

```
▶ ./setcolor.sh help
Usage:
  setcolor.sh -l | --list               # List all available color schemes
  setcolor.sh -n | --number <number>    # Apply a color scheme by number
  setcolor.sh -f | --file <color_file>  # Apply a specific color file
  setcolor.sh -h | --help               # Show this help message

Examples:
  setcolor.sh -l
  setcolor.sh -n 2
  setcolor.sh -f ./colors/tokyo-night.properties
```

The **Set Color Scheme** script lets you easily change the color scheme of your Termux environment. You can list available color schemes, select a scheme by number, or apply one directly from a file. Below is a quick guide to its usage.

### Usage

```bash
setcolor.sh [options]
```

#### Options:

- **`-l | --list | list`**  
  Lists all available color schemes.

- **`-n <number> | --number <number>`**  
  Applies a color scheme by choosing a number from the list.

- **`-f <file> | --file <file> | file <file>`**  
  Applies a specific color scheme by giving the path to a `.properties` file.

- **`-h | --help | help`**  
  Shows this help message.


### Examples

1. **List available color schemes:**

   ```bash
   ./setcolor.sh -l
   ```

2. **Apply a color scheme by number:**

   ```bash
   ./setcolor.sh -n 1
   ```

3. **Apply a color scheme from a file:**

   ```bash
   ./setcolor.sh -f ./colors/dracula.properties
   ```

4. **Show the help message:**

   ```bash
   ./setcolor.sh -h
   ```

5. **Interactive mode (choose a color scheme by number):**
   ```bash
   ./setcolor.sh
   ```

### How It Works

- **List**: Displays all color schemes in the specified directory, formatted for easy reading, with corresponding numbers.
- **Apply by Number**: Selects a color scheme using the number from the list.
- **Apply by File**: Directly applies a color scheme by specifying the full file path.
- **Interactive Mode**: If no options are provided, you can interactively choose a color scheme by entering its number.

This script makes it easy to customize your Termux terminal colors with just a few simple commands.

## Manual Installation

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

## Get the Latest `themes.json` File (optional)

This repository also contains `themes.json` file, but it may be updated again in the future, so you can always find the newest version [here](https://github.com/Gogh-Co/Gogh/blob/master/data/themes.json).
