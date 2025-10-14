#!/bin/bash
set -euo pipefail

# ================================
# 🜂 Q.R.I.P ALL-IN Update Terminal Script
# ================================

# Environment defaults
USERNAME=${USERNAME:-"𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ"}
username=${username:-"thugger069"}
CURRENT_TIME=${CURRENT_TIME:-$(date -u +"%Y-%m-%d %H:%M:%S")}

# ------------------------
# Helper: Generate random load average
# ------------------------
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

# ------------------------
# Generate Terminal Content
# ------------------------
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

# ------------------------
# Generate README.md
# ------------------------
generate_readme() {
    mkdir -p assets dist

    cat > README.md << EOF
<div align="center">
  <h2>👨‍💻 𖢧ꛅꚶꚽꚽ𖤢𖦪'ꕷ 𖦪𖤢ꛎꚳ𖢑</h2>

  [![Profile Views](https://komarev.com/ghpvc/?username=${username}&color=blueviolet&style=flat-square)](https://github.com/${username})

  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Ubuntu+Mono&duration=3000&pause=1000&color=00FF9C&center=true&vCenter=true&width=435&lines=ℌ𝔢𝔩𝔩𝔬+𝔗𝔥𝔢𝔯𝔢;ℑ’𝔪+${USERNAME};𝔚𝔢𝔩𝔠𝔬𝔪ｅ+𝔱𝔬+𝔪𝔶+𝔯𝔢𝔞𝔩𝔪;𝔖𝔥𝔢𝔩𝔩+𝔖𝔠𝔯𝔦𝔭𝔱+𝔈𝔫𝔱𝔥𝔲𝔰𝔦𝔞𝔰𝔱;𝔏𝔦𝔫𝔲𝔵+%26+𝔇𝔢𝔳𝔒𝔭𝔰+𝔈𝔵𝔭𝔩𝔬𝔯𝔢𝔯;𝔒𝔭𝔢𝔫+𝔖𝔬𝔲𝔯𝔠𝔢+ℭ𝔬𝔫𝔱𝔯𝔦𝔟𝔲𝔱𝔬𝔯;𝔄𝔩𝔴𝔞𝔶𝔰+𝔏𝔢𝔞𝔯𝔫𝔦𝔫𝔤+%F0%9F%92%A1" alt="Typing SVG" />
  </a>
</div>

<pre class="terminal">
$(cat terminal_output.txt)
</pre>

<!-- Snake animation -->
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="dist/github-snake-dark.svg?ts=${CURRENT_TIME//:/%3A}" />
  <source media="(prefers-color-scheme: light)" srcset="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
  <img alt="Github Contribution Snake Animation" src="dist/github-snake.svg?ts=${CURRENT_TIME//:/%3A}" />
</picture>

<div align="center">
  <sub>Last Updated: ${CURRENT_TIME} UTC</sub>
</div>
EOF
}

# ------------------------
# Install dependencies safely
# ------------------------
install_dependencies() {
    echo "Installing system packages..."
    sudo apt-get update
    sudo apt-get install -y figlet lolcat neofetch boxes cowsay fortune bc || true

    echo "Installing npm packages..."
    if [ -f package-lock.json ]; then
        npm ci
    else
        npm install
    fi

    sudo npm install -g terminalizer || echo "Terminalizer already installed"
}

# ------------------------
# Generate GitHub Snake
# ------------------------
generate_snake() {
    echo "Generating GitHub Snake..."
    if ! command -v snk &> /dev/null; then
        echo "Installing Platane/snk CLI..."
        npm install -g snk
    fi
    snk --github-user-name "$username" \
        --outputs "dist/github-snake.svg" "dist/github-snake-dark.svg?palette=github-dark" \
        --color-snake "#ff0000" \
        --color-dots "#00ff00"
}

# ------------------------
# Main execution
# ------------------------
main() {
    install_dependencies
    generate_terminal_content
    generate_snake
    generate_readme
    rm -f terminal_output.txt
    echo "✅ README and terminal content updated successfully!"
}

main