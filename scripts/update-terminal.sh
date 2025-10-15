#!/bin/bash
set -e

# Enhanced terminal update script with SVG generation and README integration
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

# GitHub snake URLs (using your actual snake graphics)
GITHUB_SNAKE_DARK="https://raw.githubusercontent.com/Thugger069/Thugger069/main/dist/github-snake-dark.svg"
GITHUB_SNAKE_LIGHT="https://raw.githubusercontent.com/Thugger069/Thugger069/main/dist/github-snake.svg"

# Logging functions
log_info() { echo -e "${BLUE}ℹ️  INFO:${RESET} $1"; }
log_success() { echo -e "${GREEN}✅ SUCCESS:${RESET} $1"; }
log_warning() { echo -e "${YELLOW}⚠️  WARNING:${RESET} $1"; }
log_error() { echo -e "${RED}❌ ERROR:${RESET} $1"; }
log_debug() { echo -e "${PURPLE}🐛 DEBUG:${RESET} $1"; }

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check if Node.js is available
    if ! command -v node &> /dev/null; then
        log_error "Node.js is required but not installed."
        log_info "Please install Node.js from https://nodejs.org/"
        exit 1
    fi
    
    # Check if npm is available
    if ! command -v npm &> /dev/null; then
        log_warning "npm is not available, but we'll try to continue..."
    fi
    
    # Check if the SVG generator script exists
    if [[ ! -f "$SCRIPTS_DIR/generate-terminal-svg.js" ]]; then
        log_error "SVG generator script not found: $SCRIPTS_DIR/generate-terminal-svg.js"
        log_info "Creating a basic version..."
        create_basic_svg_generator
    fi
    
    log_success "All prerequisites are satisfied"
}

# Create basic SVG generator if missing
create_basic_svg_generator() {
    cat > "$SCRIPTS_DIR/generate-terminal-svg.js" << 'EOF'
const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const DISPLAY_NAME = "ɬɧɛ ɠıɬƈɧ";
const CURRENT_TIME = new Date().toUTCString().replace(/GMT/, 'UTC');

const lines = [
  `Last login: ${CURRENT_TIME} on ttys001`,
  `${DISPLAY_NAME}@github ~ % whoami`,
  `${DISPLAY_NAME}`,
  '',
  `${DISPLAY_NAME}@github ~ % uptime`,
  `${CURRENT_TIME} up 14 days, 2:51, 1 user, load averages: 0.56 0.62 0.48`,
  '',
  `${DISPLAY_NAME}@github ~ % ls -la Projects/`,
  `total 48`,
  `drwxr-xr-x   9 ${DISPLAY_NAME}  staff   288 Jun 15 10:30 .`,
  `drwxr-xr-x   6 ${DISPLAY_NAME}  staff   192 Jun 15 10:30 ..`,
  `drwxr-xr-x   8 ${DISPLAY_NAME}  staff   256 Jun 15 10:30 .git`,
  `drwxr-xr-x   7 ${DISPLAY_NAME}  staff   224 Jun 15 10:30 DevOps`,
  `drwxr-xr-x   6 ${DISPLAY_NAME}  staff   192 Jun 15 10:30 OpenSource`,
  `drwxr-xr-x   5 ${DISPLAY_NAME}  staff   160 Jun 15 10:30 Scripts`,
  `-rw-r--r--   1 ${DISPLAY_NAME}  staff   925 Jun 15 10:30 TODO.md`,
  '',
  `${DISPLAY_NAME}@github ~ %`
];

const theme = {
  background: '#1a1b26',
  text: '#c0caf5',
  accent: '#7dcfff',
  border: '#2ac3de'
};

const LINE_HEIGHT = 18;
const PADDING = 20;
const height = lines.length * LINE_HEIGHT + PADDING * 2;
const maxLineLength = Math.max(...lines.map(line => line.length));
const CHAR_WIDTH = 8;
const width = Math.max(700, maxLineLength * CHAR_WIDTH + PADDING * 2);

const svgDark = `<svg width="${width}" height="${height}" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bgGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="${theme.background}" />
      <stop offset="100%" stop-color="#1a1a1a" />
    </linearGradient>
  </defs>
  
  <rect width="100%" height="100%" rx="12" ry="12" fill="url(#bgGradient)" 
        stroke="${theme.border}" stroke-width="2"/>
  
  <rect x="0" y="0" width="100%" height="30" rx="12" ry="12" fill="${theme.background}" 
        stroke="${theme.border}" stroke-width="2"/>
  <circle cx="15" cy="15" r="4" fill="#ff5f56"/>
  <circle cx="30" cy="15" r="4" fill="#ffbd2e"/>
  <circle cx="45" cy="15" r="4" fill="#27ca3f"/>
  <text x="60" y="18" style="font-family: monospace; font-size: 12px; fill: ${theme.text}; font-weight: bold;">${DISPLAY_NAME}@github: ~</text>
  
  <style>
    .line { font-family: monospace; font-size: 14px; fill: ${theme.text}; white-space: pre; }
  </style>
  
  ${lines.map((line, idx) => 
    `<text x="${PADDING}" y="${PADDING + idx * LINE_HEIGHT}" class="line">${line}</text>`
  ).join('')}
  
  <text x="${PADDING}" y="${PADDING + (lines.length - 1) * LINE_HEIGHT + 4}" 
        style="font-family: monospace; font-size: 14px; fill: ${theme.accent}; font-weight: bold;">█</text>
</svg>`;

// Light theme variant
const lightTheme = {
  background: '#ffffff',
  text: '#333333',
  accent: '#0366d6',
  border: '#d1d5da'
};

const svgLight = svgDark
  .replace(new RegExp(theme.background, 'g'), lightTheme.background)
  .replace(new RegExp(theme.text, 'g'), lightTheme.text)
  .replace(new RegExp(theme.accent, 'g'), lightTheme.accent)
  .replace(new RegExp(theme.border, 'g'), lightTheme.border);

fs.writeFileSync(path.join(DIST_DIR, 'terminal.svg'), svgDark);
fs.writeFileSync(path.join(DIST_DIR, 'terminal-light.svg'), svgLight);

console.log("✅ Terminal SVGs generated successfully!");
EOF
    log_success "Basic SVG generator created"
}

# Create necessary directories
create_directories() {
    log_info "Creating necessary directories..."
    
    local dirs=("$DIST_DIR" "$SCRIPTS_DIR")
    
    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
            log_success "Created directory: $dir"
        else
            log_info "Directory already exists: $dir"
        fi
    done
}

# Generate terminal SVG
generate_terminal_svg() {
    log_info "Generating terminal SVG files..."
    
    local svg_script="$SCRIPTS_DIR/generate-terminal-svg.js"
    
    if [[ ! -f "$svg_script" ]]; then
        log_error "SVG generator script not found: $svg_script"
        return 1
    fi
    
    # Run the Node.js script
    if node "$svg_script"; then
        log_success "Terminal SVG files generated successfully"
        
        # Verify files were created
        local svg_files=("$DIST_DIR/terminal.svg" "$DIST_DIR/terminal-light.svg")
        for file in "${svg_files[@]}"; do
            if [[ -f "$file" ]]; then
                local size=$(du -h "$file" 2>/dev/null | cut -f1 || echo "unknown")
                log_info "  📄 $(basename "$file") ($size)"
            else
                log_warning "Expected file not found: $file"
            fi
        done
    else
        log_error "Failed to generate terminal SVG files"
        return 1
    fi
}

# Check if GitHub snake files exist
check_github_snakes() {
    log_info "Checking GitHub contribution snakes..."
    
    # Check if we can access the snake files
    if curl --output /dev/null --silent --head --fail "$GITHUB_SNAKE_DARK"; then
        log_success "Dark theme snake is accessible"
    else
        log_warning "Dark theme snake is not accessible: $GITHUB_SNAKE_DARK"
    fi
    
    if curl --output /dev/null --silent --head --fail "$GITHUB_SNAKE_LIGHT"; then
        log_success "Light theme snake is accessible"
    else
        log_warning "Light theme snake is not accessible: $GITHUB_SNAKE_LIGHT"
    fi
}

# Update README with terminal and snake sections
update_readme() {
    log_info "Updating README.md with terminal and snake sections..."
    
    local readme_file="$REPO_ROOT/README.md"
    local temp_file="$REPO_ROOT/README.tmp"
    
    # Check if README exists
    if [[ ! -f "$readme_file" ]]; then
        log_warning "README.md not found, creating a new one..."
        create_enhanced_readme
        return 0
    fi
    
    # Create the terminal section
    local terminal_section=$(cat << TERMINAL_SECTION
<!-- Terminal Display Start -->
<div align="center">
  <h3>🎮 Live Terminal</h3>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="dist/terminal.svg">
    <source media="(prefers-color-scheme: light)" srcset="dist/terminal-light.svg">
    <img src="dist/terminal.svg" alt="Live Terminal Output" width="100%" style="border-radius: 10px; border: 1px solid #2a2b3a; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
  </picture>
  <br>
  <sub><em>Last updated: $(date -u +"%Y-%m-%d %H:%M:%S UTC")</em></sub>
</div>
<!-- Terminal Display End -->
TERMINAL_SECTION
)

    # Create the snake section
    local snake_section=$(cat << SNAKE_SECTION
<!-- Snake Display Start -->
<div align="center">
  <h3>🐍 GitHub Contributions</h3>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="$GITHUB_SNAKE_DARK" />
    <source media="(prefers-color-scheme: light)" srcset="$GITHUB_SNAKE_LIGHT" />
    <img alt="GitHub Contribution Snake" src="$GITHUB_SNAKE_LIGHT" width="100%" style="border-radius: 10px;" />
  </picture>
  <br>
  <sub><em>My contribution graph eating my contributions 🐍</em></sub>
</div>
<!-- Snake Display End -->
SNAKE_SECTION
)

    # Update terminal section
    if grep -q "<!-- Terminal Display Start -->" "$readme_file"; then
        log_info "Updating existing terminal section in README..."
        update_section "$readme_file" "$temp_file" "Terminal Display" "$terminal_section"
    else
        log_info "Adding new terminal section to README..."
        prepend_to_readme "$terminal_section" "$readme_file" "$temp_file"
    fi
    
    # Update snake section
    if grep -q "<!-- Snake Display Start -->" "$readme_file"; then
        log_info "Updating existing snake section in README..."
        update_section "$readme_file" "$temp_file" "Snake Display" "$snake_section"
    else
        log_info "Adding new snake section to README..."
        append_after_terminal "$snake_section" "$readme_file" "$temp_file"
    fi
    
    log_success "README updated successfully"
}

# Helper function to update a section
update_section() {
    local readme_file="$1"
    local temp_file="$2"
    local section_name="$3"
    local new_content="$4"
    
    awk -v new_content="$new_content" -v section="$section_name" '
        /<!-- " section " Start -->/ { 
            print new_content
            skip = 1
            next
        }
        /<!-- " section " End -->/ { 
            skip = 0
            next
        }
        skip { next }
        { print }
    ' "$readme_file" > "$temp_file" && mv "$temp_file" "$readme_file"
}

# Helper function to prepend content to README
prepend_to_readme() {
    local content="$1"
    local readme_file="$2"
    local temp_file="$3"
    
    {
        echo "$content"
        echo
        cat "$readme_file"
    } > "$temp_file" && mv "$temp_file" "$readme_file"
}

# Helper function to append after terminal section
append_after_terminal() {
    local content="$1"
    local readme_file="$2"
    local temp_file="$3"
    
    awk -v new_content="$content" '
        /<!-- Terminal Display End -->/ { 
            print $0
            print ""
            print new_content
            inserted = 1
            next
        }
        { print }
        END {
            if (!inserted) {
                print new_content
            }
        }
    ' "$readme_file" > "$temp_file" && mv "$temp_file" "$readme_file"
}

# Create enhanced README if it doesn't exist
create_enhanced_readme() {
    log_info "Creating enhanced README.md..."
    
    cat > "$REPO_ROOT/README.md" << EOF
<div align="center">
  <h1>👨‍💻 $DISPLAY_NAME</h1>
  <h3>DevOps Engineer & Open Source Enthusiast</h3>

  <!-- Badges -->
  <p align="center">
    <a href="https://github.com/$GITHUB_USERNAME">
      <img src="https://komarev.com/ghpvc/?username=$GITHUB_USERNAME&color=blueviolet&style=for-the-badge" alt="Profile Views" />
    </a>
    <a href="https://github.com/$GITHUB_USERNAME?tab=followers">
      <img src="https://img.shields.io/github/followers/$GITHUB_USERNAME?color=green&logo=github&style=for-the-badge" alt="GitHub Followers" />
    </a>
    <a href="https://twitter.com/yourhandle">
      <img src="https://img.shields.io/twitter/follow/yourhandle?color=1DA1F2&logo=twitter&style=for-the-badge" alt="Twitter Follow" />
    </a>
  </p>

$(cat << TERMINAL_SECTION
<!-- Terminal Display Start -->
<div align="center">
  <h3>🎮 Live Terminal</h3>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="dist/terminal.svg">
    <source media="(prefers-color-scheme: light)" srcset="dist/terminal-light.svg">
    <img src="dist/terminal.svg" alt="Live Terminal Output" width="100%" style="border-radius: 10px; border: 1px solid #2a2b3a; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
  </picture>
  <br>
  <sub><em>Last updated: $(date -u +"%Y-%m-%d %H:%M:%S UTC")</em></sub>
</div>
<!-- Terminal Display End -->
TERMINAL_SECTION
)

  <!-- Tech Stack -->
  <h3>🛠️ Tech Stack</h3>
  <p align="center">
    <img src="https://skillicons.dev/icons?i=linux,docker,kubernetes,aws,bash,python,go,terraform,prometheus,grafana,git,github,gitlab,vscode&perline=7" alt="Tech Stack" />
  </p>

  <!-- GitHub Stats -->
  <h3>📊 GitHub Analytics</h3>
  <p align="center">
    <img height="165" src="https://github-readme-stats.vercel.app/api?username=$GITHUB_USERNAME&show_icons=true&theme=radical&hide_border=true&bg_color=1a1b26&title_color=7dcfff&icon_color=bb9af7&text_color=c0caf5" />
    <img height="165" src="https://github-readme-stats.vercel.app/api/top-langs/?username=$GITHUB_USERNAME&layout=compact&theme=radical&hide_border=true&bg_color=1a1b26&title_color=7dcfff&text_color=c0caf5" />
  </p>
  
  <p align="center">
    <img src="https://github-readme-streak-stats.herokuapp.com/?user=$GITHUB_USERNAME&theme=radical&hide_border=true&background=1a1b26&ring=7dcfff&fire=7dcfff&currStreakLabel=7dcfff" />
  </p>

$(cat << SNAKE_SECTION
<!-- Snake Display Start -->
<div align="center">
  <h3>🐍 GitHub Contributions</h3>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="$GITHUB_SNAKE_DARK" />
    <source media="(prefers-color-scheme: light)" srcset="$GITHUB_SNAKE_LIGHT" />
    <img alt="GitHub Contribution Snake" src="$GITHUB_SNAKE_LIGHT" width="100%" style="border-radius: 10px;" />
  </picture>
  <br>
  <sub><em>My contribution graph eating my contributions 🐍</em></sub>
</div>
<!-- Snake Display End -->
SNAKE_SECTION
)

  <!-- Connect -->
  <h3>📫 Connect with Me</h3>
  <p align="center">
    <a href="https://linkedin.com/in/yourprofile">
      <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" />
    </a>
    <a href="https://twitter.com/yourhandle">
      <img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white" />
    </a>
    <a href="mailto:your.email@domain.com">
      <img src="https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white" />
    </a>
  </p>

  <!-- Footer -->
  <div align="center" style="margin-top: 30px;">
    <sub>⚡ <b>Last Updated:</b> $(date -u +"%Y-%m-%d %H:%M:%S UTC") | 🎯 <b>Always learning, always deploying</b></sub>
    <br>
    <sub>Made with ❤️ and 🐧 using Bash & Node.js | Automatically updated via GitHub Actions</sub>
  </div>
</div>
EOF

    log_success "Enhanced README.md created"
}

# Backup existing files
backup_files() {
    log_info "Creating backups of existing files..."
    
    local files=("$DIST_DIR/terminal.svg" "$DIST_DIR/terminal-light.svg" "$REPO_ROOT/README.md")
    local backup_dir="$REPO_ROOT/backup"
    
    mkdir -p "$backup_dir"
    
    for file in "${files[@]}"; do
        if [[ -f "$file" ]]; then
            local backup_name="$(basename "$file").backup.$(date +%Y%m%d_%H%M%S)"
            cp "$file" "$backup_dir/$backup_name"
            log_info "  📦 Backed up: $file → $backup_dir/$backup_name"
        fi
    done
    
    log_success "Backups completed"
}

# Cleanup function
cleanup() {
    log_info "Cleaning up temporary files..."
    
    local temp_files=("$REPO_ROOT/README.tmp")
    
    for file in "${temp_files[@]}"; do
        if [[ -f "$file" ]]; then
            rm -f "$file"
            log_info "  🗑️  Removed: $file"
        fi
    done
}

# Display summary
show_summary() {
    log_success "🎉 Terminal update completed successfully!"
    echo
    echo -e "${CYAN}📋 Summary:${RESET}"
    echo -e "  👤 Display Name: ${GREEN}$DISPLAY_NAME${RESET}"
    echo -e "  🔗 GitHub: ${GREEN}$GITHUB_USERNAME${RESET}"
    echo -e "  📁 Output Directory: ${GREEN}$DIST_DIR${RESET}"
    echo
    echo -e "${CYAN}📄 Generated Files:${RESET}"
    for file in "$DIST_DIR/terminal.svg" "$DIST_DIR/terminal-light.svg" "$REPO_ROOT/README.md"; do
        if [[ -f "$file" ]]; then
            echo -e "  ✅ $(basename "$file")"
        else
            echo -e "  ❌ $(basename "$file") (missing)"
        fi
    done
    echo
    echo -e "${CYAN}🐍 GitHub Snakes:${RESET}"
    echo -e "  🌙 Dark: $GITHUB_SNAKE_DARK"
    echo -e "  ☀️  Light: $GITHUB_SNAKE_LIGHT"
    echo
    echo -e "${YELLOW}💡 Next steps:${RESET}"
    echo -e "  - Commit and push the changes to GitHub"
    echo -e "  - Set up a GitHub Action to run this script automatically"
    echo -e "  - Customize the terminal content in ${CYAN}scripts/generate-terminal-svg.js${RESET}"
}

# Main execution function
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
    echo
    
    # Change to repo root directory
    cd "$REPO_ROOT"
    
    # Execute steps
    check_prerequisites
    create_directories
    backup_files
    generate_terminal_svg
    check_github_snakes
    update_readme
    cleanup
    show_summary
}

# Help function
show_help() {
    echo -e "${CYAN}Terminal Update Script${RESET}"
    echo
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  -h, --help      Show this help message"
    echo "  -b, --backup    Create backups before updating"
    echo "  -f, --force     Force update without prompts"
    echo "  -v, --verbose   Enable verbose output"
    echo "  -s, --skip-svg  Skip SVG generation (use existing files)"
    echo
    echo "Description:"
    echo "  This script generates terminal SVG files and updates the README.md"
    echo "  to display a live terminal interface and GitHub contribution snakes."
    echo
    echo "Environment Variables:"
    echo "  DISPLAY_NAME     Set the display name (default: ɬɧɛ ɠıɬƈɧ)"
    echo "  GITHUB_USERNAME  Set GitHub username for links (default: Thugger069)"
    echo
    echo "Examples:"
    echo "  $0                      # Normal execution"
    echo "  $0 --skip-svg           # Use existing SVG files"
    echo "  $0 --backup --verbose   # With backup and verbose output"
}

# Parse command line arguments
VERBOSE=false
FORCE=false
CREATE_BACKUP=true
SKIP_SVG=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -b|--backup)
            CREATE_BACKUP=true
            shift
            ;;
        -s|--skip-svg)
            SKIP_SVG=true
            shift
            ;;
        *)
            log_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Set verbose mode
if [[ "$VERBOSE" == "true" ]]; then
    set -x
fi

# Error handler
trap 'log_error "Script failed at line $LINENO"; cleanup; exit 1' ERR

# Run main function
main "$@"