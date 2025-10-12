#!/usr/bin/env bash
set -e

# -------------------------------
# Q.R.I.P ALL-IN: README Update
# -------------------------------

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$ROOT_DIR/assets"
DIST_DIR="$ROOT_DIR/dist"
mkdir -p "$ASSETS_DIR" "$DIST_DIR"

# Environment variables
USERNAME=${USERNAME:-"𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ"}
GITHUB_USER=${GITHUB_USER:-"thugger069"}
CURRENT_TIME=$(date -u +"%Y-%m-%d %T")

# -------------------------------
# 1️⃣ Generate Signature Header SVG
# -------------------------------
echo "▶ Generating signature header..."
cat > "$ASSETS_DIR/header.svg" <<EOF
<svg width="800" height="120" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="120" rx="12" ry="12" fill="#0d0d0d"/>
  <text x="50%" y="40%" fill="#39FF14" font-size="24" text-anchor="middle" font-family="monospace">
    ${USERNAME}
  </text>
  <text x="50%" y="70%" fill="#00FFF0" font-size="16" text-anchor="middle" font-family="monospace">
    • Walking The Path Where Bits & Dreams Intersect ®
  </text>
</svg>
EOF

# -------------------------------
# 2️⃣ Generate Particle Background SVG
# -------------------------------
echo "▶ Generating particle background..."
cat > "$ASSETS_DIR/particles.svg" <<EOF
<svg width="800" height="120" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="120" fill="#000000"/>
  <g fill="#39FF14">
    $(for i in $(seq 1 50); do
      X=$(( RANDOM % 800 ))
      Y=$(( RANDOM % 120 ))
      echo "<circle cx='$X' cy='$Y' r='1.5' opacity='0.$((RANDOM % 8 + 2))'/>"
    done)
  </g>
</svg>
EOF

# -------------------------------
# 3️⃣ Generate Terminal SVG
# -------------------------------
echo "▶ Generating terminal SVG with typewriter animation..."
node "$ROOT_DIR/scripts/generate-terminal-svg.js"

# -------------------------------
# 4️⃣ Generate Quote SVG
# -------------------------------
echo "▶ Generating animated quote SVG..."
node "$ROOT_DIR/scripts/fetch-quote.js"

# -------------------------------
# 5️⃣ Generate README.md
# -------------------------------
echo "▶ Generating README.md..."
cat > "$ROOT_DIR/README.md" <<EOF
<div align="center">
  <img src="${ASSETS_DIR}/header.svg" alt="Signature Header" width="100%"/>
  <img src="${ASSETS_DIR}/particles.svg" alt="Particle Field" width="100%"/>
  <img src="${ASSETS_DIR}/terminal.svg" alt="Quantum Terminal" width="100%"/>
</div>

<div align="center">
  <img src="${ASSETS_DIR}/quote.svg" alt="Quantum Quote" width="80%"/>
</div>

[![Profile Views](https://komarev.com/ghpvc/?username=${GITHUB_USER}&color=blueviolet&style=flat-square)](https://github.com/${GITHUB_USER})

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
</div>

<sub align="center">🧿 Auto-updated daily by <code>update_readme.sh</code> • 🧬 Maintained by ${USERNAME}</sub>
EOF

echo "✅ README.md updated successfully with particles + signature header."