#!/bin/bash

# Variables
REPO_NAME="Thugger069"
README_FILE="README.md"
WORKFLOW_DIR=".github/workflows"
ASSETS_DIR="assets"
WORKFLOW_FILE="$WORKFLOW_DIR/terminal.yml"

# Create directories
mkdir -p $WORKFLOW_DIR $ASSETS_DIR

# Generate README.md
cat << 'EOF' > $README_FILE
# Hi there! 👋 Welcome to my GitHub profile!

![Terminal Animation](./assets/terminal.gif)

I'm **Thugger069**!  
I'm passionate about **coding**, **technology**, and **building awesome projects**.  
Feel free to explore my repositories, contribute, or just say hello!  

---

## 🌟 About Me
- 🔭 Currently working on: `Open Source Contributions`
- 🌱 Learning: `Cloud Technologies`, `AI/ML`, and `Linux Administration`
- 💬 Ask me about: Anything tech-related!
- 📫 How to reach me: **[thugger069@example.com](mailto:thugger069@example.com)**

---

## 🚀 My Tech Stack
Here are some of the technologies I work with:

- **Languages:** Python, JavaScript, Bash
- **Tools & Frameworks:** React, Docker, GitHub Actions
- **Platforms:** Linux, AWS, Azure

---

## 📈 GitHub Stats
![GitHub Stats](https://github-readme-stats.vercel.app/api?username=Thugger069&show_icons=true&theme=tokyonight)  
![Top Languages](https://github-readme-stats.vercel.app/api/top-langs/?username=Thugger069&layout=compact&theme=tokyonight)

---

## 🔗 Let's Connect
- 🌐 **Portfolio:** [YourPortfolio.com](#)
- 🐦 **Twitter:** [@thugger069](https://twitter.com/thugger069)
- 💼 **LinkedIn:** [Thugger069](https://linkedin.com/in/thugger069)
EOF

# Create GitHub Actions Workflow
cat << 'EOF' > $WORKFLOW_FILE
name: Generate Terminal GIF

on:
  push:
    branches:
      - main

jobs:
  generate-gif:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Install dependencies
        run: |
          sudo apt update
          sudo apt install -y asciinema ffmpeg

      - name: Record terminal session
        run: |
          echo 'echo "Hi there! I am Thugger069!" && sleep 2' > script.sh
          chmod +x script.sh
          asciinema rec --quiet -c ./script.sh terminal.cast
          asciicast2gif -s 2 -t solarized-dark terminal.cast ./assets/terminal.gif

      - name: Commit GIF to repository
        run: |
          git config --global user.name "GitHub Action"
          git config --global user.email "actions@github.com"
          git add assets/terminal.gif
          git commit -m "Updated terminal GIF"
          git push
EOF

# Initialize git repository
git init
git add .
git commit -m "Initial commit"
echo "Repository initialized. Please push this to your GitHub repository."
