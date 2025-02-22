#!/bin/bash
set -euo pipefail

CONFIG_FILE="./snake-config.yml"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "🛠️ Creating snake configuration file..."
  cat > "$CONFIG_FILE" << 'EOF'
command: nsnake
cols: 80
rows: 24
repeat: 0
quality: 100
frameDelay: auto
maxIdleTime: 2000
cursorStyle: block
theme:
  background: "transparent"
  foreground: "#FFFFFF"
EOF
  echo "✅ Configuration file created at $CONFIG_FILE"
else
  echo "📁 Existing configuration file found at $CONFIG_FILE"
fi