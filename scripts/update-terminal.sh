#!/bin/bash
set -e

# Enhanced terminal update script
# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
RESET='\033[0m'

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DIST_DIR="$REPO_ROOT/dist"
SCRIPTS_DIR="$REPO_ROOT/scripts"

# Username configuration
DISPLAY_NAME="ɬɧɛ ɠıɬƈɧ"
GITHUB_USERNAME="Thugger069"

# Logging functions
log_info() { echo -e "${BLUE}ℹ️  INFO:${RESET} $1"; }
log_success() { echo -e "${GREEN}✅ SUCCESS:${RESET} $1"; }
log_warning() { echo -e "${YELLOW}⚠️  WARNING:${RESET} $1"; }
log_error() { echo -e "${RED}❌ ERROR:${RESET} $1"; }

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    if ! command -v node &> /dev/null; then
        log_error "Node.js is required but not installed."
        exit 1
    fi
    
    if [[ ! -f "$SCRIPTS_DIR/generate-terminal-svg.js" ]]; then
        log_error "SVG generator script not found: $SCRIPTS_DIR/generate-terminal-svg.js"
        exit 1
    fi
    
    log_success "All prerequisites are satisfied"
}

# Create directories
create_directories() {
    log_info "Creating necessary directories..."
    
    for dir in "$DIST_DIR" "$SCRIPTS_DIR"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
            log_success "Created directory: $dir"
        fi
    done
}

# Generate terminal SVG
generate_terminal_svg() {
    log_info "Generating terminal SVG files..."
    
    if node "$SCRIPTS_DIR/generate-terminal-svg.js"; then
        log_success "Terminal SVG files generated successfully"
        
        # Verify files
        for file in "$DIST_DIR/terminal.svg" "$DIST_DIR/terminal-light.svg"; do
            if [[ -f "$file" ]]; then
                local size=$(du -h "$file" 2>/dev/null | cut -f1 || echo "unknown")
                log_info "  📄 $(basename "$file") ($size)"
            else
                log_warning "File not found: $file"
            fi
        done
        return 0
    else
        log_error "Failed to generate terminal SVG files"
        return 1
    fi
}

# Create basic README if missing
create_basic_readme() {
    local readme_file="$REPO_ROOT/README.md"
    
    cat > "$readme_file" << 'EOF'
<div align="center">
  <h1>👨‍💻 ɬɧɛ ɠıɬƈɧ</h1>
  <h3>DevOps Engineer & Open Source Enthusiast</h3>

  <p align="center">
    <a href="https://github.com/Thugger069">
      <img src="https://komarev.com/ghpvc/?username=Thugger069&color=blueviolet&style=for-the-badge" alt="Profile Views" />
    </a>
    <a href="https://github.com/Thugger069?tab=followers">
      <img src="https://img.shields.io/github/followers/Thugger069?color=green&logo=github&style=for-the-badge" alt="GitHub Followers" />
    </a>
  </p>
EOF
}

# Update README with terminal section
update_readme() {
    log_info "Updating README.md..."
    
    local readme_file="$REPO_ROOT/README.md"
    local current_time=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
    
    # Create README if it doesn't exist
    if [[ ! -f "$readme_file" ]]; then
        log_warning "README.md not found, creating basic structure..."
        create_basic_readme
    fi
    
    # Terminal section
    local terminal_section="<!-- Terminal Section -->
<div align=\"center\">
  <h2>🎮 Live Terminal</h2>
  <picture>
    <source media=\"(prefers-color-scheme: dark)\" srcset=\"dist/terminal.svg\">
    <source media=\"(prefers-color-scheme: light)\" srcset=\"dist/terminal-light.svg\">
    <img src=\"dist/terminal.svg\" alt=\"Live Terminal Output\" width=\"100%\" style=\"border-radius: 10px; border: 1px solid #2a2b3a; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);\">
  </picture>
  <br>
  <sub><em>Last updated: $current_time</em></sub>
</div>
<!-- End Terminal Section -->"
    
    # Update or add terminal section
    if grep -q "<!-- Terminal Section -->" "$readme_file"; then
        log_info "Updating existing terminal section..."
        
        # Create temp files for processing
        local temp_file=$(mktemp)
        
        awk -v new_section="$terminal_section" '
            /<!-- Terminal Section -->/ { found=1; print new_section; next }
            /<!-- End Terminal Section -->/ { found=0; next }
            !found { print }
        ' "$readme_file" > "$temp_file"
        
        mv "$temp_file" "$readme_file"
    else
        log_info "Adding new terminal section..."
        echo "" >> "$readme_file"
        echo "$terminal_section" >> "$readme_file"
    fi
    
    # Add other sections if missing
    add_missing_sections
    
    log_success "README.md updated successfully"
}

# Add missing sections to README
add_missing_sections() {
    local readme_file="$REPO_ROOT/README.md"
    local snake_dark="https://raw.githubusercontent.com/Thugger069/Thugger069/main/dist/github-snake-dark.svg"
    local snake_light="https://raw.githubusercontent.com/Thugger069/Thugger069/main/dist/github-snake.svg"
    
    # Tech Stack
    if ! grep -q "<!-- Tech Stack -->" "$readme_file"; then
        log_info "Adding tech stack section..."
        cat >> "$readme_file" << 'EOF'

  <!-- Tech Stack -->
  <h2>🛠️ Tech Stack</h2>
  <p align="center">
    <img src="https://skillicons.dev/icons?i=linux,docker,kubernetes,aws,bash,python,go,terraform,prometheus,grafana,git,github,gitlab,vscode&perline=7" alt="Tech Stack" />
  </p>
EOF
    fi
    
    # GitHub Stats
    if ! grep -q "<!-- GitHub Stats -->" "$readme_file"; then
        log_info "Adding GitHub stats section..."
        cat >> "$readme_file" << 'EOF'

  <!-- GitHub Stats -->
  <h2>📊 GitHub Analytics</h2>
  <p align="center">
    <img height="165" src="https://github-readme-stats.vercel.app/api?username=Thugger069&show_icons=true&theme=radical&hide_border=true&bg_color=1a1b26&title_color=7dcfff&icon_color=bb9af7&text_color=c0caf5" />
    <img height="165" src="https://github-readme-stats.vercel.app/api/top-langs/?username=Thugger069&layout=compact&theme=radical&hide_border=true&bg_color=1a1b26&title_color=7dcfff&text_color=c0caf5" />
  </p>
  
  <p align="center">
    <img src="https://github-readme-streak-stats.herokuapp.com/?user=Thugger069&theme=radical&hide_border=true&background=1a1b26&ring=7dcfff&fire=7dcfff&currStreakLabel=7dcfff" />
  </p>
EOF
    fi
    
    # GitHub Snake
    if ! grep -q "<!-- GitHub Snake -->" "$readme_file"; then
        log_info "Adding GitHub snake section..."
        cat >> "$readme_file" << EOF

  <!-- GitHub Snake -->
  <h2>🐍 GitHub Contributions</h2>
  <p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="$snake_dark" />
      <source media="(prefers-color-scheme: light)" srcset="$snake_light" />
      <img alt="GitHub Contribution Snake" src="$snake_light" width="100%" style="border-radius: 10px;" />
    </picture>
    <br>
    <sub><em>My contribution graph eating my contributions 🐍</em></sub>
  </p>
EOF
    fi
    
    # Close main div if not closed
    if ! grep -q "^</div>" "$readme_file"; then
        local current_time=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
        cat >> "$readme_file" << EOF

  <!-- Footer -->
  <br>
  <div align="center">
    <sub>⚡ <b>Last Updated:</b> $current_time | 🎯 <b>Always learning, always deploying</b></sub>
    <br>
    <sub>Automatically updated via GitHub Actions</sub>
  </div>
</div>
EOF
    fi
}

# Main execution
main() {
    echo -e "${CYAN}"
    cat << "EOF"
╔═══════════════════════════════════════╗
║        TERMINAL UPDATE SCRIPT         ║
║           ɬɧɛ ɠıɬƈɧ • Thugger069      ║
╚═══════════════════════════════════════╝
EOF
    echo -e "${RESET}"
    
    log_info "Starting terminal update process..."
    
    cd "$REPO_ROOT"
    
    check_prerequisites
    create_directories
    generate_terminal_svg
    update_readme
    
    log_success "🎉 Terminal update completed successfully!"
    echo
    echo -e "${CYAN}📋 Summary:${RESET}"
    echo -e "  👤 Display Name: ${GREEN}$DISPLAY_NAME${RESET}"
    echo -e "  🔗 GitHub: ${GREEN}$GITHUB_USERNAME${RESET}"
    echo
    echo -e "${YELLOW}📄 Generated/Updated:${RESET}"
    echo -e "  ✅ dist/terminal.svg"
    echo -e "  ✅ dist/terminal-light.svg" 
    echo -e "  ✅ README.md"
}

# Help function
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -v, --verbose  Enable verbose output"
    echo
    echo "Description:"
    echo "  Generates terminal SVG files and updates README.md"
    echo "  with a live terminal display section."
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            set -x
            shift
            ;;
        *)
            log_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Run main function
main "$@"