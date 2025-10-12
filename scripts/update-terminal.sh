#!/usr/bin/env bash
#
# ╔════════════════════════════════════════════════════════════════╗
# ║   Q.R.I.P ALL-IN: Quantum README Auto-Regenerator ⚡            ║
# ║   Thugger069 / 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ                                  ║
# ║   Dynamic terminal splash, quote, snake, particles, sync       ║
# ╚════════════════════════════════════════════════════════════════╝
#
set -e

echo ""
echo "🜂 Initializing Q.R.I.P Regeneration Sequence..."
echo "──────────────────────────────────────────────"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$ROOT_DIR/assets"
DIST_DIR="$ROOT_DIR/dist"
SCRIPTS_DIR="$ROOT_DIR/scripts"
LOG_FILE="$ROOT_DIR/logs/readme_update.log"

mkdir -p "$ASSETS_DIR" "$DIST_DIR" "$SCRIPTS_DIR" "$(dirname "$LOG_FILE")"

# ╭───────────────────────────────╮
# │ STEP 1: Generate Neon Palette │
# ╰───────────────────────────────╯
COLORS=(
  "#39FF14,#00FFF0"   # green → cyan
  "#FF00FF,#FFDD00"   # magenta → yellow
  "#00FFFF,#FF00FF"   # cyan → magenta
  "#FF4D00,#39FF14"   # orange → green
)
RANDOM_INDEX=$(( RANDOM % ${#COLORS[@]} ))
PALETTE="${COLORS[$RANDOM_INDEX]}"
COLOR1=$(echo "$PALETTE" | cut -d',' -f1)
COLOR2=$(echo "$PALETTE" | cut -d',' -f2)
echo "🎨 Selected neon palette → $COLOR1 → $COLOR2"

# ╭──────────────────────────────────────────────╮
# │ STEP 2: Generate SVG Components              │
# ╰──────────────────────────────────────────────╯

echo "🖌️  Generating Header SVG..."
node "$SCRIPTS_DIR/generate-header.js" || echo "⚠️ Header generation skipped."

echo "🖥️  Generating Terminal SVG..."
node "$SCRIPTS_DIR/generate-terminal-svg.js" || echo "⚠️ Terminal generation skipped."

echo "🌌 Generating Particle Field..."
node "$SCRIPTS_DIR/generate-particles.js" || echo "⚠️ Particle field generation skipped."

# ╭────────────────────────────────────────────╮
# │ STEP 3: Generate Snake Animation (snk)     │
# ╰────────────────────────────────────────────╯
echo "🐍 Generating Snake Animations..."
npx --yes snk@0.1.2 generate \
  --user "$GITHUB_ACTOR" \
  --output "$DIST_DIR/snake.svg" \
  --palette "$COLOR1,$COLOR2" \
  || echo "⚠️ Snake generation skipped (local run mode)."

# ╭────────────────────────────────────────────╮
# │ STEP 4: Log completion                     │
# ╰────────────────────────────────────────────╯
echo "✅ Regeneration complete at $(date -u)" | tee -a "$LOG_FILE"
echo "──────────────────────────────────────────────"
echo "Q.R.I.P ALL-IN sequence completed successfully ⚡"