#!/bin/bash
set -e

# -------------------------------
# Q.R.L.P ALL-IN: README Update
# -------------------------------

# Environment variables
USERNAME=${USERNAME:-"𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ"}
GITHUB_USER=${GITHUB_USER:-"thugger069"}
CURRENT_TIME=$(date -u +"%Y-%m-%d %T")
DIST_DIR="dist"

# Ensure dist directory exists
mkdir -p "$DIST_DIR"

# -------------------------------
# 1️⃣ Generate Signature Header SVG
# -------------------------------
echo "▶ Generating signature header..."
cat > "$DIST_DIR/header.svg" <<'EOF'
<svg viewBox="0 0 900 160" width="100%" height="160" xmlns="http://www.w3.org/2000/svg">
  <style>
    .text { 
      font-family: 'Fira Code', monospace; 
      font-size: 28px; 
      fill: url(#neonGradient); 
      filter: url(#glow);
      animation: hueShift 8s infinite linear;
    }
    @keyframes hueShift {
      0% { filter: hue-rotate(0deg); }
      100% { filter: hue-rotate(360deg); }
    }
    .sub { font-size: 16px; fill: #39FF14; }
  </style>
  <defs>
    <linearGradient id="neonGradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#00fff0"/>
      <stop offset="50%" stop-color="#ff00ff"/>
      <stop offset="100%" stop-color="#39ff14"/>
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="3.5" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  <text x="50%" y="50" dominant-baseline="middle" text-anchor="middle" class="text">
    𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ
  </text>
  <text x="50%" y="90" dominant-baseline="middle" text-anchor="middle" class="sub">
    Walking The Path Where Bits & Dreams Intersect ®
  </text>
</svg>
EOF

# -------------------------------
# 2️⃣ Generate Terminal SVG (Animated Typewriter)
# -------------------------------
echo "▶ Generating terminal SVG..."
TERMINAL_TEXT="Last login: ${CURRENT_TIME} on ttys000\n${USERNAME}@github ~ % echo 'Q.R.L.P ALL-IN Activated!'"
TERMINAL_LENGTH=${#TERMINAL_TEXT}

cat > "$DIST_DIR/terminal.svg" <<EOF
<svg viewBox="0 0 800 160" width="100%" height="160" xmlns="http://www.w3.org/2000/svg">
  <style>
    .bg { fill:#0d0d0d; stroke:#00fff0; stroke-width:2; rx:16; filter:url(#glow); }
    .text { font-family: 'Fira Code', monospace; font-size: 18px; fill:#00fff0; white-space:pre; }
    .cursor { animation: blink 1s steps(1) infinite; }
    .typing { animation: typing 4s steps($TERMINAL_LENGTH, end) 1; overflow:hidden; white-space:nowrap; width:0; }
    @keyframes blink { 0%,49%{opacity:1;}50%,100%{opacity:0;} }
    @keyframes typing { from { width: 0 } to { width: ${TERMINAL_LENGTH}ch; } }
    @media (prefers-color-scheme: light) { .bg { fill:#fff; stroke:#0d0d0d; } .text { fill:#0d0d0d; } }
  </style>
  <defs>
    <filter id="glow"><feGaussianBlur stdDeviation="3.5" result="blur"/><feMerge><feMergeNode in="blur"/><feMergeNode in="SourceGraphic"/></feMerge></filter>
  </defs>
  <rect x="10" y="10" width="780" height="140" rx="16" class="bg"/>
  <foreignObject x="20" y="20" width="760" height="120">
    <div xmlns="http://www.w3.org/1999/xhtml">
      <span class="text typing">$TERMINAL_TEXT</span><span class="text cursor">█</span>
    </div>
  </foreignObject>
</svg>
EOF

# -------------------------------
# 3️⃣ Fetch & Generate Quote SVG
# -------------------------------
echo "▶ Fetching and rendering quote..."
node scripts/fetch-quote.js

# -------------------------------
# 4️⃣ Generate README.md
# -------------------------------
echo "▶ Generating README.md..."
cat > README.md <<EOF
<div align="center">
  <img src="${DIST_DIR}/header.svg" alt="Signature Header" width="100%" />
</div>

<div align="center">
  <img src="${DIST_DIR}/terminal.svg" alt="Animated Terminal" />
</div>

<div align="center">
  <img src="${DIST_DIR}/quote.svg" alt="Typewriter Quote" />
</div>

<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="${DIST_DIR}/github-snake-dark.svg?ts=${CURRENT_TIME//:/%3A}" />
    <source media="(prefers-color-scheme: light)" srcset="${DIST_DIR}/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
    <img alt="GitHub Contribution Snake" src="${DIST_DIR}/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  </picture>
</div>

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
</div>

<sub align="center">🧿 Updated daily by <code>update-readme.sh</code> • 🧬 Maintained by ${USERNAME}</sub>
EOF

echo "✅ README.md fully updated with Q.R.L.P ALL-IN enhancements!"