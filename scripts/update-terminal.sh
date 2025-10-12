#!/usr/bin/env bash
set -e

echo "🜂 Q.R.I.P Full Dynamic README Regeneration Started..."

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$ROOT_DIR/assets"
DIST_DIR="$ROOT_DIR/dist"
mkdir -p "$ASSETS_DIR" "$DIST_DIR"

# -------------------------------
# Generate Neon Palette
# -------------------------------
COLORS=(
  "#39FF14,#00FFF0"
  "#FF00FF,#FFDD00"
  "#00FFFF,#FF00FF"
  "#FF4D00,#39FF14"
)
RANDOM_INDEX=$(( RANDOM % ${#COLORS[@]} ))
PALETTE="${COLORS[$RANDOM_INDEX]}"
COLOR1=$(echo "$PALETTE" | cut -d',' -f1)
COLOR2=$(echo "$PALETTE" | cut -d',' -f2)
echo "🎨 Selected Neon Palette: $COLOR1 → $COLOR2"

# -------------------------------
# Generate Signature Header SVG
# -------------------------------
cat > "$ASSETS_DIR/header.svg" <<EOF
<svg width="700" height="80" xmlns="http://www.w3.org/2000/svg">
  <rect width="700" height="80" fill="transparent"/>
  <text x="50%" y="35%" text-anchor="middle" font-size="20" fill="$COLOR1" font-family="monospace">
    𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ
  </text>
  <text x="50%" y="70%" text-anchor="middle" font-size="14" fill="$COLOR2" font-family="monospace">
    • Walking The Path Where Bits & Dreams Intersect ®
  </text>
</svg>
EOF

# -------------------------------
# Generate Terminal SVG (animated)
# -------------------------------
cat > "$ASSETS_DIR/terminal.svg" <<EOF
<svg width="700" height="180" xmlns="http://www.w3.org/2000/svg">
  <rect width="700" height="180" rx="10" ry="10" fill="#0d0d0d" stroke="$COLOR2" stroke-width="2"/>
  
  <text x="50%" y="25%" font-size="18" text-anchor="middle" font-family="monospace" fill="$COLOR1">
    <tspan id="line1" fill-opacity="0">> Initializing Quantum Matrix Shell...</tspan>
  </text>
  <text x="50%" y="50%" font-size="16" text-anchor="middle" font-family="monospace" fill="$COLOR2">
    <tspan id="line2" fill-opacity="0">ꚩꚶꛎꛘ𖢧ꚶ𖢑 𖦪𖤢ꛎꚳ𖢑 ⚡ ACTIVE</tspan>
  </text>
  <text x="50%" y="75%" font-size="16" text-anchor="middle" font-family="monospace" fill="$COLOR1">
    <tspan id="line3" fill-opacity="0">> Loading subatomic particles...</tspan>
  </text>
  <text x="50%" y="85%" font-size="16" text-anchor="middle" font-family="monospace" fill="$COLOR2">
    <tspan id="cursor">█</tspan>
  </text>

  <style>
    <![CDATA[
      #line1 { animation: type1 2s steps(40) forwards; }
      #line2 { animation: type2 2s steps(40) 2.5s forwards; }
      #line3 { animation: type3 2s steps(40) 5s forwards; }
      @keyframes type1 { from { fill-opacity:0 } to { fill-opacity:1 } }
      @keyframes type2 { from { fill-opacity:0 } to { fill-opacity:1 } }
      @keyframes type3 { from { fill-opacity:0 } to { fill-opacity:1 } }
      text { fill: url(#neonGradient); animation: neonShift 4s linear infinite alternate; }
      @keyframes neonShift { 0%{fill-opacity:0.8;}50%{fill-opacity:1;}100%{fill-opacity:0.8;} }
      #cursor { animation: blink 1s steps(2) infinite; }
      @keyframes blink { 0%,50%{opacity:1;}50.1%,100%{opacity:0;} }
    ]]>
  </style>

  <defs>
    <linearGradient id="neonGradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="$COLOR1"/>
      <stop offset="100%" stop-color="$COLOR2"/>
    </linearGradient>
  </defs>
</svg>
EOF

# -------------------------------
# Generate Quote SVG
# -------------------------------
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
# Generate README.md
# -------------------------------
CURRENT_TIME=$(date -u +"%Y-%m-%d %H:%M:%S")
GITHUB_USER="${GITHUB_USER:-thugger069}"
USERNAME="${USERNAME:-𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ}"

cat > README.md <<EOF
<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="dist/github-snake-dark.svg" />
    <source media="(prefers-color-scheme: light)" srcset="dist/github-snake.svg" />
    <img src="dist/github-snake.svg" alt="Neon Snake Animation"/>
  </picture>
</div>

<div align="center">
  <img src="assets/header.svg" alt="Signature Header" width="100%" />
</div>

<div align="center">
  <img src="assets/terminal.svg" alt="Animated Terminal" width="100%"/>
</div>

<div align="center">
  <img src="assets/quote.svg" alt="Quote" width="100%"/>
</div>

<div align="center">
  <img src="assets/particles.svg" alt="Particle Field Background" width="100%"/>
</div>

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME} UTC • Maintained by ${USERNAME}</sub>
</div>
EOF

echo "✅ Full dynamic README generated with header, terminal, snake, quote, and particles!"