#!/bin/bash
# Updates the Cosmic Glitch Heaven README.md with dynamic content
# Preserves all aesthetic, styling, and structure while refreshing dynamic sections

set -e # Exit immediately if a command exits with a non-zero status.

# Ensure output directory exists for snake and other assets
mkdir -p assets
mkdir -p output
mkdir -p dist

# --- Configuration & Secrets (Read from Environment) ---
GH_USERNAME="${GH_USERNAME:-Thugger069}"
GH_TOKEN="${GH_TOKEN}"
DEVTO_USERNAME="${SECRET_DEVTO_USERNAME}"
LINKEDIN_URL="${SECRET_LINKEDIN_URL}"
TWITTER_HANDLE="${SECRET_TWITTER_HANDLE}"
EMAIL_ADDRESS="${SECRET_EMAIL_ADDRESS}"
WAKATIME_USERNAME="${SECRET_WAKATIME_USERNAME}"

README_FILE="README.md"
TEMP_FILE=$(mktemp)

# --- Dynamic Variables ---
CURRENT_DATE=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
CURRENT_YEAR=$(date -u +"%Y")

# Check if README exists
if [ ! -f "$README_FILE" ]; then
    echo "❌ README.md not found!"
    exit 1
fi

echo "🔄 Updating Cosmic Glitch Heaven README..."

# Copy original README to temp file
cp "$README_FILE" "$TEMP_FILE"

# --- Function: Generate Dynamic "Currently Working On" Content ---
generate_current_work_content() {
    STATUS_MESSAGES=(
        "* <span style=\"color:#00FFFF\">S</span><span style=\"color:#FF00FF\">m</span>%<span style=\"color:#FFFFFF\">o</span><span style=\"color:#00FFFF\">o</span><span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">h</span> <span style=\"color:#00FFFF\">O</span><span style=\"color:#FF00FF\">p</span>%<span style=\"color:#FFFFFF\">r</span><span style=\"color:#00FFFF\">a</span><span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">o</span><span style=\"color:#00FFFF\">r</span> — <span style=\"color:#FF00FF\">S</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FFFFFF\">r</span><span style=\"color:#00FFFF\">i</span>-<span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">r</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">g</span><span style=\"color:#FFFFFF\">g</span><span style=\"color:#00FFFF\">e</span><span style=\"color:#FF00FF\">r</span><span style=\"color:#FFFFFF\">e</span><span style=\"color:#00FFFF\">d</span> <span style=\"color:#FF00FF\">r</span><span style=\"color:#00FFFF\">e</span><span style=\"color:#FFFFFF\">p</span>%<span style=\"color:#00FFFF\">l</span> <span style=\"color:#FF00FF\">e</span><span style=\"color:#00FFFF\">n</span><span style=\"color:#FFFFFF\">g</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">n</span><span style=\"color:#FFFFFF\">e</span></p>"
        "* <span style=\"color:#FF00FF\">Q</span><span style=\"color:#00FFFF\">u</span><span style=\"color:#FFFFFF\">a</span><span style=\"color:#00FFFF\">n</span><span style=\"color:#FF00FF\">t</span>%<span style=\"color:#FFFFFF\">m</span> <span style=\"color:#00FFFF\">A</span><span style=\"color:#FF00FF\">u</span><span style=\"color:#FFFFFF\">t</span><span style=\"color:#00FFFF\">o</span><span style=\"color:#FF00FF\">p</span>%<span style=\"color:#FFFFFF\">l</span><span style=\"color:#00FFFF\">o</span><span style=\"color:#FF00FF\">t</span> — <span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">O</span><span style=\"color:#FFFFFF\">S</span> <span style=\"color:#00FFFF\">1</span><span style=\"color:#FF00FF\">8</span> <span style=\"color:#FFFFFF\">a</span><span style=\"color:#00FFFF\">u</span><span style=\"color:#FF00FF\">t</span>%<span style=\"color:#FFFFFF\">m</span><span style=\"color:#00FFFF\">a</span><span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">o</span><span style=\"color:#FF00FF\">n</span></p>"
        "* <span style=\"color:#00FFFF\">E</span><span style=\"color:#FF00FF\">n</span><span style=\"color:#FFFFFF\">h</span><span style=\"color:#00FFFF\">a</span><span style=\"color:#FF00FF\">n</span><span style=\"color:#FFFFFF\">c</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">n</span><span style=\"color:#FFFFFF\">g</span> <span style=\"color:#FF00FF\">R</span><span style=\"color:#00FFFF\">E</span><span style=\"color:#FFFFFF\">A</span><span style=\"color:#00FFFF\">D</span><span style=\"color:#FF00FF\">M</span><span style=\"color:#FFFFFF\">E</span> <span style=\"color:#00FFFF\">w</span><span style=\"color:#FF00FF\">i</span><span style=\"color:#FFFFFF\">t</span><span style=\"color:#00FFFF\">h</span> <span style=\"color:#FF00FF\">d</span><span style=\"color:#00FFFF\">y</span><span style=\"color:#FFFFFF\">n</span><span style=\"color:#00FFFF\">a</span><span style=\"color:#FF00FF\">m</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">c</span> <span style=\"color:#FF00FF\">c</span>%<span style=\"color:#FFFFFF\">n</span><span style=\"color:#00FFFF\">t</span><span style=\"color:#FF00FF\">e</span><span style=\"color:#FFFFFF\">n</span><span style=\"color:#00FFFF\">t</span></p>"
        "* <span style=\"color:#00FFFF\">B</span><span style=\"color:#FF00FF\">u</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">l</span><span style=\"color:#FF00FF\">d</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">n</span><span style=\"color:#FF00FF\">g</span> <span style=\"color:#FF00FF\">a</span><span style=\"color:#00FFFF\">u</span><span style=\"color:#FFFFFF\">d</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">a</span><span style=\"color:#00FFFF\">b</span><span style=\"color:#FF00FF\">l</span><span style=\"color:#FFFFFF\">e</span> <span style=\"color:#FF00FF\">A</span><span style=\"color:#00FFFF\">I</span> <span style=\"color:#FFFFFF\">s</span><span style=\"color:#00FFFF\">y</span><span style=\"color:#FF00FF\">s</span><span style=\"color:#FFFFFF\">t</span>%<span style=\"color:#00FFFF\">m</span><span style=\"color:#FF00FF\">s</span></p>"
        "* <span style=\"color:#FF00FF\">E</span><span style=\"color:#00FFFF\">x</span><span style=\"color:#FFFFFF\">p</span><span style=\"color:#00FFFF\">l</span><span style=\"color:#FF00FF\">o</span><span style=\"color:#FFFFFF\">r</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">n</span><span style=\"color:#FFFFFF\">g</span> <span style=\"color:#00FFFF\">c</span><span style=\"color:#FF00FF\">o</span><span style=\"color:#FFFFFF\">s</span><span style=\"color:#00FFFF\">m</span><span style=\"color:#FF00FF\">i</span><span style=\"color:#FFFFFF\">c</span> <span style=\"color:#FF00FF\">g</span><span style=\"color:#00FFFF\">l</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">t</span><span style=\"color:#FF00FF\">c</span><span style=\"color:#FFFFFF\">h</span> <span style=\"color:#00FFFF\">a</span><span style=\"color:#FF00FF\">e</span><span style=\"color:#FFFFFF\">s</span><span style=\"color:#00FFFF\">t</span><span style=\"color:#FF00FF\">h</span><span style=\"color:#FFFFFF\">e</span><span style=\"color:#00FFFF\">t</span><span style=\"color:#FF00FF\">i</span><span style=\"color:#FFFFFF\">c</span><span style=\"color:#00FFFF\">s</span></p>"
        "* <span style=\"color:#00FFFF\">O</span><span style=\"color:#FF00FF\">p</span><span style=\"color:#FFFFFF\">t</span><span style=\"color:#00FFFF\">i</span><span style=\"color:#FF00FF\">m</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">z</span><span style=\"color:#FF00FF\">i</span><span style=\"color:#FFFFFF\">n</span><span style=\"color:#00FFFF\">g</span> <span style=\"color:#FF00FF\">q</span><span style=\"color:#00FFFF\">u</span><span style=\"color:#FFFFFF\">a</span><span style=\"color:#00FFFF\">n</span><span style=\"color:#FF00FF\">t</span><span style=\"color:#FFFFFF\">u</span><span style=\"color:#00FFFF\">m</span> <span style=\"color:#FF00FF\">w</span><span style=\"color:#00FFFF\">o</span><span style=\"color:#FFFFFF\">r</span><span style=\"color:#00FFFF\">k</span><span style=\"color:#FF00FF\">f</span><span style=\"color:#FFFFFF\">l</span><span style=\"color:#00FFFF\">o</span><span style=\"color:#FF00FF\">w</span><span style=\"color:#FFFFFF\">s</span></p>"
        "* <span style=\"color:#FF00FF\">S</span><span style=\"color:#00FFFF\">h</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">p</span><span style=\"color:#FF00FF\">p</span><span style=\"color:#FFFFFF\">i</span><span style=\"color:#00FFFF\">n</span><span style=\"color:#FF00FF\">g</span> <span style=\"color:#00FFFF\">n</span><span style=\"color:#FF00FF\">e</span><span style=\"color:#FFFFFF\">w</span> <span style=\"color:#00FFFF\">f</span><span style=\"color:#FF00FF\">e</span><span style=\"color:#FFFFFF\">a</span><span style=\"color:#00FFFF\">t</span><span style=\"color:#FF00FF\">u</span><span style=\"color:#FFFFFF\">r</span><span style=\"color:#00FFFF\">e</span><span style=\"color:#FF00FF\">s</span> <span style=\"color:#00FFFF\">t</span><span style=\"color:#FF00FF\">o</span> <span style=\"color:#FFFFFF\">s</span><span style=\"color:#00FFFF\">h</span><span style=\"color:#FF00FF\">a</span><span style=\"color:#FFFFFF\">d</span>%<span style=\"color:#00FFFF\">w</span>-<span style=\"color:#FF00FF\">s</span><span style=\"color:#FFFFFF\">c</span><span style=\"color:#00FFFF\">r</span>%<span style=\"color:#FF00FF\">p</span><span style=\"color:#FFFFFF\">t</span><span style=\"color:#00FFFF\">s</span></p>"
    )
    
    # Select 2-3 random messages
    NUM_ITEMS=$((2 + RANDOM % 2))  # 2 or 3 items
    SELECTED_INDICES=()
    
    for i in $(seq 1 $NUM_ITEMS); do
        while true; do
            idx=$((RANDOM % ${#STATUS_MESSAGES[@]}))
            if [[ ! " ${SELECTED_INDICES[@]} " =~ " ${idx} " ]]; then
                SELECTED_INDICES+=($idx)
                break
            fi
        done
    done
    
    echo "  <blockquote>"
    for idx in "${SELECTED_INDICES[@]}"; do
        echo "    <p>${STATUS_MESSAGES[$idx]}"
    done
    echo "  </blockquote>"
}

# --- Update GitHub Stats URLs ---
echo "📊 Updating GitHub stats URLs..."
sed -i "s/username=Thugger069/username=${GH_USERNAME}/g" "$TEMP_FILE"
sed -i "s/user=Thugger069/user=${GH_USERNAME}/g" "$TEMP_FILE"
sed -i "s/?user=Thugger069/?user=${GH_USERNAME}/g" "$TEMP_FILE"

# --- Update Email Address ---
if [ -n "$EMAIL_ADDRESS" ]; then
    echo "📧 Updating email address..."
    sed -i "s|mailto:your\.email@example\.com|mailto:${EMAIL_ADDRESS}|g" "$TEMP_FILE"
    sed -i "s|your\.email@example\.com|${EMAIL_ADDRESS}|g" "$TEMP_FILE"
fi

# --- Update Social Links ---
if [ -n "$LINKEDIN_URL" ]; then
    echo "💼 Updating LinkedIn URL..."
    sed -i "s|https://linkedin.com/in/thugger069|${LINKEDIN_URL}|g" "$TEMP_FILE"
fi

if [ -n "$TWITTER_HANDLE" ]; then
    echo "🐦 Updating Twitter handle..."
    sed -i "s|https://twitter.com/chuksgincaro|https://twitter.com/${TWITTER_HANDLE}|g" "$TEMP_FILE"
fi

# --- Update Dynamic "Currently Working On" Section ---
if grep -q "DYNAMIC_CURRENT_WORK:START" "$TEMP_FILE"; then
    echo "⚡ Updating 'Currently Working On' section..."
    
    # Create temporary file with new content
    NEW_CONTENT_FILE=$(mktemp)
    generate_current_work_content > "$NEW_CONTENT_FILE"
    
    # Use awk to replace content between markers
    awk -v new_content_file="$NEW_CONTENT_FILE" '
    BEGIN {
        # Read new content into array
        while ((getline line < new_content_file) > 0) {
            new_lines[++n] = line
        }
        close(new_content_file)
    }
    /DYNAMIC_CURRENT_WORK:START/ {
        print
        getline
        # Skip old content until END marker
        while (!/DYNAMIC_CURRENT_WORK:END/) {
            getline
        }
        # Print new content
        for (i = 1; i <= n; i++) {
            print new_lines[i]
        }
        print "  <!-- DYNAMIC_CURRENT_WORK:END -->"
        next
    }
    { print }
    ' "$TEMP_FILE" > "${TEMP_FILE}.tmp" && mv "${TEMP_FILE}.tmp" "$TEMP_FILE"
    
    rm -f "$NEW_CONTENT_FILE"
fi

# --- Update Snake Animation Paths ---
echo "🐍 Updating snake animation paths..."
sed -i "s|dist/github-snake|output/github-snake|g" "$TEMP_FILE" || true

# --- Update Footer Timestamp ---
if grep -q "Timestamp.*∞" "$TEMP_FILE"; then
    echo "🕐 Updating timestamp..."
    sed -i "s|\[Timestamp\]: ∞|\[Timestamp\]: ${CURRENT_DATE}|g" "$TEMP_FILE" || true
fi

# --- Replace original README with updated version ---
mv "$TEMP_FILE" "$README_FILE"

echo "✅ README.md successfully updated with dynamic content!"
echo "   - GitHub stats: Updated for ${GH_USERNAME}"
if [ -n "$EMAIL_ADDRESS" ]; then
    echo "   - Email: Updated to ${EMAIL_ADDRESS}"
fi
if [ -n "$LINKEDIN_URL" ]; then
    echo "   - LinkedIn: Updated"
fi
if [ -n "$TWITTER_HANDLE" ]; then
    echo "   - Twitter: Updated to @${TWITTER_HANDLE}"
fi
echo "   - Currently Working On: Refreshed"
echo "   - Timestamp: ${CURRENT_DATE}"
