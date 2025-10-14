#!/bin/bash
set -e  # Exit on any error

# -----------------------------
# Environment Variables / Defaults
# -----------------------------
USERNAME=${USERNAME:-"𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ"}
CURRENT_TIME=${CURRENT_TIME:-$(date -u +"%Y-%m-%d %H:%M:%S")}

# -----------------------------
# Functions
# -----------------------------

# Generate random load average
generate_load_avg() {
    if ! command -v bc &> /dev/null; then
        echo "0.50 0.60 0.40"  # fallback
        return
    fi
    printf "%.2f %.2f %.2f" \
        "$(echo "scale=2; ${RANDOM}/32767 + 0.1" | bc)" \
        "$(echo "scale=2; ${RANDOM}/32767 + 0.2" | bc)" \
        "$(echo "scale=2; ${RANDOM}/32767 + 0.1" | bc)"
}

# Generate terminal content
generate_terminal_content() {
    local LOAD_AVG
    LOAD_AVG=$(generate_load_avg)

    cat > terminal_output.txt << EOF
Last login: ${CURRENT_TIME} on ttys000
${USERNAME}@github ~ % uptime
${CURRENT_TIME} up 02:51, 1 user, load average: ${LOAD_AVG}

${USERNAME}@github ~ % ls -la Projects/
total 40
drwxr-xr-x  8 ${USERNAME}  staff  256 ${CURRENT_TIME}
drwxr-xr-x  5 ${USERNAME}  staff  160 ${CURRENT_TIME}
drwxr-xr-x  7 ${USERNAME}  staff  224 ${CURRENT_TIME} DevOps
drwxr-xr-x  6 ${USERNAME}  staff  192 ${CURRENT_TIME} OpenSource
drwxr-xr-x  5 ${USERNAME}  staff  160 ${CURRENT_TIME} Scripts
-rw-r--r--  1 ${USERNAME}  staff  925 ${CURRENT_TIME} TODO.md

${USERNAME}@github ~ % cat Projects/TODO.md
# ℭ𝔲𝔯𝔯𝔢𝔫𝔱 𝔓𝔯𝔬𝔧𝔢𝔠𝔱𝔰 📋

→ Automating deployment workflows
→ Contributing to open source
→ Learning Kubernetes
→ Building shell script utilities

${USERNAME}@github ~ %
EOF
}

# Generate GitHub README content
generate_readme() {
    cat > README.md << EOF
<div align="center">
  <h2>👨‍💻 ${USERNAME}</h2>

  [![Profile Views](https://komarev.com/ghpvc/?username=thugger069&color=blueviolet&style=flat-square)](https://github.com/thugger069)

  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Ubuntu+Mono&duration=3000&pause=1000&color=00FF9C&center=true&vCenter=true&width=435&lines=ℌ𝔢𝔩𝔩𝔬+𝔗𝔥𝔢𝔯𝔢;ℑ’𝔪+${USERNAME};𝔚𝔢𝔩𝔠𝔬𝔪ｅ+𝔱𝔬+𝔪𝔶+𝔯𝔢𝔞𝔩𝔪;𝔖𝔥𝔢𝔩𝔩+𝔖𝔠𝔯𝔦𝔭𝔱+𝔈𝔫𝔱𝔥𝔲𝔰𝔦𝔞𝔰𝔱;𝔏𝔦𝔫𝔲𝔵+%26+𝔇𝔢𝔳𝔒𝔭𝔰+𝔈𝔵𝔭𝔩𝔬𝔯𝔢𝔯;𝔒𝔭𝔢𝔫+𝔖𝔬𝔲𝔯𝔠𝔢+ℭ𝔬𝔫𝔱𝔯𝔦𝔟𝔲𝔱𝔬𝔯;𝔄𝔩𝔴𝔞𝔶𝔰+𝔏𝔢𝔞𝔯𝔫𝔦𝔫𝔤+%F0%9F%92%A1" alt="Typing SVG" />
  </a>
</div>

<pre class="terminal">
$(cat terminal_output.txt)
</pre>

<div align="center">
  <h3>📈 GitHub Stats</h3>
  <img src="https://github-readme-stats.vercel.app/api?username=thugger069&show_icons=true&theme=radical" alt="GitHub Stats" height="170"/>
  <img src="https://github-readme-streak-stats.herokuapp.com/?user=thugger069&theme=radical" alt="GitHub Streak" height="170"/>
</div>

<div align="center">
  <h3>🐍 GitHub Snake</h3>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="dist/github-snake-dark.svg?ts=${CURRENT_TIME//:/%3A}" />
    <source media="(prefers-color-scheme: light)" srcset="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
    <img alt="Github Contribution Snake Animation" src="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  </picture>
</div>

<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=100&section=footer"/>
  <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
</div>
EOF
}

# -----------------------------
# Main Execution
# -----------------------------
main() {
    mkdir -p dist assets

    # Generate terminal content
    generate_terminal_content

    # Generate README
    generate_readme

    # Clean up
    rm -f terminal_output.txt
}

main