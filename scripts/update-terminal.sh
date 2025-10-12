#!/usr/bin/env bash
#
# ╔════════════════════════════════════════════════════════════════╗
# ║   Q.R.I.P ALL-IN: Quantum README Auto-Regenerator ⚡            ║
# ║   Thugger069 / 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ                                  ║
# ║   Dynamic terminal splash, quote, snake, particles             ║
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

mkdir -p "$ASSETS_DIR" "$DIST_DIR"

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

# ╭───────────────────────────────────────╮
# │ STEP 2: Generate Header SVG           │
# ╰───────────────────────────────────────╯
echo "🖌️  Generating Header SVG..."
node "$SCRIPTS_DIR/generate-header.js"

# ╭───────────────────────────────────────╮
# │ STEP 3: Generate Terminal SVG          │
# ╰───────────────────────────────────────╯
echo "▶ Generating terminal SVG with typewriter animation..."
node "$SCRIPTS_DIR/generate-terminal-svg.js"

# ╭───────────────────────────────────────╮
# │ STEP 4: Generate Quote SVG             │
# ╰───────────────────────────────────────╯
echo "🪶 Generating Quantum Quote..."
node "$SCRIPTS_DIR/fetch-quote.js"

# ╭────────────────────────────────────────────╮
# │ STEP 5: Generate Particle Background SVG │
# ╰────────────────────────────────────────────╯
echo "🌌 Generating Particle Field..."
cat > "$ASSETS_DIR/particles.svg" <<EOF
<svg width="800" height="160" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="160" fill="#000000"/>
  <g fill="$COLOR1">
    $(for i in $(seq 1 60); do
      X=$(( RANDOM % 800 ))
      Y=$(( RANDOM % 160 ))
      echo "<circle cx='$X' cy='$Y' r='1.5' opacity='0.$((RANDOM % 8 + 2))'/>"
    done)
  </g>
</svg>
EOF

# ╭────────────────────────────────────────────╮
# │ STEP 6: Generate GitHub Snake Animation    │
# ╰────────────────────────────────────────────╯
echo "🐍 Generating Snake Animation..."
npx --yes snk@0.1.2 generate \
  --user "$GITHUB_ACTOR" \
  --output "$DIST_DIR/github-snake.svg" \
  --palette "$COLOR1,$COLOR2" \
  || echo "⚠️ Snake generation skipped (local run mode)."

npx --yes snk@0.1.2 generate \
  --user "$GITHUB_ACTOR" \
  --output "$DIST_DIR/github-snake-dark.svg?palette=github-dark" \
  --palette "$COLOR1,$COLOR2" \
  || echo "⚠️ Dark snake generation skipped."

echo "✅ README assets generated successfully."