#!/bin/bash
set -e

# Enhanced configuration with your specific usernames
DISPLAY_NAME=${DISPLAY_NAME:-"ɬɧɛ ɠıɬƈɧ"}
GITHUB_USERNAME=${GITHUB_USERNAME:-"Thugger069"}
CURRENT_TIME=${CURRENT_TIME:-$(date -u +"%Y-%m-%dT%H:%M:%SZ")}
TIMEZONE=${TIMEZONE:-"UTC"}

# Color codes for terminal (for potential future use)
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Validate environment
validate_environment() {
    local required_commands=("date" "printf")
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "❌ Error: $cmd is required but not installed."
            exit 1
        fi
    done
    
    if [[ ${#DISPLAY_NAME} -gt 50 ]]; then
        echo "❌ Error: Display name too long."
        exit 1
    fi
}

# Enhanced load generator with emoji indicators
generate_load_avg() {
    if command -v bc &> /dev/null; then
        local load1 load2 load3
        load1=$(echo "scale=2; ${RANDOM}/32767 + 0.1" | bc)
        load2=$(echo "scale=2; ${RANDOM}/32767 + 0.2" | bc)
        load3=$(echo "scale=2; ${RANDOM}/32767 + 0.1" | bc)
        
        # Add emoji based on load (using string comparison since bc might not be available in all environments)
        if (( $(echo "$load1 > 0.8" | bc -l 2>/dev/null || echo "0") )); then
            load1="🔴 $load1"
        elif (( $(echo "$load1 > 0.5" | bc -l 2>/dev/null || echo "0") )); then
            load1="🟡 $load1"
        else
            load1="🟢 $load1"
        fi
        
        printf "%s %s %s" "$load1" "$load2" "$load3"
    else
        # Fallback without bc
        local load1 load2 load3
        load1=$(printf "%.2f" "$(( RANDOM % 100 / 100.0 + 0.1 ))")
        load2=$(printf "%.2f" "$(( RANDOM % 100 / 100.0 + 0.2 ))")
        load3=$(printf "%.2f" "$(( RANDOM % 100 / 100.0 + 0.1 ))")
        
        # Simple emoji based on first load value
        if (( $(echo "$load1 > 0.8" | bc -l 2>/dev/null || echo "0") )); then
            load1="🔴 $load1"
        elif (( $(echo "$load1 > 0.5" | bc -l 2>/dev/null || echo "0") )); then
            load1="🟡 $load1"
        else
            load1="🟢 $load1"
        fi
        
        echo "$load1 $load2 $load3"
    fi
}

# Dynamic project status
get_random_project_status() {
    local statuses=("🚀 In Progress" "✅ Completed" "🔧 Maintenance" "📝 Planning" "🎯 Active Development" "⚡ Just Started" "📊 Testing" "🚢 Deployment")
    echo "${statuses[$((RANDOM % ${#statuses[@]}))]}"
}

# System info simulation
get_system_info() {
    cat << EOF
System:    macOS 13.4.1 (Darwin 22.5.0)
Kernel:    x86_64 Darwin Kernel Version 22.5.0
Shell:     zsh 5.9
Terminal:  Apple_Terminal
EOF
}

# Get random tech fact
get_tech_fact() {
    local facts=(
        "Containers don't contain! They share the host kernel."
        "Kubernetes means 'helmsman' in Greek."
        "A single Docker image can be over 1GB in size."
        "Terraform uses declarative configuration, not imperative."
        "Prometheus pulls metrics, unlike most monitoring tools that push."
    )
    echo "${facts[$((RANDOM % ${#facts[@]}))]}"
}

# Generate metrics summary
get_metrics_summary() {
    cat << EOF
💻 CPU: $(printf "%2d%%" $((RANDOM % 40 + 10)))
🧠 MEM: $(printf "%2d%%" $((RANDOM % 50 + 20)))  
💾 DISK: $(printf "%2d%%" $((RANDOM % 30 + 10)))
🌐 NET: $(printf "%dMB" $((RANDOM % 500 + 50)))
EOF
}

# Enhanced terminal content
generate_terminal_content() {
    local LOAD_AVG=$(generate_load_avg)
    local PROJECT_STATUS=$(get_random_project_status)
    local TECH_FACT=$(get_tech_fact)

    cat << EOF
Last login: ${CURRENT_TIME} on ttys001
${DISPLAY_NAME}@github ~ % whoami
${DISPLAY_NAME}

${DISPLAY_NAME}@github ~ % uname -a
$(get_system_info)

${DISPLAY_NAME}@github ~ % uptime
${CURRENT_TIME} up 14 days, 2:51, 1 user, load averages: ${LOAD_AVG}

${DISPLAY_NAME}@github ~ % ls -la Projects/
total 48
drwxr-xr-x   9 ${DISPLAY_NAME}  staff   288 Jun 15 10:30 .
drwxr-xr-x   6 ${DISPLAY_NAME}  staff   192 Jun 15 10:30 ..
drwxr-xr-x   8 ${DISPLAY_NAME}  staff   256 Jun 15 10:30 .git
-rw-r--r--   1 ${DISPLAY_NAME}  staff   113 Jun 15 10:30 .gitignore
drwxr-xr-x   7 ${DISPLAY_NAME}  staff   224 Jun 15 10:30 DevOps
drwxr-xr-x   6 ${DISPLAY_NAME}  staff   192 Jun 15 10:30 OpenSource
drwxr-xr-x   5 ${DISPLAY_NAME}  staff   160 Jun 15 10:30 Scripts
-rw-r--r--   1 ${DISPLAY_NAME}  staff  1024 Jun 15 10:30 README.md
-rw-r--r--   1 ${DISPLAY_NAME}  staff   925 Jun 15 10:30 TODO.md

${DISPLAY_NAME}@github ~ % cat Projects/TODO.md
# 📋 Current Projects | Status: ${PROJECT_STATUS}

## 🚀 Active Development
- [ ] Kubernetes cluster autoscaling solution
- [ ] Terraform multi-cloud deployment
- [ ] CI/CD pipeline optimization
- [ ] Monitoring stack with Prometheus & Grafana

## 🔄 Maintenance
- [ ] Update Docker container security
- [ ] Backup strategy implementation
- [ ] Documentation refresh

## 🎯 Future Goals
- [ ] Learn Go for systems programming
- [ ] Contribute to CNCF projects
- [ ] Build distributed systems knowledge

${DISPLAY_NAME}@github ~ % docker ps
CONTAINER ID   IMAGE           COMMAND                  STATUS       PORTS     NAMES
a1b2c3d4e5f6   nginx:alpine    "nginx -g 'daemon off;" Up 2 hours   80/tcp    webserver
f6e5d4c3b2a1   redis:7-alpine  "docker-entrypoint.s…"  Up 2 hours   6379/tcp  cache

${DISPLAY_NAME}@github ~ % metrics
$(get_metrics_summary)

${DISPLAY_NAME}@github ~ % fact
💡 ${TECH_FACT}

${DISPLAY_NAME}@github ~ % 
EOF
}

# Generate interactive sections
generate_interactive_section() {
    cat << EOF
<!-- Connect with Me -->
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
  <a href="https://medium.com/@yourhandle">
    <img src="https://img.shields.io/badge/Medium-12100E?style=for-the-badge&logo=medium&logoColor=white" />
  </a>
</p>

<!-- Recent Activity -->
<h3>📝 Recent Activity</h3>

<!--START_SECTION:activity-->
1. 🎉 Merged PR #42 in DevOps repository
2. 🐛 Fixed critical bug in deployment script
3. 📚 Updated Kubernetes documentation
4. 🔧 Improved CI/CD pipeline performance
5. 🚀 Deployed v1.2.0 to production cluster
<!--END_SECTION:activity-->
EOF
}

# Generate README with enhanced styling
generate_readme() {
    cat > README.md << EOF
<div align="center">
  <h2>👨‍💻 ${DISPLAY_NAME}'s DevOps Hub</h2>

  <!-- Badges -->
  <p align="center">
    <a href="https://github.com/${GITHUB_USERNAME}">
      <img src="https://komarev.com/ghpvc/?username=${GITHUB_USERNAME}&color=blueviolet&style=for-the-badge" alt="Profile Views" />
    </a>
    <a href="https://github.com/${GITHUB_USERNAME}?tab=followers">
      <img src="https://img.shields.io/github/followers/${GITHUB_USERNAME}?color=green&logo=github&style=for-the-badge" alt="GitHub Followers" />
    </a>
    <a href="https://twitter.com/yourhandle">
      <img src="https://img.shields.io/twitter/follow/yourhandle?color=1DA1F2&logo=twitter&style=for-the-badge" alt="Twitter Follow" />
    </a>
  </p>

  <!-- Terminal Container -->
  <div align="left" style="background: #1a1b26; border-radius: 10px; padding: 20px; margin: 20px 0; font-family: 'Monaco', 'Consolas', 'Courier New', monospace; color: #c0caf5; font-size: 14px; line-height: 1.4; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); border: 1px solid #2a2b3a;">
$(generate_terminal_content)
  </div>

  <!-- Tech Stack -->
  <h3>🛠 Tech Stack & Tools</h3>
  <p align="center">
    <img src="https://skillicons.dev/icons?i=linux,docker,kubernetes,aws,gcp,azure,bash,python,go,terraform,ansible,prometheus,grafana,git,github,gitlab,vim,vscode&perline=9" alt="Tech Stack" />
  </p>

  <!-- GitHub Stats -->
  <h3>📊 GitHub Analytics</h3>
  <p align="center">
    <img height="165" src="https://github-readme-stats.vercel.app/api?username=${GITHUB_USERNAME}&show_icons=true&theme=radical&hide_border=true&bg_color=1a1b26&title_color=7dcfff&icon_color=bb9af7&text_color=c0caf5" />
    <img height="165" src="https://github-readme-stats.vercel.app/api/top-langs/?username=${GITHUB_USERNAME}&layout=compact&theme=radical&hide_border=true&bg_color=1a1b26&title_color=7dcfff&text_color=c0caf5" />
  </p>
  
  <p align="center">
    <img src="https://github-readme-streak-stats.herokuapp.com/?user=${GITHUB_USERNAME}&theme=radical&hide_border=true&background=1a1b26&ring=7dcfff&fire=7dcfff&currStreakLabel=7dcfff" />
  </p>

  <!-- Connect Section -->
  $(generate_interactive_section)

  <!-- GitHub Snake -->
  <h3>🐍 Contribution Graph</h3>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/${GITHUB_USERNAME}/${GITHUB_USERNAME}/output/github-snake-dark.svg" />
    <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/${GITHUB_USERNAME}/${GITHUB_USERNAME}/output/github-snake.svg" />
    <img width="100%" alt="GitHub Contributions" src="https://raw.githubusercontent.com/${GITHUB_USERNAME}/${GITHUB_USERNAME}/output/github-snake.svg" />
  </picture>

  <!-- Footer -->
  <div align="center" style="margin-top: 30px;">
    <sub>⚡ <b>Last Updated:</b> ${CURRENT_TIME} UTC | 🎯 <b>Always learning, always deploying</b></sub>
    <br>
    <sub>Made with ❤️ and 🐧 using Bash | Automatically updated via GitHub Actions</sub>
  </div>
</div>
EOF
}

# Main execution function
main() {
    echo "🚀 Starting README generation..."
    echo "📝 Display Name: ${DISPLAY_NAME}"
    echo "🔗 GitHub Username: ${GITHUB_USERNAME}"
    validate_environment
    mkdir -p dist
    generate_readme
    echo "✅ README.md successfully generated at $(date)"
    echo "📊 Features included:"
    echo "   ✓ Dynamic terminal simulation"
    echo "   ✓ Real-time system metrics"
    echo "   ✓ Tech stack icons"
    echo "   ✓ GitHub statistics"
    echo "   ✓ Social badges"
    echo "   ✓ Contribution snake"
}

# Help function
show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Generate a dynamic GitHub README with terminal simulation

Options:
  -h, --help          Show this help message
  -d, --display-name  Set custom display name (default: ɬɧɛ ɠıɬƈɧ)
  -g, --github-user   Set GitHub username for links (default: Thugger069)
  -t, --timezone      Set timezone (default: UTC)

Environment Variables:
  DISPLAY_NAME        Set the fancy username displayed in terminal
  GITHUB_USERNAME     Set GitHub username for badges and links
  CURRENT_TIME        Set custom timestamp
  TIMEZONE            Set timezone for display

Examples:
  $0
  DISPLAY_NAME="ɬɧɛ ɠıɬƈɧ" GITHUB_USERNAME="Thugger069" $0
  $0 --display-name "ɬɧɛ ɠıɬƈɧ" --github-user "Thugger069"
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -d|--display-name)
            DISPLAY_NAME="$2"
            shift 2
            ;;
        -g|--github-user)
            GITHUB_USERNAME="$2"
            shift 2
            ;;
        -t|--timezone)
            TIMEZONE="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Run main function
main "$@"