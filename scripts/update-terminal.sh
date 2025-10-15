#!/bin/bash
set -e  # Exit on any error

# ─────────────────────────────
# User & Environment Defaults
# ─────────────────────────────
USERNAME=${USERNAME:-"𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ"}
username=${username:-"thugger069"}
CURRENT_TIME=$(date -u +"%Y-%m-%d %H:%M:%S")

# ─────────────────────────────
# Function: Generate random load average
# ─────────────────────────────
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

# ─────────────────────────────
# Function: Generate terminal content
# ─────────────────────────────
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

# ─────────────────────────────
# Function: Generate README.md
# ─────────────────────────────
generate_readme() {
    cat > README.md << EOF
<div align="center">
  <h2>👨‍💻 ${USERNAME}</h2>

  [![Profile Views](https://komarev.com/ghpvc/?username=${username}&color=blueviolet&style=flat-square)](https://github.com/${username})

  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Ubuntu+Mono&duration=3000&pause=1000&color=00FF9C&center=true&vCenter=true&width=435&lines=ℌ𝔢𝔩𝔩𝔬+𝔗𝔥𝔢𝔯𝔢;ℑ’𝔪+${USERNAME};𝔚𝔢𝔩𝔠𝔬𝔪ｅ+𝔱𝔬+𝔪𝔶+𝔯𝔢𝔞𝔩𝔪;𝔖𝔥𝔢𝔩𝔩+𝔖𝔠𝔯𝔦𝔭𝔱+𝔈𝔫𝔱𝔥𝔲𝔰𝔦𝔞𝔰𝔱" alt="Typing SVG" />
  </a>
</div>

<pre class="terminal">
$(cat terminal_output.txt)
</pre>

<!-- START SNAKE -->
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="dist/github-snake-dark.svg?ts=${CURRENT_TIME//:/%3A}" />
  <source media="(prefers-color-scheme: light)" srcset="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  <img alt="Github Contribution Snake Animation" src="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
</picture>
<!-- END SNAKE -->

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
</div>
EOF
}

# ─────────────────────────────
# Function: Generate Neon Snake
# ─────────────────────────────
generate_neon_snake() {
    mkdir -p dist

    # Random neon palette
    COLORS=(
      "#39FF14,#00FFF0"
      "#FF00FF,#FFDD00"
      "#00FFFF,#FF00FF"
      "#FF4D00,#39FF14"
    )
    RANDOM_INDEX=$(( RANDOM % ${#COLORS[@]} ))
    COLOR_SN=(${COLORS[$RANDOM_INDEX]//,/ })
    
    # Run Platane/snk CLI
    npx snk \
      --github-user-name "${username}" \
      --outputs "dist/github-snake.svg" "dist/github-snake-dark.svg?palette=github-dark" \
      --snake-color "${COLOR_SN[0]}" \
      --dots-color "${COLOR_SN[1]}" \
      --background-color "#0d0d0d"
}

# ─────────────────────────────
# Function: Commit & Push
# ─────────────────────────────
commit_and_push() {
    git config --local user.name "${username}"
    git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
    git add -f README.md dist/github-snake*.svg
    git commit -m "🧬 Q.R.I.P Terminal & Snake Update (${CURRENT_TIME})" || echo "No changes to commit"
    git push
}

# ─────────────────────────────
# Main Execution
# ─────────────────────────────
main() {
    generate_terminal_content
    generate_neon_snake
    generate_readme
    commit_and_push

    # Cleanup
    rm -f terminal_output.txt
}

main