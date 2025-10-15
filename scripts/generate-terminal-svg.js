const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const DISPLAY_NAME = "ɬɧɛ ɠıɬƈɧ";
const GITHUB_USERNAME = "Thugger069";
const CURRENT_TIME = new Date().toUTCString().replace(/GMT/, 'UTC');

// Enhanced terminal content
const lines = [
  `Last login: ${CURRENT_TIME} on ttys001`,
  `${DISPLAY_NAME}@github ~ % whoami`,
  `${DISPLAY_NAME}`,
  '',
  `${DISPLAY_NAME}@github ~ % uname -a`,
  `Darwin github-pro 22.5.0 Darwin Kernel Version 22.5.0: x86_64`,
  '',
  `${DISPLAY_NAME}@github ~ % uptime`,
  `${CURRENT_TIME} up 14 days, 2:51, 1 user, load averages: 0.56 0.62 0.48`,
  '',
  `${DISPLAY_NAME}@github ~ % ls -la Projects/`,
  `total 48`,
  `drwxr-xr-x   9 ${DISPLAY_NAME}  staff   288 Jun 15 10:30 .`,
  `drwxr-xr-x   6 ${DISPLAY_NAME}  staff   192 Jun 15 10:30 ..`,
  `drwxr-xr-x   8 ${DISPLAY_NAME}  staff   256 Jun 15 10:30 .git`,
  `-rw-r--r--   1 ${DISPLAY_NAME}  staff   113 Jun 15 10:30 .gitignore`,
  `drwxr-xr-x   7 ${DISPLAY_NAME}  staff   224 Jun 15 10:30 DevOps`,
  `drwxr-xr-x   6 ${DISPLAY_NAME}  staff   192 Jun 15 10:30 OpenSource`,
  `drwxr-xr-x   5 ${DISPLAY_NAME}  staff   160 Jun 15 10:30 Scripts`,
  `-rw-r--r--   1 ${DISPLAY_NAME}  staff  1024 Jun 15 10:30 README.md`,
  `-rw-r--r--   1 ${DISPLAY_NAME}  staff   925 Jun 15 10:30 TODO.md`,
  '',
  `${DISPLAY_NAME}@github ~ % cat Projects/TODO.md`,
  `# 📋 Current Projects`,
  `## 🚀 Active Development`,
  `- [ ] Kubernetes cluster autoscaling`,
  `- [ ] Terraform multi-cloud deployment`,
  `- [ ] CI/CD pipeline optimization`,
  '',
  `${DISPLAY_NAME}@github ~ % docker ps`,
  `CONTAINER ID   IMAGE           COMMAND                  STATUS       PORTS     NAMES`,
  `a1b2c3d4e5f6   nginx:alpine    "nginx -g 'daemon off;" Up 2 hours   80/tcp    webserver`,
  `f6e5d4c3b2a1   redis:7-alpine  "docker-entrypoint.s…"  Up 2 hours   6379/tcp  cache`,
  '',
  `${DISPLAY_NAME}@github ~ %`
];

// Cyberpunk theme (matches your GitHub style)
const theme = {
  background: '#1a1b26',
  text: '#c0caf5',
  accent: '#7dcfff',
  border: '#2ac3de',
  headerBg: '#16161e'
};

const LINE_HEIGHT = 18;
const PADDING = 20;
const height = lines.length * LINE_HEIGHT + PADDING * 2 + 30; // +30 for header
const maxLineLength = Math.max(...lines.map(line => line.length));
const CHAR_WIDTH = 8;
const width = Math.max(800, maxLineLength * CHAR_WIDTH + PADDING * 2);

const svgDark = `<svg width="${width}" height="${height}" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bgGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="${theme.background}" />
      <stop offset="100%" stop-color="#16161e" />
    </linearGradient>
    <filter id="glow" x="-20%" y="-20%" width="140%" height="140%">
      <feGaussianBlur stdDeviation="2" result="coloredBlur"/>
      <feMerge> 
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <!-- Terminal window -->
  <rect width="100%" height="100%" rx="12" ry="12" fill="url(#bgGradient)" 
        stroke="${theme.border}" stroke-width="2" filter="url(#glow)"/>
  
  <!-- Terminal header -->
  <rect x="0" y="0" width="100%" height="30" rx="12" ry="12" fill="${theme.headerBg}" 
        stroke="${theme.border}" stroke-width="2"/>
  <circle cx="15" cy="15" r="4" fill="#ff5f56"/>
  <circle cx="30" cy="15" r="4" fill="#ffbd2e"/>
  <circle cx="45" cy="15" r="4" fill="#27ca3f"/>
  <text x="60" y="18" style="font-family: 'Monaco', 'Consolas', monospace; font-size: 12px; fill: ${theme.text}; font-weight: bold;">${DISPLAY_NAME}@github: ~</text>
  
  <style>
    .line { 
      font-family: 'Monaco', 'Consolas', 'Courier New', monospace; 
      font-size: 14px; 
      fill: ${theme.text};
      white-space: pre;
    }
    .accent { 
      fill: ${theme.accent};
      font-weight: bold;
    }
  </style>
  
  <!-- Terminal content -->
  ${lines.map((line, idx) => 
    `<text x="${PADDING}" y="${PADDING + 30 + idx * LINE_HEIGHT}" class="line">${line}</text>`
  ).join('')}
  
  <!-- Blinking cursor -->
  <text x="${PADDING}" y="${PADDING + 30 + (lines.length - 1) * LINE_HEIGHT + 4}" 
        class="accent">█
    <animate attributeName="opacity" values="1;0;1" dur="1s" repeatCount="indefinite" />
  </text>
</svg>`;

// Light theme variant
const lightTheme = {
  background: '#ffffff',
  text: '#333333',
  accent: '#0366d6',
  border: '#d1d5da',
  headerBg: '#f6f8fa'
};

const svgLight = svgDark
  .replace(new RegExp(theme.background, 'g'), lightTheme.background)
  .replace(new RegExp(theme.text, 'g'), lightTheme.text)
  .replace(new RegExp(theme.accent, 'g'), lightTheme.accent)
  .replace(new RegExp(theme.border, 'g'), lightTheme.border)
  .replace(new RegExp(theme.headerBg, 'g'), lightTheme.headerBg);

// Write files
fs.writeFileSync(path.join(DIST_DIR, 'terminal.svg'), svgDark);
fs.writeFileSync(path.join(DIST_DIR, 'terminal-light.svg'), svgLight);

console.log("✅ Enhanced terminal SVGs generated!");
console.log("📁 Files: terminal.svg, terminal-light.svg");