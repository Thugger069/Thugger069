#!/usr/bin/env bash
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
README_FILE="$REPO_ROOT/README.md"

echo "🜂 Q.R.I.P | Updating README… 🜁"

# Generate Cyberpunk Header
echo "🚀 Generating Cyberpunk header…"
node "$REPO_ROOT/scripts/generate-header.js"

# Generate Terminal Snake & Quantum Terminal SVG
echo "🐍 Generating Terminal Snake & Quantum SVG…"
node "$REPO_ROOT/scripts/generate-terminal-svg.js"

# GitHub stats & top languages
echo "📊 Fetching GitHub stats…"
mkdir -p "$REPO_ROOT/assets/stats"
curl -s "https://github-readme-stats.vercel.app/api?username=Thugger069&show_icons=true&theme=dark&hide_border=true&count_private=true" -o "$REPO_ROOT/assets/stats/github-stats.svg"
curl -s "https://github-readme-stats.vercel.app/api/top-langs/?username=Thugger069&layout=compact&theme=dark" -o "$REPO_ROOT/assets/stats/top-langs.svg"

# Preserve the rest of README content
if [[ -f "$README_FILE" ]]; then
  ORIGINAL_CONTENT="$(sed '/<!-- ULTIMATE CYBERPUNK HEADER START -->/,/<!-- ULTIMATE CYBERPUNK HEADER END -->/d' "$README_FILE")"
else
  ORIGINAL_CONTENT=""
fi

# Combine new header with preserved content
HEADER_CONTENT="$(cat "$REPO_ROOT/README.md" | sed '/<!-- ULTIMATE CYBERPUNK HEADER START -->/q')"
FINAL_CONTENT="<!-- ULTIMATE CYBERPUNK HEADER START -->\n$(cat "$REPO_ROOT/README.md")\n<!-- ULTIMATE CYBERPUNK HEADER END -->\n$ORIGINAL_CONTENT"

# Write final README
echo -e "$FINAL_CONTENT" > "$README_FILE"

echo "✨ README successfully updated with:"
echo "   🌌 Cyberpunk header"
echo "   🐍 Terminal Snake & Quantum SVG"
echo "   📊 GitHub stats & top languages"
echo "   📱 Footer with live timestamp & system status"
