#!/bin/bash
set -e

# ───────────────────────────────
# QRLP ALL-IN: Update Terminal + README + Particle Field
# ───────────────────────────────

USERNAME=${USERNAME:-"𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ"}
CURRENT_TIME=${CURRENT_TIME:-"$(date -u +"%Y-%m-%d %H:%M:%S")"}

TERMINAL_FILE="terminal_output.txt"
PARTICLES_FILE="assets/particles.svg"

mkdir -p assets dist

# ───────────────────────────────
# Function: Generate random load average
# ───────────────────────────────
generate_load_avg() {
    if ! command -v bc &> /dev/null; then
        echo "0.50 0.60 0.40"
        return
    fi
    printf "%.2f %.2f %.2f" \
        "$(echo "scale=2; ${RANDOM}/32767 + 0.1" | bc)" \
        "$(echo "scale=2; ${RANDOM}/32767 + 0.2" | bc)" \
        "$(echo "scale=2; ${RANDOM}/32767 + 0.1" | bc)"
}

# ───────────────────────────────
# Generate terminal simulation
# ───────────────────────────────
LOAD_AVG=$(generate_load_avg)

cat > "$TERMINAL_FILE" << EOF
Last login: ${CURRENT_TIME} on ttys000
${USERNAME}@github ~ % uptime
${CURRENT_TIME} up 02:51, 1 user, load average: ${LOAD_AVG}

${USERNAME}@github ~ % ls -la Projects/
total 40
drwxr-xr-x  8 ${USERNAME}  staff  256 May 07 02:51 .
drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 02:51 ..
drwxr-xr-x  7 ${USERNAME}  staff  224 May 07 02:51 DevOps
drwxr-xr-x  6 ${USERNAME}  staff  192 May 07 02:51 OpenSource
drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 02:51 Scripts
-rw-r--r--  1 ${USERNAME}  staff  925 May 07 02:51 TODO.md

${USERNAME}@github ~ % cat Projects/TODO.md
# ℭ𝔲𝔯𝔯𝔢𝔫𝔱 𝔓𝔯𝔬𝔧𝔢𝔠𝔱𝔰 📋

→ Automating deployment workflows
→ Contributing to open source
→ Learning Kubernetes
→ Building shell script utilities

${USERNAME}@github ~ %
EOF

# ───────────────────────────────
# Generate particle SVG
# ───────────────────────────────
PARTICLE_COLOR1="#39FF14"
PARTICLE_COLOR2="#00FFF0"

cat > "$PARTICLES_FILE" << EOF
<svg width="800" height="160" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="160" fill="#000000"/>
  <g fill="$PARTICLE_COLOR1">
EOF

# Map dots from terminal content to particles
while read -r line; do
    for (( i=0; i<${#line}; i++ )); do
        char="${line:$i:1}"
        if [[ "$char" == "•" ]]; then
            X=$(( RANDOM % 800 ))
            Y=$(( RANDOM % 160 ))
            OPACITY=$(awk -v min=0.2 -v max=0.8 'BEGIN{srand(); print min+rand()*(max-min)}')
            echo "<circle cx='$X' cy='$Y' r='1.5' opacity='$OPACITY'/>" >> "$PARTICLES_FILE"
        fi
    done
done < "$TERMINAL_FILE"

cat >> "$PARTICLES_FILE" << EOF
  </g>
</svg>
EOF

# ───────────────────────────────
# Generate README.md
# ───────────────────────────────
cat > README.md << EOF
<div align="center">
  <h2>👨‍💻 ${USERNAME}</h2>

  <pre class="terminal">
$(cat $TERMINAL_FILE)
  </pre>

  <h3>🌌 Quantum Particle Field</h3>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="$PARTICLES_FILE"/>
    <source media="(prefers-color-scheme: light)" srcset="$PARTICLES_FILE"/>
    <img alt="Dynamic Particle Field" src="$PARTICLES_FILE"/>
  </picture>

  <div align="center">
    <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
  </div>
</div>
EOF

# Clean up
rm -f "$TERMINAL_FILE"

echo "✅ README.md updated with dynamic terminal + particle field."
