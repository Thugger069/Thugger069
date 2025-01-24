#!/bin/bash

set -e  # Exit on any error

# Use environment variables or defaults
USERNAME=${USERNAME:-"Thugger069"}
CURRENT_TIME=${CURRENT_TIME:-"2025-01-24 12:48:26"}

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
${USERNAME}@github ~ % uptime
${CURRENT_TIME} up 12:48, 1 user, load average: ${LOAD_AVG}

${USERNAME}@github ~ % ls -la Projects/
total 40
drwxr-xr-x  8 ${USERNAME}  staff  256 Jan 24 12:48 .
drwxr-xr-x  5 ${USERNAME}  staff  160 Jan 24 12:48 ..
drwxr-xr-x  7 ${USERNAME}  staff  224 Jan 24 12:48 DevOps
drwxr-xr-x  6 ${USERNAME}  staff  192 Jan 24 12:48 OpenSource
drwxr-xr-x  5 ${USERNAME}  staff  160 Jan 24 12:48 Scripts
-rw-r--r--  1 ${USERNAME}  staff  925 Jan 24 12:48 TODO.md

${USERNAME}@github ~ % cat Projects/TODO.md
# Current Projects 📋
→ Automating deployment workflows
→ Contributing to open source
→ Learning Kubernetes
→ Building shell script utilities

${USERNAME}@github ~ % fortune | cowsay
EOF

    # Add styled username with error handling
    if ! figlet -f slant "${USERNAME}" | lolcat -f >> terminal_output.txt; then
        echo "${USERNAME}" >> terminal_output.txt
    fi
    
    # Add system info with error handling
    if ! neofetch --stdout >> terminal_output.txt; then
        echo "System information unavailable" >> terminal_output.txt
    fi
}

# Update README content to include the welcome GIF
generate_readme() {
    cat > README.md << EOF
<div align="center">
  <h1>👨‍💻 Welcome to ${USERNAME}'s Terminal</h1>
  
  <!-- Welcome Message GIF -->
  <img src="assets/welcome.gif" alt="Welcome Message" width="800"/>
  
  [![Profile Views](https://komarev.com/ghpvc/?username=${USERNAME}&color=blueviolet&style=flat-square&label=Profile%20Views)](https://github.com/${USERNAME})
  [![Last Updated](https://img.shields.io/badge/Last%20Updated-${CURRENT_TIME//:/%3A}-blue.svg)](https://github.com/${USERNAME})

  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.demolab.com?font=Ubuntu+Mono&duration=3000&pause=1000&color=00FF9C&center=true&vCenter=true&width=435&lines=Shell+Script+Enthusiast;Linux+%26+DevOps+Explorer;Open+Source+Contributor;Always+Learning+%F0%9F%92%A1" alt="Typing SVG" />
  </a>
</div>

<pre class="terminal">
$(cat terminal_output.txt)
</pre>

<!-- Rest of the README content remains the same -->
EOF
}

# Generate the README content
generate_readme() {
    cat > README.md << EOF
<div align="center">
  <h1>👨‍💻 Welcome to ${USERNAME}'s Terminal</h1>
  
  [![Profile Views](https://komarev.com/ghpvc/?username=${USERNAME}&color=blueviolet&style=flat-square&label=Profile%20Views)](https://github.com/${USERNAME})
  [![Last Updated](https://img.shields.io/badge/Last%20Updated-${CURRENT_TIME//:/%3A}-blue.svg)](https://github.com/${USERNAME})

  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.demolab.com?font=Ubuntu+Mono&duration=3000&pause=1000&color=00FF9C&center=true&vCenter=true&width=435&lines=Shell+Script+Enthusiast;Linux+%26+DevOps+Explorer;Open+Source+Contributor;Always+Learning+%F0%9F%92%A1" alt="Typing SVG" />
  </a>
</div>

<pre class="terminal">
$(cat terminal_output.txt)
</pre>

<div align="center">
  <h2>🔧 Technologies & Tools</h2>
  
  ![Shell Script](https://img.shields.io/badge/Shell_Script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
  ![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
  ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
  ![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
  ![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)

  <h2>📊 GitHub Statistics</h2>
  
  <img src="https://github-readme-stats.vercel.app/api?username=${USERNAME}&show_icons=true&theme=radical&cache_seconds=86400" alt="GitHub Stats" height="170"/>
  <img src="https://github-readme-streak-stats.herokuapp.com/?user=${USERNAME}&theme=radical&cache_seconds=86400" alt="GitHub Streak" height="170"/>

  <h2>🤝 Connect With Me</h2>
  
  [![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/${USERNAME})
  [![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/${USERNAME})
  [![Twitter](https://img.shields.io/badge/X-%23000000.svg?style=for-the-badge&logo=X&logoColor=white)](https://twitter.com/${USERNAME})
</div>

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
