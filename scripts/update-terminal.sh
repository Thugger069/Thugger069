#!/usr/bin/env bash
set -e

# ────────────────────────────────
# Q.R.I.P ALL-IN: Dynamic README Generator
# Maintainer: 𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ / Thugger069
# ────────────────────────────────

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$ROOT_DIR/assets"
DIST_DIR="$ROOT_DIR/dist"
LOG_FILE="$ROOT_DIR/logs/readme_update.log"

mkdir -p "$ASSETS_DIR" "$DIST_DIR" "$(dirname "$LOG_FILE")"

CURRENT_TIME=$(date -u +"%Y-%m-%d %T")

# -------------------------------
# Neon Gradient Palette
# -------------------------------
PALETTES=(
  "#39FF14,#00FFF0"
  "#FF00FF,#FFDD00"
  "#00FFFF,#FF00FF"
  "#FF4D00,#39FF14"
)
RANDOM_INDEX=$(( RANDOM % ${#PALETTES[@]} ))
PALETTE="${PALETTES[$RANDOM_INDEX]}"
COLOR1=$(echo "$PALETTE" | cut -d',' -f1)
COLOR2=$(echo "$PALETTE" | cut -d',' -f2)
echo "🎨 Selected neon palette: $COLOR1 → $COLOR2"

# -------------------------------
# Generate Signature Header SVG
# -------------------------------
echo "▶ Generating signature header..."
cat > "$ASSETS_DIR/header.svg" <<EOF
<svg width="700" height="120" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="grad" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="$COLOR1"/>
      <stop offset="100%" stop-color="$COLOR2"/>
    </linearGradient>
  </defs>
  <rect width="700" height="120" fill="#0d0d0d" rx="10" ry="10"/>
  <text x="50%" y="40%" text-anchor="middle" fill="url(#grad)" font-size="22" font-family="monospace">
    𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ
  </text>
  <text x="50%" y="70%" text-anchor="middle" fill="$COLOR2" font-size="16" font-family="monospace">
    Walking The Path Where Bits & Dreams Intersect ®
  </text>
</svg>
EOF

# -------------------------------
# Generate Terminal SVG (Typewriter effect)
# -------------------------------
echo "▶ Generating terminal SVG..."
cat > "$ASSETS_DIR/terminal.svg" <<EOF
<svg width="700" height="140" xmlns="http://www.w3.org/2000/svg">
  <rect width="700" height="140" rx="10" ry="10" fill="#0d0d0d" stroke="$COLOR2" stroke-width="1"/>
  <text x="50%" y="35%" fill="$COLOR1" font-size="18" text-anchor="middle" font-family="monospace">
    > Initializing Quantum Matrix Shell...
  </text>
  <text x="50%" y="65%" fill="$COLOR2" font-size="16" text-anchor="middle" font-family="monospace">
    ꚩꚶꛎꛘ𖢧ꚶ𖢑 𖦪𖤢ꛎꚳ𖢑 ⚡ ACTIVE
  </text>
  <animate attributeName="opacity" from="0" to="1" dur="2s" fill="freeze"/>
</svg>
EOF

# -------------------------------
# Generate Quote SVG
# -------------------------------
echo "▶ Generating quote..."
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

# -------------------------------
# Generate Particle Background SVG
# -------------------------------
echo "▶ Generating particle field..."
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

# -------------------------------
# Generate Snake Animation (snk)
# -------------------------------
echo "▶ Generating snake animation..."
npx --yes snk@0.1.2 generate \
  --user "$GITHUB_ACTOR" \
  --output "$DIST_DIR/github-snake.svg" \
  --palette "$COLOR1,$COLOR2" \
  || echo "⚠️ Snake generation skipped (local execution)."

# -------------------------------
# Generate Badges (if script exists)
# -------------------------------
if [ -f "$SCRIPTS_DIR/generate-badges.js" ]; then
  echo "▶ Generating badges..."
  node "$SCRIPTS_DIR/generate-badges.js"
fi

# -------------------------------
# Generate README.md
# -------------------------------
echo "▶ Generating README.md..."
cat > README.md <<EOF
<div align="center">
  <img src="assets/header.svg" alt="Signature Header" width="100%" />
</div>

<div align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Space+Mono&weight=600&size=26&duration=4000&pause=1000&color=39FF14&center=true&vCenter=true&width=460&lines=%E2%97%9F%EF%B8%8F+ƜЄԼƇƠMЄ;𖦪𖤢ꛎꚳꛈ𖢧ꚲ_%ꕫꛌꔪꛣ𖤀ꛌꘘꕫ" />
</div>

<div align="center">
  <img src="assets/terminal.svg" alt="Terminal Output" />
</div>

<div align="center">
  <img src="assets/quote.svg" alt="Quote" />
</div>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  <source media="(prefers-color-scheme: light)" srcset="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  <img alt="Github Contribution Snake" src="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
</picture>

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
</div>
EOF

echo "✅ README assets generated locally successfully at $CURRENT_TIME"