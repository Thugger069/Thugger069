#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$REPO_ROOT/dist"
README_FILE="$REPO_ROOT/README.md"

log_info() { echo -e "🔹 $1"; }

# 1️⃣ Terminal SVGs
log_info "Generating terminal SVGs..."
node "$REPO_ROOT/scripts/generate-terminal-svg.js"
log_info "✅ Terminal SVGs updated."

# 2️⃣ Quantum Header
log_info "Generating Quantum Cyberpunk Header..."
node "$REPO_ROOT/scripts/generate-header.js"
log_info "✅ Quantum Header updated."

# 3️⃣ Particle effects
if [ -f "$REPO_ROOT/scripts/generate_particles.js" ]; then
    log_info "Generating particle effects..."
    node "$REPO_ROOT/scripts/generate_particles.js"
    log_info "✅ Particle SVG updated."
fi

# 4️⃣ Update README terminal block
log_info "Updating README terminal section..."
if [ ! -f "$README_FILE" ]; then
    echo "<!-- Auto-generated README -->" > "$README_FILE"
fi

TERMINAL_SVG_DARK="dist/terminal.svg"
TERMINAL_SVG_LIGHT="dist/terminal-light.svg"

# Remove old terminal block
sed -i '/<!-- Terminal Start -->/,/<!-- Terminal End -->/d' "$README_FILE"

# Append terminal block
printf '\n<!-- Terminal Start -->\n<p align="center">\n<picture>\n<source media="(prefers-color-scheme: dark)" srcset="%s" />\n<source media="(prefers-color-scheme: light)" srcset="%s" />\n<img alt="Terminal Display" src="%s" width="100%%" style="border-radius: 10px;" />\n</picture>\n</p>\n<!-- Terminal End -->\n' "$TERMINAL_SVG_DARK" "$TERMINAL_SVG_LIGHT" "$TERMINAL_SVG_LIGHT" >> "$README_FILE"

log_info "✅ README terminal section updated."

# 5️⃣ Commit & Push
git config --local user.name "Thugger069"
git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"

git add -f "$README_FILE" "$DIST_DIR"
if git diff --cached --quiet; then
    log_info "⏭️ No changes to commit."
else
    COMMIT_MSG="🔄 Update terminal & quantum header ($(date -u +'%Y-%m-%d %H:%M:%S UTC'))"
    git commit -m "$COMMIT_MSG"
    git push
    log_info "✅ Changes committed and pushed."
fi

log_info "🎯 update-terminal.sh completed successfully!"
