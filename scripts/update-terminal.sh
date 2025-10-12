#!/bin/bash
set -e

# -------------------------------
# Q.R.I.P ALL-IN: README Update
# -------------------------------

# Environment variables
USERNAME=${USERNAME:-"𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ"}
GITHUB_USER=${GITHUB_USER:-"thugger069"}
CURRENT_TIME=$(date -u +"%Y-%m-%d %T")
DIST_DIR="dist"

# Ensure dist directory exists
mkdir -p "$DIST_DIR"

# -------------------------------
# 1️⃣ Generate Header SVG (Signature Block)
# -------------------------------
echo "▶ Generating signature header..."
node scripts/generate-header.js

# -------------------------------
# 2️⃣ Generate Terminal SVG with Typewriter Effect
# -------------------------------
echo "▶ Generating animated terminal SVG..."
node scripts/generate-terminal-svg.js

# -------------------------------
# 3️⃣ Fetch & Generate Quote SVG
# -------------------------------
echo "▶ Fetching random quote..."
node scripts/fetch-quote.js

# -------------------------------
# 4️⃣ Generate GitHub Snake Animation
# -------------------------------
echo "▶ Generating GitHub snake animation..."
mkdir -p "$DIST_DIR"
snk_output_dark="$DIST_DIR/github-snake-dark.svg"
snk_output_light="$DIST_DIR/github-snake.svg"
npx snk --user="$GITHUB_USER" --output="$snk_output_light" --output-dark="$snk_output_dark" --color-snake="#ff0000" --color-dots="#00ff00"

# -------------------------------
# 5️⃣ Generate Terminal Output (Text)
# -------------------------------
echo "▶ Generating terminal output text..."
TERMINAL_OUTPUT="$DIST_DIR/terminal_output.txt"

cat > "$TERMINAL_OUTPUT" <<EOF
Last login: ${CURRENT_TIME} on ttys000
${USERNAME}@github ~ % uptime
${CURRENT_TIME} up 02:51, 1 user, load average: 0.56 0.62 0.48

${USERNAME}@github ~ % ls -la Projects/
total 40
drwxr-xr-x  8 ${USERNAME}  staff  256 May 07 02:51 .
drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 02:51 ..
drwxr-xr-x  7 ${USERNAME}  staff  224 May 07 02:51 DevOps
drwxr-xr-x  6 ${USERNAME}  staff  192 May 07 02:51 OpenSource
drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 02:51 Scripts
-rw-r--r--  1 ${USERNAME}  staff  925 May 07 02:51 TODO.md

${USERNAME}@github ~ % cat Projects/TODO.md
# ℭ𝔲𝔯𝔯𝔢𝔫𝔱 𝔓𝔯𝔬𝔧𝔢𝔠𝔱𝔰 📋

→ Automating deployment workflows
→ Contributing to open source
→ Learning Kubernetes
→ Building shell script utilities
EOF

# -------------------------------
# 6️⃣ Generate README.md
# -------------------------------
echo "▶ Generating README.md..."
cat > README.md <<EOF
<div align="center">
  <img src="${DIST_DIR}/header.svg" alt="Signature Header" width="100%" />
</div>

<div align="center">
  <img src="${DIST_DIR}/quote.svg" alt="Typewriter Quote" width="80%" />
</div>

<div align="center">
  <img src="${DIST_DIR}/terminal.svg" alt="Terminal Output" width="90%" />
</div>

<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="${DIST_DIR}/github-snake-dark.svg?ts=${CURRENT_TIME//:/%3A}" />
    <source media="(prefers-color-scheme: light)" srcset="${DIST_DIR}/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
    <img alt="Github Contribution Snake" src="${DIST_DIR}/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  </picture>
</div>

<div align="center">
  [![Profile Views](https://komarev.com/ghpvc/?username=${GITHUB_USER}&color=blueviolet&style=flat-square)](https://github.com/${GITHUB_USER})
</div>

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
</div>

<div align="center">
  <sub>🧿 Updated daily by <code>update_readme.sh</code> • 🧬 Maintained by ${USERNAME}</sub>
</div>

<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=100&section=footer"/>
</div>
EOF

# -------------------------------
# 7️⃣ Cleanup
# -------------------------------
rm -f "$TERMINAL_OUTPUT"
