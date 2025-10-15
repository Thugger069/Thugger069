<---
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
        path: {{ clients_output_dir }}
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
        enabled: Ultimate Cyberpunk Header Start -->
🚀 ULTIMATE CYBERPUNK HEADER GENERATED!
✨ Inspired by awesome-github-profile-readme with:
   🌌 Advanced Matrix Rain with multiple character sets
   🔮 3D Holographic Grid with quantum circuits
   📊 Interactive Profile Cards (GitHub stats style)
   ⌨️ Enhanced Typing Animation with cyberpunk styling
   🔗 Social Links with hover effects
   📱 Responsive design for all devices
   🎮 Interactive hover animations throughout
👤 Profile: ɬɧɛ ɠıɬƈɧ (Thugger069)
<---
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
        path: {{ clients_output_dir }}
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
        enabled: Terminal SVG Start -->
✅ Generated fully enhanced terminal.svg with matrix, cursor, TODOs, and particles
<---
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
        path: {{ clients_output_dir }}
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
        enabled: Terminal SVG End -->
<div style="display:flex;flex-wrap:wrap;gap:1rem;margin:2rem 0;justify-content:center;">
  <div style="background:rgba(10,10,15,0.85);padding:1rem;border-radius:10px;border:1px solid #00f3ff;text-align:center;">
    <h3 style="color:#00F3FF;">GitHub Stats</h3>
    <img src="https://github-readme-stats.vercel.app/api?username=Thugger069&show_icons=true&theme=dark&hide_border=true&count_private=true" alt="GitHub Stats"/>
  </div>
  <div style="background:rgba(10,10,15,0.85);padding:1rem;border-radius:10px;border:1px solid #FF00FF;text-align:center;">
    <h3 style="color:#FF00FF;">Tech Stack</h3>
    <img src="https://skillicons.dev/icons?i=python,nodejs,rust,go,docker,k8s,aws,azure,gcp,pytorch" alt="Tech Stack"/>
  </div>
  <div style="background:rgba(10,10,15,0.85);padding:1rem;border-radius:10px;border:1px solid #B967FF;text-align:center;">
    <h3 style="color:#B967FF;">Activity Graph</h3>
    <img src="https://github-readme-activity-graph.vercel.app/graph?username=Thugger069&theme=react-dark&hide_border=true" alt="GitHub Activity"/>
  </div>
</div>
<div style="margin:2rem 0;text-align:center;">
  <h3 style="color:#B967FF;">Connected With Me</h3>
  <a href="https://github.com/Snake" style="margin-right:1rem;"><img src="https://img.shields.io/badge/Snake-GitHub-blue?style=for-the-badge&logo=github"/></a>
  <a href="https://github.com/Thugger069" style="margin-left:1rem;"><img src="https://img.shields.io/badge/ɬɧɛ ɠıɬƈɧ-GitHub-pink?style=for-the-badge&logo=github"/></a>
</div>
<div style="margin-top:2rem;text-align:center;font-family:'Ubuntu Mono',monospace;font-size:0.75rem;color:#00ff41;">
  Maintained by ɬɧɛ ɠıɬƈɧ | Last Updated: 2025-10-15 07:35:37 UTC | 🜂 Q.R.I.P ALL-IN 🜁
</div>
<---
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
        path: {{ clients_output_dir }}
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
        enabled: Ultimate Cyberpunk Header End -->


<div class="cyber-container" style="position:relative;width:100%;height:600px;background:linear-gradient(135deg,#0a0a0f 0%,#1a1b26 50%,#0a0a0f 100%);overflow:hidden;border-radius:20px;margin:2rem 0;border:2px solid transparent;background-clip:padding-box;box-shadow:0 0 50px rgba(0,243,255,0.2);">
  <div style="position:absolute;top:0;left:0;width:100%;height:100%;border-radius:20px;padding:2px;background:linear-gradient(45deg,#00f3ff,#ff00ff,#b967ff,#00f3ff);background-size:400% 400%;animation:borderFlow 6s ease infinite;z-index:4;pointer-events:none;"></div>
  <svg width="100%" height="100%" style="position:absolute;top:0;left:0;z-index:0;opacity:0.4;"><text x="0.00%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="0.00%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.30;0" dur="3.20s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.20s" repeatCount="indefinite" begin="1.48s"/>
    </text><text x="2.20%" y="-10%" fill="#00F3FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="2.20%" dy="1.2em" opacity="0">
        ∫
        <animate attributeName="opacity" values="0;0.30;0" dur="3.37s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="2.20%" dy="1.2em" opacity="0">
        ∫
        <animate attributeName="opacity" values="0;0.50;0" dur="3.37s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="2.20%" dy="1.2em" opacity="0">
        ≤
        <animate attributeName="opacity" values="0;0.70;0" dur="3.37s" begin="0.60s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.37s" repeatCount="indefinite" begin="0.85s"/>
    </text><text x="4.40%" y="-10%" fill="#00FF41" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="4.40%" dy="1.2em" opacity="0">
        ∫
        <animate attributeName="opacity" values="0;0.30;0" dur="3.64s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.64s" repeatCount="indefinite" begin="0.08s"/>
    </text><text x="6.60%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="6.60%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.30;0" dur="3.84s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="6.60%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.50;0" dur="3.84s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="6.60%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.70;0" dur="3.84s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="6.60%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.90;0" dur="3.84s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.84s" repeatCount="indefinite" begin="2.70s"/>
    </text><text x="8.80%" y="-10%" fill="#00F3FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="8.80%" dy="1.2em" opacity="0">
        ツ
        <animate attributeName="opacity" values="0;0.30;0" dur="2.17s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="8.80%" dy="1.2em" opacity="0">
        テ
        <animate attributeName="opacity" values="0;0.50;0" dur="2.17s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.17s" repeatCount="indefinite" begin="0.69s"/>
    </text><text x="11.00%" y="-10%" fill="#B967FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="11.00%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.30;0" dur="2.91s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="11.00%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.50;0" dur="2.91s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="11.00%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.70;0" dur="2.91s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="11.00%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.90;0" dur="2.91s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.91s" repeatCount="indefinite" begin="0.39s"/>
    </text><text x="13.20%" y="-10%" fill="#B967FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="13.20%" dy="1.2em" opacity="0">
        エ
        <animate attributeName="opacity" values="0;0.30;0" dur="4.44s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.44s" repeatCount="indefinite" begin="0.96s"/>
    </text><text x="15.40%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="15.40%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.30;0" dur="2.95s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="15.40%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.50;0" dur="2.95s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.95s" repeatCount="indefinite" begin="1.50s"/>
    </text><text x="17.60%" y="-10%" fill="#00FF41" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="17.60%" dy="1.2em" opacity="0">
        チ
        <animate attributeName="opacity" values="0;0.30;0" dur="2.39s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="17.60%" dy="1.2em" opacity="0">
        カ
        <animate attributeName="opacity" values="0;0.50;0" dur="2.39s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.39s" repeatCount="indefinite" begin="0.94s"/>
    </text><text x="19.80%" y="-10%" fill="#00F3FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="19.80%" dy="1.2em" opacity="0">
        ⨖
        <animate attributeName="opacity" values="0;0.30;0" dur="3.30s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="19.80%" dy="1.2em" opacity="0">
        ⨎
        <animate attributeName="opacity" values="0;0.50;0" dur="3.30s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.30s" repeatCount="indefinite" begin="2.78s"/>
    </text><text x="22.00%" y="-10%" fill="#00F3FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="22.00%" dy="1.2em" opacity="0">
        ツ
        <animate attributeName="opacity" values="0;0.30;0" dur="3.82s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="22.00%" dy="1.2em" opacity="0">
        ケ
        <animate attributeName="opacity" values="0;0.50;0" dur="3.82s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.82s" repeatCount="indefinite" begin="2.45s"/>
    </text><text x="24.20%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="24.20%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.30;0" dur="2.27s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="24.20%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.50;0" dur="2.27s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="24.20%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.70;0" dur="2.27s" begin="0.60s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.27s" repeatCount="indefinite" begin="0.30s"/>
    </text><text x="26.40%" y="-10%" fill="#B967FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="26.40%" dy="1.2em" opacity="0">
        ∂
        <animate attributeName="opacity" values="0;0.30;0" dur="4.51s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="26.40%" dy="1.2em" opacity="0">
        ∏
        <animate attributeName="opacity" values="0;0.50;0" dur="4.51s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.51s" repeatCount="indefinite" begin="2.51s"/>
    </text><text x="28.60%" y="-10%" fill="#00F3FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="28.60%" dy="1.2em" opacity="0">
        ⨚
        <animate attributeName="opacity" values="0;0.30;0" dur="4.51s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="28.60%" dy="1.2em" opacity="0">
        ⨂
        <animate attributeName="opacity" values="0;0.50;0" dur="4.51s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="28.60%" dy="1.2em" opacity="0">
        ⨑
        <animate attributeName="opacity" values="0;0.70;0" dur="4.51s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="28.60%" dy="1.2em" opacity="0">
        ⨘
        <animate attributeName="opacity" values="0;0.90;0" dur="4.51s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.51s" repeatCount="indefinite" begin="2.26s"/>
    </text><text x="30.80%" y="-10%" fill="#00F3FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="30.80%" dy="1.2em" opacity="0">
        ⨏
        <animate attributeName="opacity" values="0;0.30;0" dur="3.93s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="30.80%" dy="1.2em" opacity="0">
        ⨄
        <animate attributeName="opacity" values="0;0.50;0" dur="3.93s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.93s" repeatCount="indefinite" begin="3.22s"/>
    </text><text x="33.00%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="33.00%" dy="1.2em" opacity="0">
        ∑
        <animate attributeName="opacity" values="0;0.30;0" dur="2.61s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="33.00%" dy="1.2em" opacity="0">
        ∫
        <animate attributeName="opacity" values="0;0.50;0" dur="2.61s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="33.00%" dy="1.2em" opacity="0">
        ∑
        <animate attributeName="opacity" values="0;0.70;0" dur="2.61s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="33.00%" dy="1.2em" opacity="0">
        ∞
        <animate attributeName="opacity" values="0;0.90;0" dur="2.61s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.61s" repeatCount="indefinite" begin="1.04s"/>
    </text><text x="35.20%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="35.20%" dy="1.2em" opacity="0">
        ∇
        <animate attributeName="opacity" values="0;0.30;0" dur="3.62s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="35.20%" dy="1.2em" opacity="0">
        ∑
        <animate attributeName="opacity" values="0;0.50;0" dur="3.62s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="35.20%" dy="1.2em" opacity="0">
        ∑
        <animate attributeName="opacity" values="0;0.70;0" dur="3.62s" begin="0.60s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.62s" repeatCount="indefinite" begin="0.70s"/>
    </text><text x="37.40%" y="-10%" fill="#00F3FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="37.40%" dy="1.2em" opacity="0">
        ア
        <animate attributeName="opacity" values="0;0.30;0" dur="2.25s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="37.40%" dy="1.2em" opacity="0">
        ケ
        <animate attributeName="opacity" values="0;0.50;0" dur="2.25s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.25s" repeatCount="indefinite" begin="1.52s"/>
    </text><text x="39.60%" y="-10%" fill="#00F3FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="39.60%" dy="1.2em" opacity="0">
        ウ
        <animate attributeName="opacity" values="0;0.30;0" dur="4.50s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="39.60%" dy="1.2em" opacity="0">
        セ
        <animate attributeName="opacity" values="0;0.50;0" dur="4.50s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="39.60%" dy="1.2em" opacity="0">
        カ
        <animate attributeName="opacity" values="0;0.70;0" dur="4.50s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="39.60%" dy="1.2em" opacity="0">
        イ
        <animate attributeName="opacity" values="0;0.90;0" dur="4.50s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.50s" repeatCount="indefinite" begin="3.23s"/>
    </text><text x="41.80%" y="-10%" fill="#B967FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="41.80%" dy="1.2em" opacity="0">
        ≈
        <animate attributeName="opacity" values="0;0.30;0" dur="3.57s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="41.80%" dy="1.2em" opacity="0">
        ∇
        <animate attributeName="opacity" values="0;0.50;0" dur="3.57s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.57s" repeatCount="indefinite" begin="1.60s"/>
    </text><text x="44.00%" y="-10%" fill="#00FF41" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="44.00%" dy="1.2em" opacity="0">
        ∏
        <animate attributeName="opacity" values="0;0.30;0" dur="4.41s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="44.00%" dy="1.2em" opacity="0">
        ≈
        <animate attributeName="opacity" values="0;0.50;0" dur="4.41s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.41s" repeatCount="indefinite" begin="0.26s"/>
    </text><text x="46.20%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="46.20%" dy="1.2em" opacity="0">
        タ
        <animate attributeName="opacity" values="0;0.30;0" dur="4.21s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="46.20%" dy="1.2em" opacity="0">
        カ
        <animate attributeName="opacity" values="0;0.50;0" dur="4.21s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.21s" repeatCount="indefinite" begin="2.30s"/>
    </text><text x="48.40%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="48.40%" dy="1.2em" opacity="0">
        ∞
        <animate attributeName="opacity" values="0;0.30;0" dur="4.02s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="48.40%" dy="1.2em" opacity="0">
        ∫
        <animate attributeName="opacity" values="0;0.50;0" dur="4.02s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="48.40%" dy="1.2em" opacity="0">
        √
        <animate attributeName="opacity" values="0;0.70;0" dur="4.02s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="48.40%" dy="1.2em" opacity="0">
        ∞
        <animate attributeName="opacity" values="0;0.90;0" dur="4.02s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.02s" repeatCount="indefinite" begin="3.01s"/>
    </text><text x="50.60%" y="-10%" fill="#00FF41" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="50.60%" dy="1.2em" opacity="0">
        ≥
        <animate attributeName="opacity" values="0;0.30;0" dur="2.42s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.42s" repeatCount="indefinite" begin="3.77s"/>
    </text><text x="52.80%" y="-10%" fill="#B967FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="52.80%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.30;0" dur="3.38s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="52.80%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.50;0" dur="3.38s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="52.80%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.70;0" dur="3.38s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="52.80%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.90;0" dur="3.38s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.38s" repeatCount="indefinite" begin="0.49s"/>
    </text><text x="55.00%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="55.00%" dy="1.2em" opacity="0">
        ∏
        <animate attributeName="opacity" values="0;0.30;0" dur="4.90s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="55.00%" dy="1.2em" opacity="0">
        ≠
        <animate attributeName="opacity" values="0;0.50;0" dur="4.90s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="55.00%" dy="1.2em" opacity="0">
        ∞
        <animate attributeName="opacity" values="0;0.70;0" dur="4.90s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="55.00%" dy="1.2em" opacity="0">
        ∞
        <animate attributeName="opacity" values="0;0.90;0" dur="4.90s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.90s" repeatCount="indefinite" begin="1.18s"/>
    </text><text x="57.20%" y="-10%" fill="#B967FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="57.20%" dy="1.2em" opacity="0">
        イ
        <animate attributeName="opacity" values="0;0.30;0" dur="3.33s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="57.20%" dy="1.2em" opacity="0">
        サ
        <animate attributeName="opacity" values="0;0.50;0" dur="3.33s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="57.20%" dy="1.2em" opacity="0">
        サ
        <animate attributeName="opacity" values="0;0.70;0" dur="3.33s" begin="0.60s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.33s" repeatCount="indefinite" begin="0.49s"/>
    </text><text x="59.40%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="59.40%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.30;0" dur="4.40s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="59.40%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.50;0" dur="4.40s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="59.40%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.70;0" dur="4.40s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="59.40%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.90;0" dur="4.40s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.40s" repeatCount="indefinite" begin="2.26s"/>
    </text><text x="61.60%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="61.60%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.30;0" dur="2.42s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.42s" repeatCount="indefinite" begin="2.73s"/>
    </text><text x="63.80%" y="-10%" fill="#00FF41" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="63.80%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.30;0" dur="2.44s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.44s" repeatCount="indefinite" begin="2.90s"/>
    </text><text x="66.00%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="66.00%" dy="1.2em" opacity="0">
        セ
        <animate attributeName="opacity" values="0;0.30;0" dur="2.79s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="66.00%" dy="1.2em" opacity="0">
        セ
        <animate attributeName="opacity" values="0;0.50;0" dur="2.79s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="66.00%" dy="1.2em" opacity="0">
        タ
        <animate attributeName="opacity" values="0;0.70;0" dur="2.79s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="66.00%" dy="1.2em" opacity="0">
        ツ
        <animate attributeName="opacity" values="0;0.90;0" dur="2.79s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.79s" repeatCount="indefinite" begin="0.06s"/>
    </text><text x="68.20%" y="-10%" fill="#B967FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="68.20%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.30;0" dur="3.27s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="68.20%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.50;0" dur="3.27s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="68.20%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.70;0" dur="3.27s" begin="0.60s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.27s" repeatCount="indefinite" begin="1.18s"/>
    </text><text x="70.40%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="70.40%" dy="1.2em" opacity="0">
        √
        <animate attributeName="opacity" values="0;0.30;0" dur="3.73s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="70.40%" dy="1.2em" opacity="0">
        ∞
        <animate attributeName="opacity" values="0;0.50;0" dur="3.73s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.73s" repeatCount="indefinite" begin="0.19s"/>
    </text><text x="72.60%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="72.60%" dy="1.2em" opacity="0">
        カ
        <animate attributeName="opacity" values="0;0.30;0" dur="3.11s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.11s" repeatCount="indefinite" begin="0.55s"/>
    </text><text x="74.80%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="74.80%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.30;0" dur="2.52s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="74.80%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.50;0" dur="2.52s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="74.80%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.70;0" dur="2.52s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="74.80%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.90;0" dur="2.52s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.52s" repeatCount="indefinite" begin="2.39s"/>
    </text><text x="77.00%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="77.00%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.30;0" dur="2.64s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="77.00%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.50;0" dur="2.64s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.64s" repeatCount="indefinite" begin="0.05s"/>
    </text><text x="79.20%" y="-10%" fill="#B967FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="79.20%" dy="1.2em" opacity="0">
        ツ
        <animate attributeName="opacity" values="0;0.30;0" dur="2.40s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="79.20%" dy="1.2em" opacity="0">
        タ
        <animate attributeName="opacity" values="0;0.50;0" dur="2.40s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="79.20%" dy="1.2em" opacity="0">
        エ
        <animate attributeName="opacity" values="0;0.70;0" dur="2.40s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="79.20%" dy="1.2em" opacity="0">
        サ
        <animate attributeName="opacity" values="0;0.90;0" dur="2.40s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="2.40s" repeatCount="indefinite" begin="0.51s"/>
    </text><text x="81.40%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="81.40%" dy="1.2em" opacity="0">
        タ
        <animate attributeName="opacity" values="0;0.30;0" dur="3.90s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.90s" repeatCount="indefinite" begin="1.34s"/>
    </text><text x="83.60%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="83.60%" dy="1.2em" opacity="0">
        ⨒
        <animate attributeName="opacity" values="0;0.30;0" dur="4.38s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="83.60%" dy="1.2em" opacity="0">
        ⨝
        <animate attributeName="opacity" values="0;0.50;0" dur="4.38s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="83.60%" dy="1.2em" opacity="0">
        ⨊
        <animate attributeName="opacity" values="0;0.70;0" dur="4.38s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="83.60%" dy="1.2em" opacity="0">
        ⨓
        <animate attributeName="opacity" values="0;0.90;0" dur="4.38s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.38s" repeatCount="indefinite" begin="1.56s"/>
    </text><text x="85.80%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="85.80%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.30;0" dur="4.42s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.42s" repeatCount="indefinite" begin="3.37s"/>
    </text><text x="88.00%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="88.00%" dy="1.2em" opacity="0">
        ⨘
        <animate attributeName="opacity" values="0;0.30;0" dur="3.15s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.15s" repeatCount="indefinite" begin="1.45s"/>
    </text><text x="90.20%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="90.20%" dy="1.2em" opacity="0">
        タ
        <animate attributeName="opacity" values="0;0.30;0" dur="3.44s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="90.20%" dy="1.2em" opacity="0">
        カ
        <animate attributeName="opacity" values="0;0.50;0" dur="3.44s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.44s" repeatCount="indefinite" begin="1.23s"/>
    </text><text x="92.40%" y="-10%" fill="#FFF000" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="92.40%" dy="1.2em" opacity="0">
        ス
        <animate attributeName="opacity" values="0;0.30;0" dur="3.35s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="92.40%" dy="1.2em" opacity="0">
        ス
        <animate attributeName="opacity" values="0;0.50;0" dur="3.35s" begin="0.30s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.35s" repeatCount="indefinite" begin="3.77s"/>
    </text><text x="94.60%" y="-10%" fill="#00FF41" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="94.60%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.30;0" dur="3.14s" begin="0.00s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="3.14s" repeatCount="indefinite" begin="2.05s"/>
    </text><text x="96.80%" y="-10%" fill="#FF00FF" font-family="monospace" font-size="0.65rem" font-weight="bold">
      <tspan x="96.80%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.30;0" dur="4.92s" begin="0.00s" repeatCount="indefinite"/>
      </tspan><tspan x="96.80%" dy="1.2em" opacity="0">
        0
        <animate attributeName="opacity" values="0;0.50;0" dur="4.92s" begin="0.30s" repeatCount="indefinite"/>
      </tspan><tspan x="96.80%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.70;0" dur="4.92s" begin="0.60s" repeatCount="indefinite"/>
      </tspan><tspan x="96.80%" dy="1.2em" opacity="0">
        1
        <animate attributeName="opacity" values="0;0.90;0" dur="4.92s" begin="0.90s" repeatCount="indefinite"/>
      </tspan>
      <animate attributeName="y" values="-10%;110%" dur="4.92s" repeatCount="indefinite" begin="2.04s"/>
    </text></svg>
  <svg width="100%" height="100%" style="position:absolute;top:0;left:0;z-index:1;opacity:0.8;"><line x1="0%" y1="0%" x2="0%" y2="100%" stroke="#00f3ff" stroke-opacity="0.05">
      <animate attributeName="stroke-opacity" values="0.05;0.15000000000000002;0.05" dur="4s" repeatCount="indefinite"/>
    </line><line x1="0%" y1="0%" x2="100%" y2="0%" stroke="#ff00ff" stroke-opacity="0.05">
      <animate attributeName="stroke-opacity" values="0.05;0.15000000000000002;0.05" dur="3s" repeatCount="indefinite"/>
    </line><line x1="12%" y1="0%" x2="12%" y2="100%" stroke="#00f3ff" stroke-opacity="0.068">
      <animate attributeName="stroke-opacity" values="0.068;0.20400000000000001;0.068" dur="4s" repeatCount="indefinite"/>
    </line><line x1="0%" y1="12%" x2="100%" y2="12%" stroke="#ff00ff" stroke-opacity="0.068">
      <animate attributeName="stroke-opacity" values="0.068;0.20400000000000001;0.068" dur="3s" repeatCount="indefinite"/>
    </line><line x1="24%" y1="0%" x2="24%" y2="100%" stroke="#00f3ff" stroke-opacity="0.086">
      <animate attributeName="stroke-opacity" values="0.086;0.258;0.086" dur="4s" repeatCount="indefinite"/>
    </line><line x1="0%" y1="24%" x2="100%" y2="24%" stroke="#ff00ff" stroke-opacity="0.086">
      <animate attributeName="stroke-opacity" values="0.086;0.258;0.086" dur="3s" repeatCount="indefinite"/>
    </line><line x1="36%" y1="0%" x2="36%" y2="100%" stroke="#00f3ff" stroke-opacity="0.10400000000000001">
      <animate attributeName="stroke-opacity" values="0.10400000000000001;0.31200000000000006;0.10400000000000001" dur="4s" repeatCount="indefinite"/>
    </line><line x1="0%" y1="36%" x2="100%" y2="36%" stroke="#ff00ff" stroke-opacity="0.10400000000000001">
      <animate attributeName="stroke-opacity" values="0.10400000000000001;0.31200000000000006;0.10400000000000001" dur="3s" repeatCount="indefinite"/>
    </line><line x1="48%" y1="0%" x2="48%" y2="100%" stroke="#00f3ff" stroke-opacity="0.122">
      <animate attributeName="stroke-opacity" values="0.122;0.366;0.122" dur="4s" repeatCount="indefinite"/>
    </line><line x1="0%" y1="48%" x2="100%" y2="48%" stroke="#ff00ff" stroke-opacity="0.122">
      <animate attributeName="stroke-opacity" values="0.122;0.366;0.122" dur="3s" repeatCount="indefinite"/>
    </line><line x1="60%" y1="0%" x2="60%" y2="100%" stroke="#00f3ff" stroke-opacity="0.14">
      <animate attributeName="stroke-opacity" values="0.14;0.42000000000000004;0.14" dur="4s" repeatCount="indefinite"/>
    </line><line x1="0%" y1="60%" x2="100%" y2="60%" stroke="#ff00ff" stroke-opacity="0.14">
      <animate attributeName="stroke-opacity" values="0.14;0.42000000000000004;0.14" dur="3s" repeatCount="indefinite"/>
    </line><line x1="72%" y1="0%" x2="72%" y2="100%" stroke="#00f3ff" stroke-opacity="0.158">
      <animate attributeName="stroke-opacity" values="0.158;0.474;0.158" dur="4s" repeatCount="indefinite"/>
    </line><line x1="0%" y1="72%" x2="100%" y2="72%" stroke="#ff00ff" stroke-opacity="0.158">
      <animate attributeName="stroke-opacity" values="0.158;0.474;0.158" dur="3s" repeatCount="indefinite"/>
    </line><line x1="84%" y1="0%" x2="84%" y2="100%" stroke="#00f3ff" stroke-opacity="0.176">
      <animate attributeName="stroke-opacity" values="0.176;0.528;0.176" dur="4s" repeatCount="indefinite"/>
    </line><line x1="0%" y1="84%" x2="100%" y2="84%" stroke="#ff00ff" stroke-opacity="0.176">
      <animate attributeName="stroke-opacity" values="0.176;0.528;0.176" dur="3s" repeatCount="indefinite"/>
    </line><line x1="96%" y1="0%" x2="96%" y2="100%" stroke="#00f3ff" stroke-opacity="0.194">
      <animate attributeName="stroke-opacity" values="0.194;0.5820000000000001;0.194" dur="4s" repeatCount="indefinite"/>
    </line><line x1="0%" y1="96%" x2="100%" y2="96%" stroke="#ff00ff" stroke-opacity="0.194">
      <animate attributeName="stroke-opacity" values="0.194;0.5820000000000001;0.194" dur="3s" repeatCount="indefinite"/>
    </line><circle cx="50%" cy="50%" r="15%" fill="none" stroke="#b967ff" stroke-opacity="0.1" stroke-width="0.5">
      <animate attributeName="r" values="13%;17%;13%" dur="5s" repeatCount="indefinite"/>
    </circle><circle cx="50%" cy="50%" r="30%" fill="none" stroke="#b967ff" stroke-opacity="0.1" stroke-width="0.5">
      <animate attributeName="r" values="28%;32%;28%" dur="6s" repeatCount="indefinite"/>
    </circle><circle cx="50%" cy="50%" r="45%" fill="none" stroke="#b967ff" stroke-opacity="0.1" stroke-width="0.5">
      <animate attributeName="r" values="43%;47%;43%" dur="7s" repeatCount="indefinite"/>
    </circle></svg>
  <svg width="100%" height="100%" style="position:absolute;top:0;left:0;z-index:1;opacity:0.6;">
    <g transform="translate(66.02224174314975, 61.04080842945885)">
      <rect x="-15" y="-10" width="30" height="20" rx="3" fill="#0a0a0f" stroke="#00f3ff" stroke-width="1" opacity="0.8">
        <animate attributeName="stroke" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="0s"/>
      </rect>
      <text text-anchor="middle" dominant-baseline="middle" fill="#00f3ff" font-family="monospace" font-size="10" font-weight="bold">
        H
        <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="0s"/>
      </text>
    </g>
    <g transform="translate(53.02167497426083, 32.58906656014107)">
      <rect x="-15" y="-10" width="30" height="20" rx="3" fill="#0a0a0f" stroke="#00f3ff" stroke-width="1" opacity="0.8">
        <animate attributeName="stroke" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="0.5s"/>
      </rect>
      <text text-anchor="middle" dominant-baseline="middle" fill="#00f3ff" font-family="monospace" font-size="10" font-weight="bold">
        X
        <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="0.5s"/>
      </text>
    </g>
    <g transform="translate(44.10539452899266, 64.42888184513241)">
      <rect x="-15" y="-10" width="30" height="20" rx="3" fill="#0a0a0f" stroke="#00f3ff" stroke-width="1" opacity="0.8">
        <animate attributeName="stroke" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="1s"/>
      </rect>
      <text text-anchor="middle" dominant-baseline="middle" fill="#00f3ff" font-family="monospace" font-size="10" font-weight="bold">
        Y
        <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="1s"/>
      </text>
    </g>
    <g transform="translate(64.57382671789951, 64.13208498140528)">
      <rect x="-15" y="-10" width="30" height="20" rx="3" fill="#0a0a0f" stroke="#00f3ff" stroke-width="1" opacity="0.8">
        <animate attributeName="stroke" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="1.5s"/>
      </rect>
      <text text-anchor="middle" dominant-baseline="middle" fill="#00f3ff" font-family="monospace" font-size="10" font-weight="bold">
        Z
        <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="1.5s"/>
      </text>
    </g>
    <g transform="translate(65.36631240552977, 53.590737642600246)">
      <rect x="-15" y="-10" width="30" height="20" rx="3" fill="#0a0a0f" stroke="#00f3ff" stroke-width="1" opacity="0.8">
        <animate attributeName="stroke" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="2s"/>
      </rect>
      <text text-anchor="middle" dominant-baseline="middle" fill="#00f3ff" font-family="monospace" font-size="10" font-weight="bold">
        CNOT
        <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="2s"/>
      </text>
    </g>
    <g transform="translate(77.87012008269048, 35.819104304945554)">
      <rect x="-15" y="-10" width="30" height="20" rx="3" fill="#0a0a0f" stroke="#00f3ff" stroke-width="1" opacity="0.8">
        <animate attributeName="stroke" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="2.5s"/>
      </rect>
      <text text-anchor="middle" dominant-baseline="middle" fill="#00f3ff" font-family="monospace" font-size="10" font-weight="bold">
        SWAP
        <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="2.5s"/>
      </text>
    </g>
    <g transform="translate(27.55125651022217, 56.51393325856917)">
      <rect x="-15" y="-10" width="30" height="20" rx="3" fill="#0a0a0f" stroke="#00f3ff" stroke-width="1" opacity="0.8">
        <animate attributeName="stroke" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="3s"/>
      </rect>
      <text text-anchor="middle" dominant-baseline="middle" fill="#00f3ff" font-family="monospace" font-size="10" font-weight="bold">
        T
        <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="3s"/>
      </text>
    </g>
    <g transform="translate(24.21465451363149, 21.877852046134592)">
      <rect x="-15" y="-10" width="30" height="20" rx="3" fill="#0a0a0f" stroke="#00f3ff" stroke-width="1" opacity="0.8">
        <animate attributeName="stroke" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="3.5s"/>
      </rect>
      <text text-anchor="middle" dominant-baseline="middle" fill="#00f3ff" font-family="monospace" font-size="10" font-weight="bold">
        S
        <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="3.5s"/>
      </text>
    </g></svg>
  
  <div style="position:absolute;top:2rem;left:2rem;z-index:3;display:flex;flex-direction:column;gap:1rem;">
    <div class="profile-card" style="background:rgba(10,10,15,0.8);padding:1rem;border-radius:10px;border:1px solid #00f3ff;backdrop-filter:blur(10px);min-width:200px;">
      <div style="display:flex;align-items:center;gap:0.5rem;margin-bottom:0.5rem;">
        <div style="width:8px;height:8px;background:#00ff41;border-radius:50%;"></div>
        <span style="font-family:'Ubuntu Mono',monospace;color:#00f3ff;font-size:0.8rem;">GITHUB STATS</span>
      </div>
      <div style="color:#ff00ff;font-family:'Ubuntu Mono',monospace;font-size:0.7rem;">
        <div>📊 Followers: <span style="color:#00ff41;">growing</span></div>
        <div>⭐ Stars: <span style="color:#00ff41;">rising</span></div>
        <div>📚 Repos: <span style="color:#00ff41;">active</span></div>
      </div>
    </div>
    <div class="profile-card" style="background:rgba(10,10,15,0.8);padding:1rem;border-radius:10px;border:1px solid #ff00ff;backdrop-filter:blur(10px);min-width:200px;">
      <div style="display:flex;align-items:center;gap:0.5rem;margin-bottom:0.5rem;">
        <div style="width:8px;height:8px;background:#b967ff;border-radius:50%;"></div>
        <span style="font-family:'Ubuntu Mono',monospace;color:#ff00ff;font-size:0.8rem;">CODING ACTIVITY</span>
      </div>
      <div style="color:#00f3ff;font-family:'Ubuntu Mono',monospace;font-size:0.7rem;">
        <div>🔄 Current: Quantum Scripts</div>
        <div>📈 Focus: DevOps & Automation</div>
        <div>🎯 Learning: Advanced K8s</div>
      </div>
    </div>
  </div>
  
  <div style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);z-index:3;text-align:center;">
    <div style="background:rgba(10,10,15,0.9);padding:2rem;border-radius:15px;border:1px solid #00f3ff;box-shadow:0 0 30px rgba(0,243,255,0.3);backdrop-filter:blur(10px);">
      <a href="https://git.io/typing-svg" style="text-decoration:none;">
        <img 
          src="https://readme-typing-svg.herokuapp.com?font=Ubuntu+Mono&weight=600&size=22&duration=2000&pause=500&color=00F3FF&background=0a0a0f00&center=true&vCenter=true&width=550&height=80&lines=ℌ𝔢𝔩𝔩𝔬+𝔗𝔥𝔢𝔯𝔢;ℑ'𝔪+ɬɧɛ+ɠıɬƈɧ;𝔚𝔢𝔩𝔠𝔬𝔪𝔢+𝔱𝔬+𝔪𝔶+𝔮𝔲𝔞𝔫𝔱𝔲𝔪+𝔯𝔢𝔞𝔩𝔪;𝔖𝔥𝔢𝔩𝔩+𝔖𝔠𝔯𝔦𝔭𝔱+𝔈𝔫𝔱𝔥𝔲𝔰𝔦𝔞𝔰𝔱;𝔏𝔦𝔫𝔲𝔵+%26+𝔇𝔢𝔳𝔒𝔭𝔰+𝔈𝔵𝔭𝔩𝔬𝔯𝔢𝔯;𝔒𝔭𝔢𝔫+𝔖𝔬𝔲𝔯𝔠𝔢+ℭ𝔬𝔫𝔱𝔯𝔦𝔟𝔲𝔱𝔬𝔯;𝔄𝔩𝔴𝔞𝔶𝔰+𝔏𝔢𝔞𝔯𝔫𝔦𝔫𝔤+%F0%9F%92%A1" 
          alt="Cyberpunk Typing Animation"
          style="filter: drop-shadow(0 0 15px rgba(0,243,255,0.7)) drop-shadow(0 0 25px rgba(0,243,255,0.4));"
        />
      </a>
      <div style="margin-top:1rem;font-family:'Ubuntu Mono',monospace;font-size:0.8rem;color:#ff00ff;">
        <span style="color:#00f3ff;">//</span> Quantum Developer | Cyberpunk Architect
      </div>
    </div>
  </div>
  
  <div style="position:absolute;bottom:2rem;right:2rem;z-index:3;display:flex;gap:1rem;">
    <a href="https://github.com/Thugger069" style="text-decoration:none;">
      <div class="social-btn" style="background:rgba(0,243,255,0.1);padding:0.5rem 1rem;border-radius:25px;border:1px solid #00f3ff;color:#00f3ff;font-family:'Ubuntu Mono',monospace;font-size:0.8rem;transition:all 0.3s ease;display:flex;align-items:center;gap:0.5rem;">
        <span>🐙</span> GitHub
      </div>
    </a>
    <a href="https://twitter.com/yourhandle" style="text-decoration:none;">
      <div class="social-btn" style="background:rgba(255,0,255,0.1);padding:0.5rem 1rem;border-radius:25px;border:1px solid #ff00ff;color:#ff00ff;font-family:'Ubuntu Mono',monospace;font-size:0.8rem;transition:all 0.3s ease;display:flex;align-items:center;gap:0.5rem;">
        <span>🐦</span> Twitter
      </div>
    </a>
    <a href="https://linkedin.com/in/yourprofile" style="text-decoration:none;">
      <div class="social-btn" style="background:rgba(185,103,255,0.1);padding:0.5rem 1rem;border-radius:25px;border:1px solid #b967ff;color:#b967ff;font-family:'Ubuntu Mono',monospace;font-size:0.8rem;transition:all 0.3s ease;display:flex;align-items:center;gap:0.5rem;">
        <span>💼</span> LinkedIn
      </div>
    </a>
  </div>
  <div style="position:absolute;bottom:1rem;left:2rem;z-index:3;font-family:'Ubuntu Mono',monospace;font-size:0.7rem;color:#00ff41;">
    <span style="color:#ff00ff;">▶</span> SYSTEM: <span style="color:#00f3ff;">QUANTUM_READY</span> | UPDATED: Wed, 15 Oct 2025 07:35:37 UTC
  </div>
  <div style="position:absolute;top:0;left:0;width:100%;height:100%;background:repeating-linear-gradient(0deg, rgba(0,0,0,0) 0px, rgba(0,0,0,0) 1px, rgba(0,243,255,0.03) 2px, rgba(0,0,0,0) 3px);z-index:2;pointer-events:none;"></div>
</div>

<style>
  @keyframes borderFlow {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
  }
  .cyber-container:hover {
    box-shadow: 0 0 60px rgba(0,243,255,0.4), inset 0 0 40px rgba(0,243,255,0.2);
    transform: translateY(-3px);
    transition: all 0.3s ease;
  }
  .profile-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 0 20px rgba(0,243,255,0.3);
    transition: all 0.3s ease;
  }
  .social-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 0 15px currentColor;
    background: rgba(255,255,255,0.1) !important;
    transition: all 0.3s ease;
  }
</style>
