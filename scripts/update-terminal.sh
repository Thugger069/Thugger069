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

# ╭───────────────────────────────────────╮
# │ STEP 2: Generate Animated Quote SVG   │
# ╰───────────────────────────────────────╯
echo "🪶 Generating Quantum Quote..."
cat > "$ASSETS_DIR/quote.svg" <<EOF
<svg width="600" height="80" xmlns="http://www.w3.org/2000/svg">
  <rect width="600" height="80" fill="transparent"/>
  <text x="50%" y="50%" fill="$COLOR1" font-size="20" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    “Walking the Path Where Bits & Dreams Intersect.”
  </text>
  <text x="50%" y="70%" fill="$COLOR2" font-size="14" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    — 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ
  </text>
</svg>
EOF

# ╭──────────────────────────────────────────────╮
# │ STEP 3: Generate Quantum Terminal Banner SVG │
# ╰──────────────────────────────────────────────╯
echo "🖥️  Generating Terminal Splash..."
cat > "$ASSETS_DIR/terminal.svg" <<EOF
<svg width="700" height="120" xmlns="http://www.w3.org/2000/svg">
  <rect width="700" height="120" rx="8" ry="8" fill="#0d0d0d" stroke="$COLOR2" stroke-width="1"/>
  <text x="50%" y="50%" fill="$COLOR1" font-size="22" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    > Initializing Quantum Matrix Shell...
  </text>
  <text x="50%" y="75%" fill="$COLOR2" font-size="16" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    ꚩꚶꛎꛘ𖢧ꚶ𖢑 𖦪𖤢ꛎꚳ𖢑 ⚡ ACTIVE
  </text>
</svg>
EOF

# ╭───────────────────────────────────────────────╮
# │ STEP 4: Generate Particle Field Background    │
# ╰───────────────────────────────────────────────╯
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
# │ STEP 5: Generate Snake Animation (snk)     │
# ╰────────────────────────────────────────────╯
echo "🐍 Generating Snake Animations..."
npx --yes snk@0.1.2 generate \
  --user "$GITHUB_ACTOR" \
  --output "$DIST_DIR/snake.svg" \
  --palette "$COLOR1,$COLOR2" \
  || echo "⚠️ Snake generation skipped (local run mode)."

# ╭────────────────────────────────────────────╮
# │ STEP 6: Commit + Push to Repo              │
# ╰────────────────────────────────────────────╯
echo "🌀 Committing changes..."
cd "$ROOT_DIR"
git config user.name "GitHub Action"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add assets/*.svg dist/*.svg README.md || true
git commit -m "🜂 Q.R.I.P Auto-Update: $(date -u)" || echo "No changes to commit"
git push origin main || echo "⚠️ Push skipped (local execution)"

# ╭────────────────────────────────────────────╮
# │ STEP 7: Log completion                     │
# ╰────────────────────────────────────────────╯
echo "✅ Regeneration complete at $(date -u)" | tee -a "$LOG_FILE"
echo "──────────────────────────────────────────────"
echo "Q.R.I.P ALL-IN sequence completed successfully ⚡"