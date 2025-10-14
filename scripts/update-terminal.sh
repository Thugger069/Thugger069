#!/usr/bin/env bash
#
# ╔════════════════════════════════════════════════════════════════╗
# ║   Q.R.I.P ALL-IN V2: Quantum README Auto-Regenerator ⚡         ║
# ║   Thugger069 / 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ                                  ║
# ║   Animated terminal, snake, particles, dynamic quotes, repos   ║
# ╚════════════════════════════════════════════════════════════════╝
#
set -e

echo ""
echo "🜂 Initializing Q.R.I.P V2 Regeneration Sequence..."
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

# ╭───────────────────────────────╮
# │ STEP 2: Generate Dynamic Quote│
# ╰───────────────────────────────╯
QUOTES=(
  "Walking the Path Where Bits & Dreams Intersect."
  "Code, Chaos & Quantum Creativity."
  "Automate Everything, Question Nothing."
  "In Neon We Trust, In Code We Live."
)
RANDOM_QUOTE=${QUOTES[$((RANDOM % ${#QUOTES[@]}))]}

cat > "$ASSETS_DIR/quote.svg" <<EOF
<svg width="600" height="80" xmlns="http://www.w3.org/2000/svg">
  <rect width="600" height="80" fill="transparent"/>
  <text x="50%" y="50%" fill="$COLOR1" font-size="20" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    "$RANDOM_QUOTE"
  </text>
  <text x="50%" y="70%" fill="$COLOR2" font-size="14" text-anchor="middle" alignment-baseline="middle" font-family="monospace">
    — 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ
  </text>
</svg>
EOF

# ╭───────────────────────────────────────╮
# │ STEP 3: Generate Particle Field       │
# ╰───────────────────────────────────────╯
cat > "$ASSETS_DIR/particles.svg" <<EOF
<svg width="800" height="160" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="160" fill="#000"/>
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
# │ STEP 4: Generate Animated Terminal SVG     │
# ╰────────────────────────────────────────────╯
TERMINAL_FILE="$ASSETS_DIR/terminal.svg"
cat > "$TERMINAL_FILE" <<EOF
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

# ╭────────────────────────────────────────────╮
# │ STEP 5: Generate Neon Contribution Snake   │
# ╰────────────────────────────────────────────╯
npx --yes snk@0.1.2 generate \
  --user "$GITHUB_ACTOR" \
  --output "$DIST_DIR/github-snake.svg" \
  --palette "$COLOR1,$COLOR2" \
  || echo "⚠️ Snake generation skipped (local run mode)."

npx --yes snk@0.1.2 generate \
  --user "$GITHUB_ACTOR" \
  --output "$DIST_DIR/github-snake-dark.svg" \
  --palette "$COLOR1,$COLOR2" \
  --palette-dark \
  || echo "⚠️ Dark snake generation skipped (local run mode)."

# ╭────────────────────────────────────────────╮
# │ STEP 6: Generate README.md                 │
# ╰────────────────────────────────────────────╯
CURRENT_TIME=$(date -u +"%Y-%m-%d %H:%M:%S")
cat > README.md <<EOF
<div align="center">
  <h2>👨‍💻 𖢧ꛅꚶꚽꚽ𖤢𖦪'ꕷ 𖦪𖤢ꛎꚳ𖢑</h2>

  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Ubuntu+Mono&duration=3000&pause=1000&color=00FF9C&center=true&vCenter=true&width=435&lines=ℌ𝔢𝔩𝔩𝔬+𝔗𝔥𝔢𝔯𝔢;ℑ’𝔪+𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ;𝔚𝔢𝔩𝔠𝔬𝔪ｅ+𝔱𝔬+𝔪𝔶+𝔯𝔢𝔞𝔩𝔪" alt="Typing SVG" />
  </a>
</div>

<div align="center">
  <pre class="terminal">
$(cat <<TERMINAL
Last login: ${CURRENT_TIME} on ttys000
${CURRENT_TIME} up 02:51, 1 user, load average: 0.42 0.55 0.38
𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ@github ~ %
TERMINAL
)
  </pre>
</div>

<!-- START SNAKE -->
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="dist/github-snake-dark.svg?ts=${CURRENT_TIME//:/%3A}" />
  <source media="(prefers-color-scheme: light)" srcset="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  <img alt="Github Contribution Snake Animation" src="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
</picture>
<!-- END SNAKE -->

<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=100&section=footer"/>
</div>

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
</div>
EOF

echo "✅ Q.R.I.P ALL-IN V2 README regeneration complete at $(date -u)" | tee -a "$LOG_FILE"
