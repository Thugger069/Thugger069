#!/bin/bash

# Current timestamp and user
CURRENT_TIME="2025-01-24 13:35:20"
USERNAME="Thugger069"

# Generate ASCII art welcome message
generate_ascii_welcome() {
    mkdir -p assets
    
    {
        echo "╔════════════════════════════════════════╗"
        echo "║                                        ║"
        echo "║  Hi there! I'm ${USERNAME}            ║"
        echo "║  I'm passionate about coding           ║"
        echo "║  and technology.                       ║"
        echo "║                                        ║"
        echo "║  Welcome to my profile!                ║"
        echo "║                                        ║"
        echo "║  Last Updated: ${CURRENT_TIME} UTC    ║"
        echo "║                                        ║"
        echo "╚════════════════════════════════════════╝"
    } > assets/welcome.txt
    
    # Convert to image using ImageMagick if available
    if command -v convert &> /dev/null; then
        convert -background black -fill green -font "DejaVu-Sans-Mono" \
                -pointsize 12 -border 20 -bordercolor black \
                assets/welcome.txt assets/welcome.gif
    fi
}

# Generate the welcome message
generate_ascii_welcome
