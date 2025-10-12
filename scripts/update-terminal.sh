#!/bin/bash
set -e

# ----------------------------------------
# Q.R.L.P ALL-IN: Full README Update Script
# ----------------------------------------

USERNAME=${USERNAME:-"𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ"}
GITHUB_USER=${GITHUB_USER:-"thugger069"}
CURRENT_TIME=$(date -u +"%Y-%m-%d %T")
DIST_DIR="dist"

mkdir -p "$DIST_DIR"

# ----------------------------------------
# 1️⃣ Generate Signature Header
# ----------------------------------------
echo "▶ Generating signature header..."
node scripts/generate-header.js

# ----------------------------------------
# 2️⃣ Generate Terminal SVG
# ----------------------------------------
echo "▶ Generating neon terminal..."
node scripts/generate-terminal-svg.js

# ----------------------------------------
# 3️⃣ Fetch & Render Typewriter Quote
# ----------------------------------------
echo "▶ Fetching random quote..."
node scripts/fetch-quote.js

# ----------------------------------------
# 4️⃣ Generate Terminal Text Content
# ----------------------------------------
echo "▶ Creating terminal output text..."
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

# ----------------------------------------
# 5️⃣ Generate README.md
# ----------------------------------------
echo "▶ Building README.md..."
cat > README.md <<EOF
<div align="center">
  <img src="${DIST_DIR}/header.svg" alt="Signature Header" width="100%" />
</div>

<div align="center">
  <img src="${DIST_DIR}/terminal.svg" alt="Terminal Output" width="100%" />
</div>

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
  <img alt="GitHub Contribution Snake Animation" src="${DIST_DIR}/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
</picture>
<!-- END SNAKE -->

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
</div>

<sub align="center">🧿 Updated daily by <code>update_readme.sh</code> • 🧬 Maintained by ${USERNAME}</sub>
<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=100&section=footer"/>
</div>
EOF

# ----------------------------------------
# 6️⃣ Cleanup
# ----------------------------------------
rm -f "$TERMINAL_OUTPUT"

# ----------------------------------------
# 7️⃣ Commit & Push Changes
# ----------------------------------------
echo "▶ Committing & pushing updates..."
git config --local user.name "${USERNAME}"
git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add -f dist/*.svg README.md
git commit -m "🧬 Q.R.L.P ALL-IN: Daily README Update (${CURRENT_TIME})" || echo "No changes to commit"
git push

echo "✅ README.md fully updated with Q.R.L.P ALL-IN enhancements."