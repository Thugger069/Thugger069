#!/bin/bash
set -e

# -------------------------------
# Q.R.L.P ALL-IN: README Update
# -------------------------------

USERNAME=${USERNAME:-"𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ"}
GITHUB_USER=${GITHUB_USER:-"thugger069"}
CURRENT_TIME=$(date -u +"%Y-%m-%d %T")
DIST_DIR="dist"

mkdir -p "$DIST_DIR"

# -------------------------------
# Generate Assets
# -------------------------------
echo "▶ Generating header, terminal, quote, badges..."
node scripts/generate-header.js
node scripts/generate-terminal-svg.js
node scripts/fetch-quote.js
node scripts/generate-badges.js

# -------------------------------
# Generate Terminal Text Output
# -------------------------------
TERMINAL_OUTPUT="$DIST_DIR/terminal_output.txt"
cat > "$TERMINAL_OUTPUT" <<EOF
Last login: ${CURRENT_TIME} on ttys000
${USERNAME}@github ~ % uptime
${CURRENT_TIME} up 02:51, 1 user, load average: 0.56 0.62 0.48
EOF

# -------------------------------
# Update README.md
# -------------------------------
cat > README.md <<EOF
<div align="center">
  <img src="${DIST_DIR}/header.svg" alt="Signature Header" width="100%" />
</div>

<div align="center">
  <pre class="terminal">
$(cat "$TERMINAL_OUTPUT")
  </pre>
</div>

<div align="center">
  <img src="${DIST_DIR}/quote.svg" alt="Random Quote" />
</div>

<div align="center">
  <img src="${DIST_DIR}/badges.svg" alt="Dynamic Neon Badges" width="600" />
</div>

<!-- START SNAKE -->
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="${DIST_DIR}/github-snake-dark.svg?ts=${CURRENT_TIME//:/%3A}" />
  <source media="(prefers-color-scheme: light)" srcset="${DIST_DIR}/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  <img alt="Github Contribution Snake Animation" src="${DIST_DIR}/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
</picture>
<!-- END SNAKE -->

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME} UTC • Maintained by ${USERNAME}</sub>
</div>
EOF

rm -f "$TERMINAL_OUTPUT"
echo "✅ README.md updated successfully with Q.R.L.P ALL-IN enhancements."