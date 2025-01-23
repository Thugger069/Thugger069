#!/bin/bash

# Create terminalizer config
cat > config.yml <<EOF
# Specify a command to be executed
# like '/bin/bash -l', 'ls', or any other commands
# the default is bash for Linux
# or powershell.exe for Windows
command: bash -l

# Specify the current working directory path
# the default is the current working directory path
cwd: /home/runner

# Export additional ENV variables
env:
  recording: true

# Explicitly set the number of columns
# or use '\\\x1b[8;rows;cols t' in command
cols: 100

# Explicitly set the number of rows
# or use '\\\x1b[8;rows;cols t' in command
rows: 20

# Amount of times to repeat GIF
# If value is -1, play once
# If value is 0, loop indefinitely
# If value is a positive number, loop n times
repeat: 0

# Quality
# 1 - 100
quality: 100

# Delay between frames in ms
# If the value is 'auto' use the actual recording delays
frameDelay: auto

# Maximum delay between frames in ms
# Ignored if the 'frameDelay' isn't set to 'auto'
# Set to 'auto' to prevent limiting the max idle time
maxIdleTime: 2000

# The surrounding frame box
# The 'type' can be null, window, floating, or solid
# To hide the title use the value null
# Don't forget to add a backgroundColor style with a null as type
frameBox:
  type: solid
  title: null
  style:
    backgroundColor: "#1a1b26"
    boxShadow: none
    margin: 0px

# Add a watermark image to the rendered gif
# You need to specify an absolute path for
# the image on your machine or a URL
watermark:
  imagePath: null
  style:
    position: absolute
    right: 15px
    bottom: 15px
    width: 100px
    opacity: 0.9

# Cursor style can be one of
# 'block', 'underline', or 'bar'
cursorStyle: block

# Font family
# You can use any font that is installed on your machine
fontFamily: "Monaco, Lucida Console, Ubuntu Mono, Monospace"

# The size of the font
fontSize: 14

# The height of lines
lineHeight: 1

# The spacing between letters
letterSpacing: 0

# Theme
theme:
  background: "#1a1b26"
  foreground: "#a9b1d6"
  cursor: "#f1c40f"
  black: "#000000"
  red: "#ff0000"
  green: "#33ff00"
  yellow: "#ffff00"
  blue: "#0066ff"
  magenta: "#cc00ff"
  cyan: "#00ffff"
  white: "#d0d0d0"
  brightBlack: "#808080"
  brightRed: "#ff0000"
  brightGreen: "#33ff00"
  brightYellow: "#ffff00"
  brightBlue: "#0066ff"
  brightMagenta: "#cc00ff"
  brightCyan: "#00ffff"
  brightWhite: "#ffffff"
EOF

# Create recording script
cat > record.sh <<EOF
#!/bin/bash
echo "Hi there! I'm Thugger069."
sleep 1
echo "I'm passionate about coding and technology."
sleep 1
echo "Welcome to my GitHub profile! 🚀"
EOF

# Make recording script executable
chmod +x record.sh

# Record terminal session
terminalizer record demo --config config.yml --command "./record.sh"

# Render as GIF
terminalizer render demo --output assets/terminal.gif

# Clean up
rm config.yml record.sh demo.yml
