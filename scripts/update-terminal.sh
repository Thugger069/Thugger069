#!/usr/bin/env bash
#
# ╔══════════════════════════════════════════════════════════════════════╗
# ║   Q.R.I.P ALL-IN: Quantum README Auto-Regenerator ⚡ (Enhanced v2.0)  ║
# ║   Author: 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ                                        ║
# ║   Modules: header ▪ terminal ▪ particles ▪ quote ▪ snake ▪ merge     ║
# ╚══════════════════════════════════════════════════════════════════════╝
#
set -e

echo ""
echo "🜂 Initializing Q.R.I.P Regeneration Sequence..."
echo "───────────────────────────────────────────────────────────────"

# ╭───────────────────────────────╮
# │ Environment + Directories     │
# ╰───────────────────────────────╯
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
SCRIPTS_DIR="$ROOT_DIR/scripts"
DIST_DIR="$ROOT_DIR/dist"
LOG_DIR="$ROOT_DIR/logs"
LOG_FILE="$LOG_DIR/readme_update.log"

mkdir -p "$DIST_DIR" "$LOG_DIR"

# ╭───────────────────────────────╮
# │ STEP 1: Select Neon Palette   │
# ╰───────────────────────────────╯
COLORS=(
  "#39FF14,#00FFF0"   # green → cyan
  "#FF00FF,#FFDD00"   # magenta → yellow
  "#00FFFF,#FF00FF"   # cyan → magenta
  "#FF4D00,#39FF14"   # orange → green
)
RANDOM_INDEX=$(( RANDOM % ${#COLORS[@]} ))
PALETTE="${COLORS[$RANDOM_INDEX]}"
export COLOR1="$(echo "$PALETTE" | cut -d',' -f1)"
export COLOR2="$(echo "$PALETTE" | cut -d',' -f2)"

echo "🎨 Selected Neon Palette → $COLOR1 → $COLOR2"
echo ""

# ╭───────────────────────────────╮
# │ STEP 2: Generate SVG Assets   │
# ╰───────────────────────────────╯
run_node() {
  local script="$1"
  if [ -f "$SCRIPTS_DIR/$script" ]; then
    echo "⚙️  Running $script ..."
    node "$SCRIPTS_DIR/$script" || echo "⚠️  $script failed gracefully."
  else
    echo "❌ Missing $SCRIPTS_DIR/$script"
  fi
}

run_node "generate-header.js"
run_node "generate-terminal-svg.js"
run_node "generate-particles.js"
run_node "fetch-quote.js"

# ╭───────────────────────────────╮
# │ STEP 3: Snake Contribution    │
# ╰───────────────────────────────╯
if command -v npx &>/dev/null; then
  echo "🐍 Generating contribution snake ..."
  npx --yes snk@0.1.2 generate \
    --user "${GITHUB_ACTOR:-Thugger069}" \
    --output "$DIST_DIR/snake.svg" \
    --palette "$COLOR1,$COLOR2" \
    || echo "⚠️  Snake generation skipped (local/offline mode)."
else
  echo "⚠️  npx not found – skipping snake generation."
fi

# ╭───────────────────────────────╮
# │ STEP 4: Merge README Template │
# ╰───────────────────────────────╯
run_node "merge-readme.js"

# ╭───────────────────────────────╮
# │ STEP 5: Commit (if in CI)     │
# ╰───────────────────────────────╯
if [ -n "$GITHUB_ACTIONS" ]; then
  echo "🌀 Auto-committing regenerated README..."
  git config user.name "Q.R.I.P Bot"
  git config user.email "actions@github.com"
  git add README.md dist/
  git commit -m "🔁 Q.R.I.P ALL-IN README regeneration [$(date -u)]" || true
  git push
fi

# ╭───────────────────────────────╮
# │ STEP 6: Logging & Summary     │
# ╰───────────────────────────────╯
echo "✅ Regeneration completed at $(date -u)" | tee -a "$LOG_FILE"
echo "───────────────────────────────────────────────────────────────"
echo "Q.R.I.P ALL-IN sequence finalized successfully ⚡"
echo ""