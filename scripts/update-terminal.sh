#!/bin/bash
set -e

# -----------------------------
# Environment variables
# -----------------------------
USERNAME=${USERNAME:-"𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ"}
CURRENT_TIME=${CURRENT_TIME:-"$(date -u +"%Y-%m-%d %H:%M:%S")"}

# -----------------------------
# Generate random load average
# -----------------------------
generate_load_avg() {
    printf "%.2f %.2f %.2f" \
        "$(awk -v min=0.1 -v max=1.0 'BEGIN{srand(); print min+rand()*(max-min)}')" \
        "$(awk -v min=0.2 -v max=1.2 'BEGIN{srand(); print min+rand()*(max-min)}')" \
        "$(awk -v min=0.1 -v max=1.0 'BEGIN{srand(); print min+rand()*(max-min)}')"
}

# -----------------------------
# Generate terminal output
# -----------------------------
generate_terminal_content() {
    local LOAD_AVG
    LOAD_AVG=$(generate_load_avg)

    cat > terminal_output.txt << EOF
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
}

# -----------------------------
# Generate README.md
# -----------------------------
generate_readme() {
    cat > README.md << EOF
<div align="center">
  <h2>👨‍💻 ${USERNAME}</h2>

  [![Profile Views](https://komarev.com/ghpvc/?username=thugger069&color=blueviolet&style=flat-square)](https://github.com/thugger069)

  <pre class="terminal">
$(cat terminal_output.txt)
  </pre>

  <!-- GitHub Snake -->
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="dist/github-snake-dark.svg" />
    <source media="(prefers-color-scheme: light)" srcset="dist/github-snake.svg" />
    <img alt="Github Snake Animation" src="dist/github-snake.svg" />
  </picture>

  <div align="center">
    <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
  </div>
</div>
EOF
}

# -----------------------------
# Generate Neon Snake Animations
# -----------------------------
generate_snake() {
    mkdir -p dist
    # Define random neon palette
    PALETTES=(
      "#39FF14,#00FFF0" "#FF00FF,#FFDD00" "#00FFFF,#FF00FF" "#FF4D00,#39FF14"
    )
    I=$(( RANDOM % ${#PALETTES[@]} ))
    SNAKE_COLOR=$(echo ${PALETTES[$I]} | cut -d',' -f1)
    DOTS_COLOR=$(echo ${PALETTES[$I]} | cut -d',' -f2)

    # Generate light snake
    npx snk --github-user-name="${GITHUB_REPOSITORY_OWNER}" \
      --outputs="dist/github-snake.svg" \
      --color-snake="${SNAKE_COLOR}" \
      --color-dots="${DOTS_COLOR}"

    # Generate dark snake
    npx snk --github-user-name="${GITHUB_REPOSITORY_OWNER}" \
      --outputs="dist/github-snake-dark.svg" \
      --color-snake="${SNAKE_COLOR}" \
      --color-dots="${DOTS_COLOR}" \
      --palette=github-dark
}

# -----------------------------
# Main execution
# -----------------------------
main() {
    generate_terminal_content
    generate_snake
    generate_readme
    rm -f terminal_output.txt
}

main