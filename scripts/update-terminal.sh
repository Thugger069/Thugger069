#!/bin/bash
set -e

# -------------------------------
# Q.R.L.P ALL-IN: README Update
# -------------------------------

# Environment variables
USERNAME=${USERNAME:-"𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ"}
GITHUB_USER=${GITHUB_USER:-"thugger069"}
CURRENT_TIME=$(date -u +"%Y-%m-%d %T UTC")
DIST_DIR="dist"

# Ensure dist directory exists
mkdir -p "$DIST_DIR"

# -------------------------------
# Generate Header SVG
# -------------------------------
echo "▶ Generating quantum header..."
node scripts/generate-header.js

# -------------------------------
# Generate Terminal SVG
# -------------------------------
echo "▶ Generating terminal interface..."
node scripts/generate-terminal-svg.js

# -------------------------------
# Fetch & Generate Quote SVG
# -------------------------------
echo "▶ Fetching and rendering random quote..."
node scripts/fetch-quote.js

# -------------------------------
# Generate Terminal Output (Text)
# -------------------------------
echo "▶ Generating terminal text output..."
TERMINAL_OUTPUT="$DIST_DIR/terminal_output.txt"
cat > "$TERMINAL_OUTPUT" <<EOF
Last login: ${CURRENT_TIME} on ttys000
${USERNAME}@github ~ % uptime
  $(date +"%H:%M") up 2:51, 1 user, load averages: 0.56 0.62 0.48

${USERNAME}@github ~ % ls -la Projects/
total 40
drwxr-xr-x  8 ${USERNAME}  staff  256 May 07 02:51 .
drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 02:51 ..
drwxr-xr-x  7 ${USERNAME}  staff  224 DevOps
drwxr-xr-x  6 ${USERNAME}  staff  192 OpenSource
drwxr-xr-x  5 ${USERNAME}  staff  160 Scripts
-rw-r--r--  1 ${USERNAME}  staff  925 TODO.md

${USERNAME}@github ~ % cat Projects/TODO.md
# ℭ𝔲𝔯𝔯𝔢𝔫𝔱 𝔓𝔯𝔬𝔧𝔢𝔠𝔱𝔰 📋

→ Automating deployment workflows
→ Contributing to open source
→ Learning Kubernetes
→ Building shell script utilities
EOF

# -------------------------------
# Generate README.md
# -------------------------------
echo "▶ Generating README.md..."
cat > README.md <<EOF
<div align="center">
  <img src="${DIST_DIR}/header.svg" alt="Quantum Header" width="100%" />
</div>

<div align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Space+Mono&weight=600&size=26&duration=4000&pause=1000&color=39FF14&center=true&vCenter=true&width=460&lines=%E2%97%9F+ƜЄԼƇƠMЄ;𖦪𖤢ꛎꚳꛈ𖢧ꚲ_%ꕫꛌꔪꛣ𖤀ꛌꘘꕫ" />
</div>

[![Profile Views](https://komarev.com/ghpvc/?username=${GITHUB_USER}&color=blueviolet&style=flat-square)](https://github.com/${GITHUB_USER})

<pre class="terminal">
$(cat "$TERMINAL_OUTPUT")
</pre>

<div align="center">
  <img src="${DIST_DIR}/quote.svg" alt="Typewriter Quote" />
</div>

<!-- START SNAKE -->
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="${DIST_DIR}/github-snake-dark.svg?ts=${CURRENT_TIME//:/%3A}" />
  <source media="(prefers-color-scheme: light)" srcset="${DIST_DIR}/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  <img alt="Github Contribution Snake Animation" src="${DIST_DIR}/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
</picture>
<!-- END SNAKE -->

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME}</sub>
</div>

<sub align="center">🧿 Automated daily update via <code>update_readme.sh</code> • 🧬 Maintained by ${USERNAME}</sub>
<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=100&section=footer"/>
</div>
EOF

# -------------------------------
# Cleanup
# -------------------------------
rm -f "$TERMINAL_OUTPUT"

echo "✅ README.md updated successfully with Q.R.L.P ALL-IN enhancements."