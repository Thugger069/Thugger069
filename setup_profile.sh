#!/bin/bash

# Configuration
USERNAME="Thugger069"
THEME_COLOR="#2E86C1"
GIF_URL="https://raw.githubusercontent.com/$USERNAME/$USERNAME/main/assets/terminal.gif"
SOCIAL_LINKS=(
  "LinkedIn|https://linkedin.com/in/example|0077B5"
  "Twitter|https://twitter.com/example|1DA1F2"
  "Portfolio|https://example.com|FF5722"
)
TECH_STACK=(
  "Python|3776AB|python"
  "JavaScript|F7DF1E|javascript"
  "React|61DAFB|react"
  "Node.js|339933|node.js"
  "Docker|2496ED|docker"
  "AWS|232F3E|amazon-aws"
)

# Create directory structure
mkdir -p {.github/workflows,config,scripts,assets}

# Generate GitHub Actions workflow
cat > .github/workflows/terminal.yml <<EOF
name: Terminal Animation
on:
  schedule:
    - cron: '0 0 * * *'  # Daily at midnight
  workflow_dispatch:

jobs:
  generate-terminal:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Setup environment
        run: |
          sudo apt-get update
          sudo apt-get install -y xvfb lolcat figlet neofetch fonts-firacode

      - name: Install dependencies
        run: |
          npm install -g terminalizer@0.8.2
          pip install lolcat==1.4

      - name: Record terminal session
        run: |
          chmod +x scripts/terminal_demo.sh
          xvfb-run terminalizer record -k -c config/terminalizer.yml
          terminalizer render terminalizer-config.yml -o assets/terminal.gif

      - name: Commit changes
        run: |
          git config --global user.name "GitHub Actions"
          git config --global user.email "actions@github.com"
          git add assets/terminal.gif
          git commit -m "🔄 Update terminal animation"
          git push
EOF

# Generate Terminalizer config
cat > config/terminalizer.yml <<EOF
cols: 80
rows: 15
frameDelay: 120
repeat: 0
quality: 100
theme:
  background: "$THEME_COLOR"
  foreground: "#ffffff"
  cursor: "#ffffff"
cursorStyle: block
commands:
  - command: "bash scripts/terminal_demo.sh"
    delay: 500
EOF

# Generate terminal demo script
cat > scripts/terminal_demo.sh <<'EOF'
#!/bin/bash

echo -e "\033[1;36m"
figlet -w 80 -f slant "Welcome!" | lolcat
echo -e "\033[1;34m"
echo "Hi there! I'm Thugger069"
echo "I'm passionate about coding and technology"
echo "Welcome to my GitHub profile!"
echo -e "\n\033[0;33m$(date '+%A, %B %d %Y %H:%M:%S %Z')\033[0m"
sleep 2
clear
neofetch --ascii_distro arch | lolcat
sleep 3
EOF

# Generate README
cat > README.md <<EOF
<!-- Dynamic Terminal -->
<div align="center">
  <img src="$GIF_URL" width="800"/>
</div>

<!-- Header -->
<h1 align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&size=30&duration=4000&color=$THEME_COLOR&center=true&width=600&lines=Hi+there!+I'm+$USERNAME;Full+Stack+Developer;Open+Source+Contributor;Tech+Enthusiast" alt="Typing Animation">
</h1>

<!-- Stats -->
<div align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=$USERNAME&show_icons=true&theme=dark&hide_border=true">
  <img src="https://github-readme-streak-stats.herokuapp.com?user=$USERNAME&theme=dark&hide_border=true">
</div>

## 🛠️ Tech Stack
<div align="center">
$(for tech in "${TECH_STACK[@]}"; do
  IFS='|' read -r name color logo <<< "$tech"
  echo "[![$name](https://img.shields.io/badge/-$name-$color?style=flat-square&logo=$logo&logoColor=white)]()"
done)
</div>

## 🌐 Connect with Me
<div align="center">
$(for link in "${SOCIAL_LINKS[@]}"; do
  IFS='|' read -r name url color <<< "$link"
  echo "[![$name](https://img.shields.io/badge/-$name-$color?style=for-the-badge&logo=$name&logoColor=white)]($url)"
done)
</div>

## 📈 Activity Graph
[![GitHub Activity Graph](https://github-readme-activity-graph.vercel.app/graph?username=$USERNAME&theme=react-dark&hide_border=true)](https://github.com/$USERNAME)

<div align="center">
  <img src="https://komarev.com/ghpvc/?username=$USERNAME&label=Profile+Views&color=$THEME_COLOR&style=flat-square">
</div>
EOF

# Set permissions
chmod +x scripts/terminal_demo.sh

echo "✅ Profile setup complete!"
echo "➡️ Review the generated files and push to GitHub"
