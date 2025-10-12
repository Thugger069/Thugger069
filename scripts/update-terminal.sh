#!/usr/bin/env bash
#
# ╔════════════════════════════════════════════════════════════════╗
# ║   Q.R.I.P ALL-IN: Quantum README Auto-Regenerator ⚡            ║
# ║   Thugger069 / 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ                                  ║
# ║   Dynamic header, terminal, quote, snake, particle assets       ║
# ╚════════════════════════════════════════════════════════════════╝
#
set -e

echo ""
echo "🜂 Initializing Q.R.I.P README Regeneration..."
echo "──────────────────────────────────────────────"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_DIR="$ROOT_DIR/dist"
SCRIPTS_DIR="$ROOT_DIR/scripts"
LOG_FILE="$ROOT_DIR/logs/readme_update.log"

mkdir -p "$DIST_DIR" "$SCRIPTS_DIR" "$(dirname "$LOG_FILE")"

# ╭───────────────────────────────╮
# │ STEP 1: Neon Palette Selection │
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
# │ STEP 2: Generate Header, Terminal, Particles │
# ╰──────────────────────────────────────────────╯
echo "🖌️ Generating Header SVG..."
node "$SCRIPTS_DIR/generate-header.js" || echo "⚠️ Header generation skipped."

echo "🖥️ Generating Terminal SVG..."
node "$SCRIPTS_DIR/generate-terminal-svg.js" || echo "⚠️ Terminal generation skipped."

echo "🌌 Generating Particle Field..."
node "$SCRIPTS_DIR/generate-particles.js" || echo "⚠️ Particle generation skipped."

echo "📝 Generating Quote Banner..."
node "$SCRIPTS_DIR/fetch-quote.js" || echo "⚠️ Quote generation skipped."

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
# │ STEP 4: Generate Badges                     │
# ╰────────────────────────────────────────────╯
echo "🏷️ Generating Badges..."
node "$SCRIPTS_DIR/generate-badges.js" || echo "⚠️ Badge generation skipped."

# ╭────────────────────────────────────────────╮
# │ STEP 5: Merge assets into README.md        │
# ╰────────────────────────────────────────────╯
echo "📄 Merging generated assets into README.md..."
node "$SCRIPTS_DIR/merge-readme.js" || echo "⚠️ README merge skipped."

# ╭────────────────────────────────────────────╮
# │ STEP 6: Log completion                     │
# ╰────────────────────────────────────────────╯
echo "✅ README regeneration complete at $(date -u)" | tee -a "$LOG_FILE"
echo "──────────────────────────────────────────────"
echo "Q.R.I.P ALL-IN sequence completed successfully ⚡"