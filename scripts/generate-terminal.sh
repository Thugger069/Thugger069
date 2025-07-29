#!/bin/bash

set -e

# Paths
OUTPUT_DIR="dist"
TERMINAL_SVG="$OUTPUT_DIR/terminal.svg"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Generate terminal splash content
TERMINAL_CONTENT=$(cat <<EOF
$(figlet -w 100 "𖢧ꛅꛘꚳ Terminal")
User: thugger069
Host: quantum-hub
OS: GitHub Linux • Bash
Time: $(date)
Uptime: $(uptime -p)
Status: 🔥 Rebuilding the matrix...

$(fortune | cowsay | lolcat)
EOF
)

# Save terminal content to temporary file
TEMP_FILE=$(mktemp)
echo "$TERMINAL_CONTENT" > "$TEMP_FILE"

# Wrap the content in SVG
cat <<EOF > "$TERMINAL_SVG"
<svg viewBox="0 0 900 480" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
  <style>
    text {
      font-family: 'Fira Code', monospace;
      font-size: 14px;
      white-space: pre;
      fill: #00ff99;
    }
    @media (prefers-color-scheme: dark) {
      text { fill: #00ffcc; }
    }
  </style>
  <rect width="100%" height="100%" fill="#0d0d0d"/>
  <text x="20" y="40">
$(cat "$TEMP_FILE" | sed 's/&/&amp;/g; s/</\&lt;/g; s/>/\&gt;/g' | sed 's/^/    /')
  </text>
</svg>
EOF

# Cleanup
rm "$TEMP_FILE"

echo "✅ Terminal SVG generated at $TERMINAL_SVG"