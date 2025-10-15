#!/usr/bin/env bash
# 🜂 Q.R.I.P UPDATE README SCRIPT | v7.1 🜁
# Cyberpunk header + terminal SVG + GitHub stats + tech stack + connected with me + activity graphs + footer + full README preservation.

set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
README_FILE="$REPO_ROOT/README.md"
NODE_BIN="$(which node)"
TIMESTAMP="$(date -u +%Y-%m-%d\ %H:%M:%S\ UTC)"
BACKUP_FILE="$README_FILE.bak_$(date -u +%Y%m%d%H%M%S)"
ASSETS_DIR="$REPO_ROOT/assets"
mkdir -p "$ASSETS_DIR"

AUTHOR="ɬɧɛ ɠıɬƈɧ"
GITHUB_USERNAME="Thugger069"
CONNECTED_WITH="Snake"

log() { echo -e "\033[1;36m[INFO]\033[0m $*"; }
success() { echo -e "\033[1;32m[SUCCESS]\033[0m $*"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m $*"; }
error() { echo -e "\033[1;31m[ERROR]\033[0m $*"; }

# Backup existing README
[ -f "$README_FILE" ] && cp "$README_FILE" "$BACKUP_FILE" && log "Backup created at $BACKUP_FILE"

# Regenerate typing SVG
log "Regenerating typing SVG..."
curl -s "https://readme-typing-svg.herokuapp.com?font=Ubuntu+Mono&weight=600&size=22&duration=2000&pause=500&color=00F3FF&background=0a0a0f00&center=true&lines=Hello+World;Quantum+Developer;Cyberpunk+Architect" -o "$ASSETS_DIR/typing.svg"
success "Typing SVG updated."

# Generate Header + Terminal SVG
log "Generating cyberpunk header..."
HEADER_CONTENT="$("$NODE_BIN" "$SCRIPT_DIR/generate-header.js")"
TERMINAL_SVG_CONTENT="$("$NODE_BIN" "$SCRIPT_DIR/generate-terminal-svg.js")"

# GitHub stats, tech stack & activity graphs
GITHUB_STATS_SECTION=$(cat <<STATS
<div style="display:flex;flex-wrap:wrap;gap:1rem;margin:2rem 0;justify-content:center;">
  <div style="background:rgba(10,10,15,0.85);padding:1rem;border-radius:10px;border:1px solid #00f3ff;text-align:center;">
    <h3 style="color:#00F3FF;">GitHub Stats</h3>
    <img src="https://github-readme-stats.vercel.app/api?username=${GITHUB_USERNAME}&show_icons=true&theme=dark&hide_border=true&count_private=true" alt="GitHub Stats"/>
  </div>
  <div style="background:rgba(10,10,15,0.85);padding:1rem;border-radius:10px;border:1px solid #FF00FF;text-align:center;">
    <h3 style="color:#FF00FF;">Tech Stack</h3>
    <img src="https://skillicons.dev/icons?i=python,nodejs,rust,go,docker,k8s,aws,azure,gcp,pytorch" alt="Tech Stack"/>
  </div>
  <div style="background:rgba(10,10,15,0.85);padding:1rem;border-radius:10px;border:1px solid #B967FF;text-align:center;">
    <h3 style="color:#B967FF;">Activity Graph</h3>
    <img src="https://github-readme-activity-graph.vercel.app/graph?username=${GITHUB_USERNAME}&theme=react-dark&hide_border=true" alt="GitHub Activity"/>
  </div>
</div>
STATS
)

# Connected with me section
CONNECTED_SECTION=$(cat <<CONNECT
<div style="margin:2rem 0;text-align:center;">
  <h3 style="color:#B967FF;">Connected With Me</h3>
  <a href="https://github.com/${CONNECTED_WITH}" style="margin-right:1rem;"><img src="https://img.shields.io/badge/Snake-GitHub-blue?style=for-the-badge&logo=github"/></a>
  <a href="https://github.com/${GITHUB_USERNAME}" style="margin-left:1rem;"><img src="https://img.shields.io/badge/${AUTHOR}-GitHub-pink?style=for-the-badge&logo=github"/></a>
</div>
CONNECT
)

# Footer
FOOTER_SECTION=$(cat <<FOOTER
<div style="margin-top:2rem;text-align:center;font-family:'Ubuntu Mono',monospace;font-size:0.75rem;color:#00ff41;">
  Maintained by ${AUTHOR} | Last Updated: ${TIMESTAMP} | 🜂 Q.R.I.P ALL-IN 🜁
</div>
FOOTER
)

# Preserve existing README content
EXISTING_CONTENT=""
if [ -f "$README_FILE" ]; then
  EXISTING_CONTENT=$(awk '/<!-- Ultimate Cyberpunk Header End -->/{flag=0;next}flag;/<!-- Ultimate Cyberpunk Header Start -->/{flag=1}' "$README_FILE")
  [ -z "$EXISTING_CONTENT" ] && EXISTING_CONTENT=$(cat "$README_FILE")
fi

# Write final README
{
  echo "<---
- name: Deploy Quantum VPN Server and Clients
  hosts: vpn-server
  become: yes
  vars_files:
    - vault.yml

  pre_tasks:
    - name: Ensure Python 3 is installed
      ansible.builtin.package:
        name: python3
        state: present

    - name: Ensure EPEL repository is enabled
      ansible.builtin.yum:
        name: epel-release
        state: present

    - name: Import ELRepo GPG key
      ansible.builtin.rpm_key:
        state: present
        key: https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

    - name: Install ELRepo repository (kernel modules)
      ansible.builtin.yum:
        name: https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm
        state: present

  tasks:
    - name: Install WireGuard tools and kernel module
      ansible.builtin.yum:
        name:
          - wireguard-tools
          - kmod-wireguard
        state: present

    - name: Ensure /etc/wireguard directory exists
      ansible.builtin.file:
        path: /etc/wireguard
        state: directory
        owner: root
        group: root
        mode: '700'

    - name: Ensure clients output directory exists
      ansible.builtin.file:
        path: "{{ clients_output_dir }}"
        state: directory
        owner: root
        group: root
        mode: '700'

    - name: Deploy server configuration
      ansible.builtin.template:
        src: templates/wg0.conf.j2
        dest: /etc/wireguard/wg0.conf
        owner: root
        group: root
        mode: '600'

    - name: Restart WireGuard
      ansible.builtin.systemd:
        name: wg-quick@wg0
        state: restarted
        enabled: Ultimate Cyberpunk Header Start -->"
  echo "$HEADER_CONTENT"
  echo "<---
- name: Deploy Quantum VPN Server and Clients
  hosts: vpn-server
  become: yes
  vars_files:
    - vault.yml

  pre_tasks:
    - name: Ensure Python 3 is installed
      ansible.builtin.package:
        name: python3
        state: present

    - name: Ensure EPEL repository is enabled
      ansible.builtin.yum:
        name: epel-release
        state: present

    - name: Import ELRepo GPG key
      ansible.builtin.rpm_key:
        state: present
        key: https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

    - name: Install ELRepo repository (kernel modules)
      ansible.builtin.yum:
        name: https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm
        state: present

  tasks:
    - name: Install WireGuard tools and kernel module
      ansible.builtin.yum:
        name:
          - wireguard-tools
          - kmod-wireguard
        state: present

    - name: Ensure /etc/wireguard directory exists
      ansible.builtin.file:
        path: /etc/wireguard
        state: directory
        owner: root
        group: root
        mode: '700'

    - name: Ensure clients output directory exists
      ansible.builtin.file:
        path: "{{ clients_output_dir }}"
        state: directory
        owner: root
        group: root
        mode: '700'

    - name: Deploy server configuration
      ansible.builtin.template:
        src: templates/wg0.conf.j2
        dest: /etc/wireguard/wg0.conf
        owner: root
        group: root
        mode: '600'

    - name: Restart WireGuard
      ansible.builtin.systemd:
        name: wg-quick@wg0
        state: restarted
        enabled: Terminal SVG Start -->"
  echo "$TERMINAL_SVG_CONTENT"
  echo "<---
- name: Deploy Quantum VPN Server and Clients
  hosts: vpn-server
  become: yes
  vars_files:
    - vault.yml

  pre_tasks:
    - name: Ensure Python 3 is installed
      ansible.builtin.package:
        name: python3
        state: present

    - name: Ensure EPEL repository is enabled
      ansible.builtin.yum:
        name: epel-release
        state: present

    - name: Import ELRepo GPG key
      ansible.builtin.rpm_key:
        state: present
        key: https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

    - name: Install ELRepo repository (kernel modules)
      ansible.builtin.yum:
        name: https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm
        state: present

  tasks:
    - name: Install WireGuard tools and kernel module
      ansible.builtin.yum:
        name:
          - wireguard-tools
          - kmod-wireguard
        state: present

    - name: Ensure /etc/wireguard directory exists
      ansible.builtin.file:
        path: /etc/wireguard
        state: directory
        owner: root
        group: root
        mode: '700'

    - name: Ensure clients output directory exists
      ansible.builtin.file:
        path: "{{ clients_output_dir }}"
        state: directory
        owner: root
        group: root
        mode: '700'

    - name: Deploy server configuration
      ansible.builtin.template:
        src: templates/wg0.conf.j2
        dest: /etc/wireguard/wg0.conf
        owner: root
        group: root
        mode: '600'

    - name: Restart WireGuard
      ansible.builtin.systemd:
        name: wg-quick@wg0
        state: restarted
        enabled: Terminal SVG End -->"
  echo "$GITHUB_STATS_SECTION"
  echo "$CONNECTED_SECTION"
  echo "$FOOTER_SECTION"
  echo "<---
- name: Deploy Quantum VPN Server and Clients
  hosts: vpn-server
  become: yes
  vars_files:
    - vault.yml

  pre_tasks:
    - name: Ensure Python 3 is installed
      ansible.builtin.package:
        name: python3
        state: present

    - name: Ensure EPEL repository is enabled
      ansible.builtin.yum:
        name: epel-release
        state: present

    - name: Import ELRepo GPG key
      ansible.builtin.rpm_key:
        state: present
        key: https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

    - name: Install ELRepo repository (kernel modules)
      ansible.builtin.yum:
        name: https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm
        state: present

  tasks:
    - name: Install WireGuard tools and kernel module
      ansible.builtin.yum:
        name:
          - wireguard-tools
          - kmod-wireguard
        state: present

    - name: Ensure /etc/wireguard directory exists
      ansible.builtin.file:
        path: /etc/wireguard
        state: directory
        owner: root
        group: root
        mode: '700'

    - name: Ensure clients output directory exists
      ansible.builtin.file:
        path: "{{ clients_output_dir }}"
        state: directory
        owner: root
        group: root
        mode: '700'

    - name: Deploy server configuration
      ansible.builtin.template:
        src: templates/wg0.conf.j2
        dest: /etc/wireguard/wg0.conf
        owner: root
        group: root
        mode: '600'

    - name: Restart WireGuard
      ansible.builtin.systemd:
        name: wg-quick@wg0
        state: restarted
        enabled: Ultimate Cyberpunk Header End -->"
  echo ""
  echo "$EXISTING_CONTENT"
} > "$README_FILE"

success "✅ README v7.1 updated with dynamic activity graphs, terminal SVG, cyberpunk header, GitHub stats, tech stack, connected section, and footer"

# Git commit & push
if git rev-parse --git-dir > /dev/null 2>&1; then
  git add "$README_FILE" "$ASSETS_DIR/"*.svg
  if ! git diff --cached --quiet; then
    git commit -m "🜂 Q.R.I.P Cyberpunk README v7.1 update 🜁 $(date -u +%Y%m%d%H%M%S)"
    git push
    success "Changes pushed to repository."
  else
    log "No changes detected to commit."
  fi
else
  warn "Not a git repository; skipping git operations."
fi
