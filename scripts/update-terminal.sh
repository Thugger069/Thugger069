#!/bin/bash

set -e  # Exit on any error

# Use environment variables or defaults
USERNAME=${USERNAME:-"𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ"}
username=${username:-"thugger069"}
CURRENT_TIME=${CURRENT_TIME:-"2025-05-07 02:51:55"}

# Function to generate random load average
generate_load_avg() {
    if ! command -v bc &> /dev/null; then
        echo "0.50 0.60 0.40"  # Fallback if bc is not available
        return
    fi
    printf "%.2f %.2f %.2f" \
        "$(echo "scale=2; ${RANDOM}/32767 + 0.1" | bc)" \
        "$(echo "scale=2; ${RANDOM}/32767 + 0.2" | bc)" \
        "$(echo "scale=2; ${RANDOM}/32767 + 0.1" | bc)"
}

# Generate dynamic terminal content with error handling
generate_terminal_content() {
    local LOAD_AVG
    LOAD_AVG=$(generate_load_avg)
    
    cat > terminal_output.txt << EOF
Last login: ${CURRENT_TIME} on ttys000
𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ@github ~ % uptime
${CURRENT_TIME} up 02:51, 1 user, load average: ${LOAD_AVG}

𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ@github ~ % ls -la Projects/
total 40
drwxr-xr-x  8 ${USERNAME}  staff  256 May 07 02:51 .
drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 02:51 ..
drwxr-xr-x  7 ${USERNAME}  staff  224 May 07 02:51 DevOps
drwxr-xr-x  6 ${USERNAME}  staff  192 May 07 02:51 OpenSource
drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 02:51 Scripts
-rw-r--r--  1 ${USERNAME}  staff  925 May 07 02:51 TODO.md

𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ@github ~ % cat Projects/TODO.md
# ℭ𝔲𝔯𝔯𝔢𝔫𝔱 𝔓𝔯𝔬𝔧𝔢𝔠𝔱𝔰 📋

→ Automating deployment workflows
→ Contributing to open source
→ Learning Kubernetes
→ Building shell script utilities

𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ@github ~ % 
EOF
}

# Generate the README content
generate_readme() {
    cat > README.md << EOF
<div align="center">
  <h1>👨‍💻𖢧ꛅꚶꚽꚽ𖤢𖦪'ꕷ 𖦪𖤢ꛎꚳ𖢑</h1>

  [![Profile Views](https://komarev.com/ghpvc/?username=thugger069&color=blueviolet&style=flat-square&label=Profile%20Views)](https://github.com/thugger069)
  [![Last Updated](https://img.shields.io/badge/Last%20Updated-${CURRENT_TIME//:/%3A}-blue.svg)](https://github.com/thugger069)

  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Ubuntu+Mono&duration=3000&pause=1000&color=00FF9C&center=true&vCenter=true&width=435&lines=ℌ𝔢𝔩𝔩𝔬+𝔗𝔥𝔢𝔯𝔢;ℑ’𝔪+𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ;𝔚𝔢𝔩𝔠𝔬𝔪𝔢+𝔱𝔬+𝔪𝔶+𝔯𝔢𝔞𝔩𝔪;𝔖𝔥𝔢𝔩𝔩+𝔖𝔠𝔯𝔦𝔭𝔱+𝔈𝔫𝔱𝔥𝔲𝔰𝔦𝔞𝔰𝔱;𝔏𝔦𝔫𝔲𝔵+%26+𝔇𝔢𝔳𝔒𝔭𝔰+𝔈𝔵𝔭𝔩𝔬𝔯𝔢𝔯;𝔒𝔭𝔢𝔫+𝔖𝔬𝔲𝔯𝔠𝔢+ℭ𝔬𝔫𝔱𝔯𝔦𝔟𝔲𝔱𝔬𝔯;𝔄𝔩𝔴𝔞𝔶𝔰+𝔏𝔢𝔞𝔯𝔫𝔦𝔫𝔤+%F0%9F%92%A1" alt="Typing SVG" />
  </a>
</div>

<pre class="terminal">
$(cat terminal_output.txt)
</pre>

<div align="center">
  <h2>🧰 𖢧𖤢ꛕꛅꛘ𖣠ꚳ𖣠ꚽꛈ𖤢ꕷ & 𖢧𖣠𖣠ꚳꕷ</h2>
  
  ![Shell Script](https://img.shields.io/badge/Shell_Script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
  ![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
  ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
  ![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
  ![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)
  ![Tech Matrix](https://img.shields.io/static/v1?label=&message=TypeScript|Python|Rust|WASM&color=00ff9d&style=for-the-badge)

  <h2>📈 ꚽꛈ𖢧ꛅꚶꔪ ꕷ𖢧ꛎ𖢧ꛈꕷ𖢧ꛈꛕꕷ</h2>
  
  <img src="https://github-readme-stats-thugger069.vercel.app/api?username=thugger069&show_icons=true&theme=radical&cache_seconds=1800" alt="GitHub Stats" height="170"/>
  <img src="https://github-readme-streak-stats.herokuapp.com/?user=thugger069&theme=radical&cache_seconds=1800" alt="GitHub Streak" height="170"/>

  <h2>🤝 ꛕ𖣠ꛘꛘ𖤢ꛕ𖢧 ꛃꛈ𖢧ꛅ 𖢑𖤢</h2>
  
  [![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/thugger069)
  [![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/thugger069)
  [![Twitter](https://img.shields.io/badge/X-%23000000.svg?style=for-the-badge&logo=X&logoColor=white)](https://twitter.com/chuksgincaro)
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
}

# Main execution
main() {
    # Create necessary directories
    mkdir -p assets

    # Generate content
    generate_terminal_content
    generate_readme

    # Clean up
    rm -f terminal_output.txt
}

# Run main function
main