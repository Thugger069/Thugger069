#!/bin/bash

# Generate hacker header animation
convert -size 800x200 xc:black -gravity center -pointsize 50 \
  -font "Fira-Code" -fill "#39ff14" -draw "text 0,0 'CYBER Glitch'" \
  assets/frame1.png

convert -size 800x200 xc:black -gravity center -pointsize 50 \
  -font "Fira-Code" -fill "#ff073a" -draw "text 0,0 'CYBER Glitch'" \
  assets/frame2.png

convert -size 800x200 xc:black -gravity center -pointsize 50 \
  -font "Fira-Code" -fill "#00a3e0" -draw "text 0,0 'CYBER Glitch'" \
  assets/frame3.png

# Add glitch effect
for i in {1..3}; do
  convert assets/frame$i.png \
    \( +clone -crop 800x20+0+0 +repage -negate \) \
    \( +clone -crop 800x15+0+30 +repage -negate \) \
    -compose lighten -composite assets/frame${i}_glitch.png
done

# Create animated GIF
convert -delay 100 -loop 0 assets/frame*_glitch.png assets/hacker_header.gif

# Cleanup
rm assets/frame*.png