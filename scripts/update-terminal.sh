#!/usr/bin/env bash
#
# ──────────────────────────────────────────────
# Q.R.I.P ALL-IN: Unified README & Terminal Updater
# Handles terminal content, snake animations, and README
# ──────────────────────────────────────────────

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_DIR="$ROOT_DIR/dist"
ASSETS_DIR="$ROOT_DIR/assets"
LOG_FILE="$ROOT_DIR/logs/update_terminal.log"

mkdir -p "$DIST_DIR" "$ASSETS_DIR" "$(dirname "$LOG_FILE")"

# Environment defaults
USERNAME="${USERNAME:-𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ}"
username="${username:-thugger069}"
CURRENT_TIME="${CURRENT_TIME:-$(date -u '+%Y-%m-%d %H:%M:%S')}"

# Generate random load average
generate_load_avg() {
  printf "%.2f %.2f %.2f" \
    "$(awk -v seed=$RANDOM 'BEGIN{srand(seed); print 0.1+rand()*0.9}')" \
    "$(awk -v seed=$RANDOM 'BEGIN{srand(seed); print 0.2+rand()*0.8}')" \
    "$(awk -v seed=$RANDOM 'BEGIN{srand(seed); print 0.1+rand()*0.9}')"
}

# Generate terminal content
generate_terminal_content() {
  local LOAD_AVG
  LOAD_AVG=$(generate_load_avg)
  
  cat > "$DIST_DIR/terminal_output.txt" <<EOF
Last login: ${CURRENT_TIME} on ttys000
${USERNAME}@github ~ % uptime
${CURRENT_TIME} up 02:51, 1 user, load average: ${LOAD_AVG}

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

${USERNAME}@github ~ %
EOF
}

# Generate snake animations for light & dark mode
generate_snake() {
  if ! command -v npx &>/dev/null; then
    echo "⚠️ npx not found, skipping snake generation."
    return
  fi

  echo "🐍 Generating snake animations..."
  npx --yes snk@0.1.2 generate \
    --user "$username" \
    --output "$DIST_DIR/github-snake.svg" \
    --palette "#39FF14,#FF00FF" || echo "⚠️ Light snake skipped."

  npx --yes snk@0.1.2 generate \
    --user "$username" \
    --output "$DIST_DIR/github-snake-dark.svg" \
    --palette "#00FFFF,#FF00FF" || echo "⚠️ Dark snake skipped."
}

# Generate README
generate_readme() {
  cat > "$ROOT_DIR/README.md" <<EOF
<div align="center">
  <h2>👨‍💻 $USERNAME</h2>

  [![Profile Views](https://komarev.com/ghpvc/?username=${username}&color=blueviolet&style=flat-square)](https://github.com/${username})

  <pre class="terminal">
$(cat "$DIST_DIR/terminal_output.txt")
  </pre>

  <!-- START SNAKE -->
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="dist/github-snake-dark.svg?ts=${CURRENT_TIME//:/%3A}" />
    <source media="(prefers-color-scheme: light)" srcset="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
    <img alt="Github Snake Animation" src="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  </picture>
  <!-- END SNAKE -->

  <div align="center">
    <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
  </div>
</div>
EOF
}

# Force git to track dist/ even if in .gitignore
track_dist() {
  git add -f "$DIST_DIR" || echo "⚠️ Failed to track dist directory"
}

# Main
main() {
  echo "🚀 Starting Q.R.I.P Terminal & README update..."
  generate_terminal_content
  generate_snake
  generate_readme
  track_dist
  echo "✅ Update complete at ${CURRENT_TIME}" | tee -a "$LOG_FILE"
}

main