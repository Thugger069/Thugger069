#!/usr/bin/env bash
set -euo pipefail

#──────────────────────────────
# 🜂 Lysergic Quantum README Updater
#──────────────────────────────

AUTHOR="𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ"
DISPLAY_NAME="ɬɧɛ ɠıɬƈɧ"
GITHUB_USERNAME="Thugger069"

README_FILE="README.md"
DIST_DIR="dist"
SNAKE_DARK="$DIST_DIR/github-snake-dark.svg"
SNAKE_LIGHT="$DIST_DIR/github-snake.svg"

log_info() {
    echo "ℹ️ $1"
}

#──────────────────────────────
# Ensure directories
mkdir -p "$DIST_DIR"

#──────────────────────────────
# Terminal SVGs
if [ -f "scripts/generate-terminal-svg.js" ]; then
    log_info "Generating terminal SVGs..."
    node scripts/generate-terminal-svg.js
else
    log_info "SVG generator missing, skipping SVG generation."
fi

#──────────────────────────────
# README base
if [ ! -f "$README_FILE" ]; then
    log_info "README.md not found, creating base file..."
    cat > "$README_FILE" << EOF
<div align="center">
  <h1>👨‍💻 $DISPLAY_NAME</h1>
  <h3>DevOps Engineer & Open Source Enthusiast</h3>
</div>
EOF
fi

#──────────────────────────────
# Terminal Section
if ! grep -q "<!-- Terminal Section -->" "$README_FILE"; then
    log_info "Adding terminal section..."
    CURRENT_TIME=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
    cat >> "$README_FILE" << EOF

<!-- Terminal Section -->
<div align="center">
  <h2>🎮 Live Terminal</h2>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="$DIST_DIR/terminal.svg">
    <source media="(prefers-color-scheme: light)" srcset="$DIST_DIR/terminal-light.svg">
    <img src="$DIST_DIR/terminal.svg" alt="Live Terminal Output" width="100%" style="border-radius: 10px; border: 1px solid #2a2b3a; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
  </picture>
  <br>
  <sub><em>Last updated: $CURRENT_TIME</em></sub>
</div>
<!-- End Terminal Section -->
EOF
fi

#──────────────────────────────
# Tech Stack
if ! grep -q "<!-- Tech Stack -->" "$README_FILE"; then
    log_info "Adding tech stack section..."
    cat >> "$README_FILE" << 'EOF'

<!-- Tech Stack -->
<h2>🛠️ Tech Stack</h2>
<p align="center">
  <img src="https://skillicons.dev/icons?i=linux,docker,kubernetes,aws,bash,python,go,terraform,prometheus,grafana,git,github,gitlab,vscode&perline=7" alt="Tech Stack" />
</p>
EOF
fi

#──────────────────────────────
# GitHub Stats
if ! grep -q "<!-- GitHub Stats -->" "$README_FILE"; then
    log_info "Adding GitHub stats section..."
    cat >> "$README_FILE" << EOF

<!-- GitHub Stats -->
<h2>📊 GitHub Analytics</h2>
<p align="center">
  <img height="165" src="https://github-readme-stats.vercel.app/api?username=$GITHUB_USERNAME&show_icons=true&theme=radical&hide_border=true&bg_color=1a1b26&title_color=7dcfff&icon_color=bb9af7&text_color=c0caf5" />
  <img height="165" src="https://github-readme-stats.vercel.app/api/top-langs/?username=$GITHUB_USERNAME&layout=compact&theme=radical&hide_border=true&bg_color=1a1b26&title_color=7dcfff&text_color=c0caf5" />
</p>

<p align="center">
  <img src="https://github-readme-streak-stats.herokuapp.com/?user=$GITHUB_USERNAME&theme=radical&hide_border=true&background=1a1b26&ring=7dcfff&fire=7dcfff&currStreakLabel=7dcfff" />
</p>
EOF
fi

#──────────────────────────────
# GitHub Snake
if ! grep -q "<!-- GitHub Snake -->" "$README_FILE"; then
    log_info "Adding GitHub snake section..."
    cat >> "$README_FILE" << EOF

<!-- GitHub Snake -->
<h2>🐍 GitHub Contributions</h2>
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="$SNAKE_DARK" />
    <source media="(prefers-color-scheme: light)" srcset="$SNAKE_LIGHT" />
    <img alt="GitHub Contribution Snake" src="$SNAKE_LIGHT" width="100%" style="border-radius: 10px;" />
  </picture>
  <br>
  <sub><em>My contribution graph eating my contributions 🐍</em></sub>
</p>
EOF
fi

#──────────────────────────────
# Footer
if ! grep -q "^</div>" "$README_FILE"; then
    CURRENT_TIME=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
    cat >> "$README_FILE" << EOF

<!-- Footer -->
<br>
<div align="center">
  <sub>⚡ <b>Last Updated:</b> $CURRENT_TIME | 🎯 <b>Always learning, always deploying</b></sub>
  <br>
  <sub>Automatically updated via GitHub Actions</sub>
</div>
</div>
EOF
fi

#──────────────────────────────
# Commit & Push Changes
log_info "Checking for changes..."
git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
git config --local user.name "Thugger069"

git add .
if git diff --cached --quiet; then
    log_info "No changes to commit."
else
    COMMIT_MSG="🔄 Update terminal display + README sections ($(date -u +'%Y-%m-%d %H:%M:%S UTC'))"
    git commit -m "$COMMIT_MSG"
    git push
    log_info "✅ Changes committed and pushed."
fi

log_info "🜂 README update workflow complete!"