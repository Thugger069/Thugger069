#!/bin/bash

echo "Verifying GIF generation setup..."

# Check for required tools
tools=("convert" "xvfb-run" "terminalizer" "gifsicle")
missing_tools=()

for tool in "${tools[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        missing_tools+=("$tool")
    fi
done

if [ ${#missing_tools[@]} -ne 0 ]; then
    echo "Warning: Missing tools: ${missing_tools[*]}"
    echo "Falling back to ASCII art generation..."
    ./scripts/generate-welcome-ascii.sh
else
    echo "All required tools are available!"
fi

# Check electron sandbox permissions
ELECTRON_PATH="/opt/hostedtoolcache/node/16.20.2/x64/lib/node_modules/terminalizer/node_modules/electron/dist/chrome-sandbox"
if [ -f "$ELECTRON_PATH" ]; then
    echo "Checking electron sandbox permissions..."
    ls -l "$ELECTRON_PATH"
fi

echo "Verification complete!"
