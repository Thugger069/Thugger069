#!/bin/bash

echo "Verifying repository setup..."

# Check directory structure
directories=(".github/workflows" "scripts" "assets" "dist")
for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "Created directory: $dir"
    fi
done

# Check file permissions
chmod +x scripts/*.sh
echo "Set execute permissions for scripts"

# Check for required files
required_files=("package.json" "package-lock.json" ".gitignore")
for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Warning: Missing $file"
    fi
done

echo "Verification complete!"
