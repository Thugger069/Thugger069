#!/bin/bash

echo "Testing terminal simulation setup..."

# Check required commands
commands=("figlet" "lolcat" "neofetch" "boxes" "cowsay" "fortune" "bc")
missing_commands=()

for cmd in "${commands[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        missing_commands+=("$cmd")
    fi
done

if [ ${#missing_commands[@]} -ne 0 ]; then
    echo "Error: Missing required commands: ${missing_commands[*]}"
    exit 1
fi

echo "All required commands are available!"

# Test terminal content generation
source ./scripts/update-terminal.sh

echo "Testing content generation..."
generate_terminal_content
if [ ! -f "terminal_output.txt" ]; then
    echo "Error: Failed to generate terminal output"
    exit 1
fi

echo "Testing README generation..."
generate_readme
if [ ! -f "README.md" ]; then
    echo "Error: Failed to generate README"
    exit 1
fi

echo "All tests passed successfully!"
