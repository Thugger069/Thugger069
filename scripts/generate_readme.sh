#!/bin/bash

# Configuration
USERNAME="Thugger069"
BANNER_COLOR="#00ff9f"
ACCENT_COLOR="#ff003c"
INTRO_TEXT="CyberSec Enthusiast | Full-Stack Architect | OSS Contributor"

generate_tech_badges() {
  TECH_STACK=(
    "Python|3776AB|python"
    "JavaScript|F7DF1E|javascript"
    "React|61DAFB|react"
    "Node.js|339933|node.js"
    "AWS|232F3E|amazon-aws"
    "Docker|2496ED|docker"
    "Kubernetes|326CE5|kubernetes"
    "TensorFlow|FF6F00|tensorflow"
  )
  
  printf "\n<div align=\"center\">\n"
  for item in "${TECH_STACK[@]}"; do
    IFS='|' read -ra ADDR <<< "$item"
    echo "[![${ADDR[0]}](https://img.shields.io/badge/-${ADDR[0]}-${ADDR[1]}?style=for-the-badge&logo=${ADDR[2]}&logoColor=white)]()"
  done
  printf "</div>\n"
}

generate_social_links() {
  SOCIAL_LINKS=(
    "linkedin.com/in/example|LinkedIn|0082CA"
    "twitter.com/example|Twitter|1DA1F2"
    "github.com/Thugger069|Portfolio|FF7139"
  )
  
  printf "\n<div align=\"center\">\n"
  for link in "${SOCIAL_LINKS[@]}"; do
    IFS='|' read -ra ADDR <<< "$link"
    echo "[![${ADDR[1]}](https://img.shields.io/badge/-${ADDR[1]}-${ADDR[2]}?style=for-the-badge&logo=${ADDR[1],,}&logoColor=white)](https://${ADDR[0]})"
  done
  printf "</div>\n"
}

# Generate README
cat > README.md <<EOF
<div align="center">
  <img src="https://raw.githubusercontent.com/$USERNAME/$USERNAME/main/assets/terminal.gif" width="800"/>
</div>

<h1 align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&size=30&duration=4000&color=$BANNER_COLOR&center=true&vCenter=true&width=600&lines=${USERNAME};${INTRO_TEXT// /+}" />
</h1>

## 🛠️ Cyber Arsenal
$(generate_tech_badges)

## 🌐 Social Matrix
$(generate_social_links)

<div align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=$USERNAME&show_icons=true&theme=dark&bg_color=00000000&hide_border=true&include_all_commits=true" />
  <img src="https://github-readme-streak-stats.herokuapp.com?user=$USERNAME&theme=dark&background=00000000&hide_border=true" />
</div>

## 🧠 Latest Projects
<!-- Add your pinned repositories here -->

## 📊 Activity Graph
[![GitHub Activity Graph](https://github-readme-activity-graph.vercel.app/graph?username=$USERNAME&theme=react-dark&hide_border=true&area=true)](https://github.com/$USERNAME)

<div align="center">
  <img src="https://quotes-github-readme.vercel.app/api?type=horizontal&theme=dark" />
  <img src="https://api.daily.dev/devcards/your-card-id.png?r=bsb" width="30%"/>
</div>

<details>
  <summary>📈 Detailed Stats</summary>
  <br/>
  <img src="https://github-profile-trophy.vercel.app/?username=$USERNAME&theme=onedark&no-frame=true&margin-w=15" />
  <img src="https://wakatime.com/share/@$USERNAME/your-embed-code.svg" />
</details>
EOF

echo "✅ Cyber-README generated!"
