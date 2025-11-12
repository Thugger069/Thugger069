#!/bin/bash
# Updates ONLY dynamic content sections in README.md without replacing the entire file
# Preserves the Cosmic Glitch Heaven aesthetic

set -e

README_FILE="README.md"
GH_USERNAME="${GH_USERNAME:-Thugger069}"
GH_TOKEN="${GH_TOKEN}"
DEVTO_USERNAME="${SECRET_DEVTO_USERNAME}"
WAKATIME_USERNAME="${SECRET_WAKATIME_USERNAME}"

# Generate dynamic "Currently Working On" content
generate_current_work() {
    STATUS_MESSAGES=(
        "* <span style=\"color:#00FFFF\">S</span><span style=\"color:#FF00FF\">m</span>%<span style=\"color:#FFFFFF\">o</span><span style=\"color:#00FFFF\">o</span><span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">h</span> <span style=\"color:#00FFFF\">O</span><span style=\"color:#FF00FF\">p</span>%<span style=\"color:#FFFFFF\">r</span><span style=\"color:#00FFFF\">a</span><span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">o</span><span style=\"color:#00FFFF\">r</span> — <span style=\"color:#FF00FF\">S</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FFFFFF\">r</span><span style=\"color:#00FFFF\">i</span>-<span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">r</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">g</span><span style=\"color:#FFFFFF\">g</span><span style=\"color:#00FFFF\">e</span><span style=\"color:#FF00FF\">r</span><span style=\"color:#FFFFFF\">e</span><span style=\"color:#00FFFF\">d</span> <span style=\"color:#FF00FF\">r</span><span style=\"color:#00FFFF\">e</span><span style=\"color:#FFFFFF\">p</span>%<span style=\"color:#00FFFF\">l</span> <span style=\"color:#FF00FF\">e</span><span style=\"color:#00FFFF\">n</span><span style=\"color:#FFFFFF\">g</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">n</span><span style=\"color:#FFFFFF\">e</span></p>"
        "* <span style=\"color:#FF00FF\">Q</span><span style=\"color:#00FFFF\">u</span><span style=\"color:#FFFFFF\">a</span><span style=\"color:#00FFFF\">n</span><span style=\"color:#FF00FF\">t</span>%<span style=\"color:#FFFFFF\">m</span> <span style=\"color:#00FFFF\">A</span><span style=\"color:#FF00FF\">u</span><span style=\"color:#FFFFFF\">t</span><span style=\"color:#00FFFF\">o</span><span style=\"color:#FF00FF\">p</span>%<span style=\"color:#FFFFFF\">l</span><span style=\"color:#00FFFF\">o</span><span style=\"color:#FF00FF\">t</span> — <span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">O</span><span style=\"color:#FFFFFF\">S</span> <span style=\"color:#00FFFF\">1</span><span style=\"color:#FF00FF\">8</span> <span style=\"color:#FFFFFF\">a</span><span style=\"color:#00FFFF\">u</span><span style=\"color:#FF00FF\">t</span>%<span style=\"color:#FFFFFF\">m</span><span style=\"color:#00FFFF\">a</span><span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">o</span><span style=\"color:#FF00FF\">n</span></p>"
        "* <span style=\"color:#00FFFF\">E</span><span style=\"color:#FF00FF\">n</span><span style=\"color:#FFFFFF\">h</span><span style=\"color:#00FFFF\">a</span><span style=\"color:#FF00FF\">n</span><span style=\"color:#FFFFFF\">c</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">n</span><span style=\"color:#FFFFFF\">g</span> <span style=\"color:#FF00FF\">R</span><span style=\"color:#00FFFF\">E</span><span style=\"color:#FFFFFF\">A</span><span style=\"color:#00FFFF\">D</span><span style=\"color:#FF00FF\">M</span><span style=\"color:#FFFFFF\">E</span> <span style=\"color:#00FFFF\">w</span><span style=\"color:#FF00FF\">i</span><span style=\"color:#FFFFFF\">t</span><span style=\"color:#00FFFF\">h</span> <span style=\"color:#FF00FF\">d</span><span style=\"color:#00FFFF\">y</span><span style=\"color:#FFFFFF\">n</span><span style=\"color:#00FFFF\">a</span><span style=\"color:#FF00FF\">m</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">c</span> <span style=\"color:#FF00FF\">c</span>%<span style=\"color:#FFFFFF\">n</span><span style=\"color:#00FFFF\">t</span><span style=\"color:#FF00FF\">e</span><span style=\"color:#FFFFFF\">n</span><span style=\"color:#00FFFF\">t</span></p>"
        "* <span style=\"color:#00FFFF\">B</span><span style=\"color:#FF00FF\">u</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">l</span><span style=\"color:#FF00FF\">d</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">n</span><span style=\"color:#FF00FF\">g</span> <span style=\"color:#FF00FF\">a</span><span style=\"color:#00FFFF\">u</span><span style=\"color:#FFFFFF\">d</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">a</span><span style=\"color:#00FFFF\">b</span><span style=\"color:#FF00FF\">l</span><span style=\"color:#FFFFFF\">e</span> <span style=\"color:#FF00FF\">A</span><span style=\"color:#00FFFF\">I</span> <span style=\"color:#FFFFFF\">s</span><span style=\"color:#00FFFF\">y</span><span style=\"color:#FF00FF\">s</span><span style=\"color:#FFFFFF\">t</span>%<span style=\"color:#00FFFF\">m</span><span style=\"color:#FF00FF\">s</span></p>"
        "* <span style=\"color:#FF00FF\">E</span><span style=\"color:#00FFFF\">x</span><span style=\"color:#FFFFFF\">p</span><span style=\"color:#00FFFF\">l</span><span style=\"color:#FF00FF\">o</span><span style=\"color:#FFFFFF\">r</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">n</span><span style=\"color:#FFFFFF\">g</span> <span style=\"color:#00FFFF\">c</span><span style=\"color:#FF00FF\">o</span><span style=\"color:#FFFFFF\">s</span><span style=\"color:#00FFFF\">m</span><span style=\"color:#FF00FF\">i</span><span style=\"color:#FFFFFF\">c</span> <span style=\"color:#FF00FF\">g</span><span style=\"color:#00FFFF\">l</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">t</span><span style=\"color:#FF00FF\">c</span><span style=\"color:#FFFFFF\">h</span> <span style=\"color:#00FFFF\">a</span><span style=\"color:#FF00FF\">e</span><span style=\"color:#FFFFFF\">s</span><span style=\"color:#00FFFF\">t</span><span style=\"color:#FF00FF\">h</span><span style=\"color:#FFFFFF\">e</span><span style=\"color:#00FFFF\">t</span><span style=\"color:#FF00FF\">i</span><span style=\"color:#FFFFFF\">c</span><span style=\"color:#00FFFF\">s</span></p>"
    )
    
    RANDOM_INDEX=$(( RANDOM % ${#STATUS_MESSAGES[@]} ))
    SELECTED_MESSAGE="${STATUS_MESSAGES[$RANDOM_INDEX]}"
    
    echo "  <blockquote>"
    echo "    <p>${SELECTED_MESSAGE}"
    # Add 1-2 more random items
    for i in {1..2}; do
        RANDOM_INDEX=$(( RANDOM % ${#STATUS_MESSAGES[@]} ))
        echo "    <p>${STATUS_MESSAGES[$RANDOM_INDEX]}"
    done
    echo "  </blockquote>"
}

# Get recent GitHub activity (if token available)
get_recent_activity() {
    if [ -z "$GH_TOKEN" ] || [ -z "$GH_USERNAME" ]; then
        return
    fi
    
    # Could fetch recent commits, PRs, etc.
    # For now, just return empty
    echo ""
}

# Update the DYNAMIC_CURRENT_WORK section
if [ -f "$README_FILE" ]; then
    # Create temp file
    TEMP_FILE=$(mktemp)
    
    # Check if placeholders exist
    if grep -q "DYNAMIC_CURRENT_WORK:START" "$README_FILE"; then
        # Extract content before START marker
        sed -n '1,/DYNAMIC_CURRENT_WORK:START/p' "$README_FILE" | head -n -1 > "$TEMP_FILE"
        
        # Add START marker
        echo "  <!-- DYNAMIC_CURRENT_WORK:START -->" >> "$TEMP_FILE"
        
        # Add dynamic content
        generate_current_work >> "$TEMP_FILE"
        
        # Add END marker
        echo "  <!-- DYNAMIC_CURRENT_WORK:END -->" >> "$TEMP_FILE"
        
        # Extract content after END marker
        sed -n '/DYNAMIC_CURRENT_WORK:END/,$p' "$README_FILE" | tail -n +2 >> "$TEMP_FILE"
        
        # Replace original file
        mv "$TEMP_FILE" "$README_FILE"
        echo "✅ Updated DYNAMIC_CURRENT_WORK section in README.md"
    else
        echo "⚠️  DYNAMIC_CURRENT_WORK placeholders not found in README.md"
        rm -f "$TEMP_FILE"
    fi
else
    echo "❌ README.md not found"
    exit 1
fi
