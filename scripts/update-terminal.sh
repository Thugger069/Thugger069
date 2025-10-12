#!/usr/bin/env bash
#
# ╔════════════════════════════════════════════════════════════════╗
# ║   Q.R.I.P ALL-IN: Quantum README Auto-Regenerator ⚡            ║
# ║   Thugger069 / 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ                                  ║
# ║   Animated terminal splash, neon gradients, snake, particles    ║
# ╚════════════════════════════════════════════════════════════════╝
#
set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$ROOT_DIR/assets"
DIST_DIR="$ROOT_DIR/dist"
LOG_FILE="$ROOT_DIR/logs/readme_update.log"

mkdir -p "$ASSETS_DIR" "$DIST_DIR" "$(dirname "$LOG_FILE")"

# -------------------------------
# STEP 1: Random Neon Palette
# -------------------------------
PALETTES=(
  "#39FF14,#00FFF0"   # green → cyan
  "#FF00FF,#FFDD00"   # magenta → yellow
  "#00FFFF,#FF00FF"   # cyan → magenta
  "#FF4D00,#39FF14"   # orange → green
)
IDX=$(( RANDOM % ${#PALETTES[@]} ))
PALETTE="${PALETTES[$IDX]}"
COLOR1=$(echo "$PALETTE" | cut -d',' -f1)
COLOR2=$(echo "$PALETTE" | cut -d',' -f2)
echo "🎨 Selected neon palette: $COLOR1 → $COLOR2"

# -------------------------------
# STEP 2: Generate Signature Header
# -------------------------------
echo "🖋️ Generating Signature Header..."
cat > "$ASSETS_DIR/header.svg" <<EOF
<svg width="700" height="140" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="grad" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="$COLOR1">
        <animate attributeName="stop-color" values="$COLOR1;$COLOR2;$COLOR1" dur="6s" repeatCount="indefinite"/>
      </stop>
      <stop offset="100%" stop-color="$COLOR2">
        <animate attributeName="stop-color" values="$COLOR2;$COLOR1;$COLOR2" dur="6s" repeatCount="indefinite"/>
      </stop>
    </linearGradient>
  </defs>
  <rect width="700" height="140" fill="#0d0d0d" rx="8" ry="8"/>
  <text x="50%" y="35%" fill="url(#grad)" font-size="22" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ
  </text>
  <text x="50%" y="60%" fill="url(#grad)" font-size="16" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    • Walking The Path Where Bits & Dreams Intersect ®
  </text>
  <text x="50%" y="85%" fill="url(#grad)" font-size="14" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    卞廾凵呂呂ヨ尺.と己し. 魔大帝
  </text>
</svg>
EOF

# -------------------------------
# STEP 3: Generate Animated Terminal
# -------------------------------
echo "🖥️ Generating Terminal SVG..."
TERMINAL_TEXT="> Initializing Quantum Matrix Shell..."
TERMINAL_STATUS="ꚩꚶꛎꛘ𖢧ꚶ𖢑 𖦪𖤢ꛎꚳ𖢑 ⚡ ACTIVE"

cat > "$ASSETS_DIR/terminal.svg" <<EOF
<svg width="700" height="120" xmlns="http://www.w3.org/2000/svg">
  <rect width="700" height="120" rx="8" ry="8" fill="#0d0d0d" stroke="$COLOR2" stroke-width="1"/>
  <text x="50%" y="45%" fill="$COLOR1" font-size="20" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    <tspan>
      <animate attributeName="opacity" values="0;1" dur="1.2s" repeatCount="indefinite" begin="0s"/>
      $TERMINAL_TEXT
    </tspan>
  </text>
  <text x="50%" y="75%" fill="$COLOR2" font-size="16" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    $TERMINAL_STATUS
  </text>
</svg>
EOF

# -------------------------------
# STEP 4: Generate Quote SVG
# -------------------------------
echo "🪶 Generating Quote SVG..."
cat > "$ASSETS_DIR/quote.svg" <<EOF
<svg width="600" height="80" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="quoteGrad" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="$COLOR1">
        <animate attributeName="stop-color" values="$COLOR1;$COLOR2;$COLOR1" dur="5s" repeatCount="indefinite"/>
      </stop>
      <stop offset="100%" stop-color="$COLOR2">
        <animate attributeName="stop-color" values="$COLOR2;$COLOR1;$COLOR2" dur="5s" repeatCount="indefinite"/>
      </stop>
    </linearGradient>
  </defs>
  <text x="50%" y="50%" fill="url(#quoteGrad)" font-size="20" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    “Walking the Path Where Bits & Dreams Intersect.”
  </text>
  <text x="50%" y="70%" fill="url(#quoteGrad)" font-size="14" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    — 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ
  </text>
</svg>
EOF

# -------------------------------
# STEP 5: Generate Particle Field
# -------------------------------
echo "🌌 Generating Particle Field..."
cat > "$ASSETS_DIR/particles.svg" <<EOF
<svg width="800" height="160" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="160" fill="#000000"/>
  <g fill="$COLOR1">
    $(for i in $(seq 1 60); do
      X=$(( RANDOM % 800 ))
      Y=$(( RANDOM % 160 ))
      echo "<circle cx='$X' cy='$Y' r='1.5' opacity='0.$((RANDOM % 8 + 2))'>
        <animateTransform attributeName='transform' type='translate' values='0 0; 2 0; -2 0; 0 0' dur='3s' repeatCount='indefinite'/>
      </circle>"
    done)
  </g>
</svg>
EOF

# -------------------------------
# STEP 6: Generate Snake Animation
# -------------------------------
echo "🐍 Generating Snake SVG..."
npx --yes snk@0.1.2 generate \
  --user "$GITHUB_ACTOR" \
  --output "$DIST_DIR/snake.svg" \
  --palette "$COLOR1,$COLOR2" \
  || echo "⚠️ Snake generation skipped (local run)"

# -------------------------------
# STEP 7: Build README.md
# -------------------------------
echo "📄 Generating README.md..."
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S")
cat > README.md <<EOF
<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="${ASSETS_DIR}/header.svg"/>
    <source media="(prefers-color-scheme: light)" srcset="${ASSETS_DIR}/header.svg"/>
    <img alt="Quantum Header" src="${ASSETS_DIR}/header.svg"/>
  </picture>
</div>

<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="${ASSETS_DIR}/terminal.svg"/>
    <source media="(prefers-color-scheme: light)" srcset="${ASSETS_DIR}/terminal.svg"/>
    <img alt="Terminal Output" src="${ASSETS_DIR}/terminal.svg"/>
  </picture>
</div>

<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="${ASSETS_DIR}/quote.svg"/>
    <source media="(prefers-color-scheme: light)" srcset="${ASSETS_DIR}/quote.svg"/>
    <img alt="Quote" src="${ASSETS_DIR}/quote.svg"/>
  </picture>
</div>

<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="${ASSETS_DIR}/particles.svg"/>
    <source media="(prefers-color-scheme: light)" srcset="${ASSETS_DIR}/particles.svg"/>
    <img alt="Particles" src="${ASSETS_DIR}/particles.svg"/>
  </picture>
</div>

<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="${DIST_DIR}/snake.svg"/>
    <source media="(prefers-color-scheme: light)" srcset="${DIST_DIR}/snake.svg"/>
    <img alt="GitHub Snake Animation" src="${DIST_DIR}/snake.svg?ts=${TIMESTAMP//:/%3A}"/>
  </picture>
</div>

<div align="center">
  <sub>Last Updated: $TIMESTAMP UTC • 🧬 Maintained by 𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ</sub>
</div>
EOF

# -------------------------------
# STEP 8: Commit & Push
# -------------------------------
echo "🌀 Committing changes..."
git config user.name "GitHub Action"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add assets/*.svg dist/*.svg README.md || true
git commit -m "🜂 Q.R.I.P Auto-Update: $TIMESTAMP" || echo "No changes to commit"
git push origin main || echo "⚠️ Push skipped (local run)"

echo "✅ README regeneration complete at $TIMESTAMP"
echo "──────────────────────────────────────────────"