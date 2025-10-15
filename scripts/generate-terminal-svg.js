#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

// Paths
const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

// Metadata
const DISPLAY_NAME = "ɬɧɛ ɠıɬƈɧ";
const GITHUB_USERNAME = "Thugger069";
const CURRENT_TIME = new Date().toUTCString().replace(/GMT/, 'UTC');

// Generate dynamic load averages
const load1 = (Math.random() * 0.8 + 0.1).toFixed(2);
const load2 = (Math.random() * 0.8 + 0.2).toFixed(2);
const load3 = (Math.random() * 0.8 + 0.1).toFixed(2);
const LOAD_AVG = `${load1} ${load2} ${load3}`;

// Terminal content lines
const lines = [
  `Last login: ${CURRENT_TIME} on ttys001`,
  `${DISPLAY_NAME}@github ~ % whoami`,
  `${DISPLAY_NAME}`,
  '',
  `${DISPLAY_NAME}@github ~ % uname -a`,
  `Darwin github-pro 22.5.0 Darwin Kernel Version 22.5.0: x86_64`,
  '',
  `${DISPLAY_NAME}@github ~ % uptime`,
  `${CURRENT_TIME} up 14 days, 2:51, 1 user, load averages: ${LOAD_AVG}`,
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

// Themes
const darkTheme = {
  background: '#1a1b26',
  text: '#c0caf5',
  accent: '#7dcfff',
  border: '#2ac3de',
  headerBg: '#16161e'
};

const lightTheme = {
  background: '#ffffff',
  text: '#333333',
  accent: '#0366d6',
  border: '#d1d5da',
  headerBg: '#f6f8fa'
};

// Layout
const LINE_HEIGHT = 18;
const PADDING = 20;
const height = lines.length * LINE_HEIGHT + PADDING * 2 + 30;
const maxLineLength = Math.max(...lines.map(line => line.length));
const CHAR_WIDTH = 8;
const width = Math.max(800, maxLineLength * CHAR_WIDTH + PADDING * 2);

// Function to generate SVG string
function generateSVG(themeColors) {
  const { background, text, accent, border, headerBg } = themeColors;

  const svg = `<svg width="${width}" height="${height}" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bgGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="${background}" />
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

  <rect width="100%" height="100%" rx="12" ry="12" fill="url(#bgGradient)" stroke="${border}" stroke-width="2" filter="url(#glow)"/>
  <rect x="0" y="0" width="100%" height="30" rx="12" ry="12" fill="${headerBg}" stroke="${border}" stroke-width="2"/>
  <circle cx="15" cy="15" r="4" fill="#ff5f56"/>
  <circle cx="30" cy="15" r="4" fill="#ffbd2e"/>
  <circle cx="45" cy="15" r="4" fill="#27ca3f"/>
  <text x="60" y="18" style="font-family: 'Monaco','Consolas',monospace;font-size:12px;fill:${text};font-weight:bold;">${DISPLAY_NAME}@github: ~</text>

  <style>
    .line { font-family:'Monaco','Consolas','Courier New',monospace;font-size:14px;fill:${text};white-space:pre; }
    .accent { fill:${accent}; font-weight:bold; }
  </style>

  ${lines.map((line, idx) => `<text x="${PADDING}" y="${PADDING + 30 + idx * LINE_HEIGHT}" class="line">${line}</text>`).join('')}

  <text x="${PADDING}" y="${PADDING + 30 + (lines.length - 1) * LINE_HEIGHT + 4}" class="accent">█
    <animate attributeName="opacity" values="1;0;1" dur="1s" repeatCount="indefinite"/>
  </text>

  <text x="${PADDING}" y="${height - 10}" class="line" fill="${accent}" font-size="12">
    Last updated: ${CURRENT_TIME}
  </text>
</svg>`;

  return svg;
}

// Write SVG files
fs.writeFileSync(path.join(DIST_DIR, 'terminal.svg'), generateSVG(darkTheme));
fs.writeFileSync(path.join(DIST_DIR, 'terminal-light.svg'), generateSVG(lightTheme));

console.log("✅ Enhanced terminal SVGs generated!");
console.log(`📁 Files: ${DIST_DIR}/terminal.svg, ${DIST_DIR}/terminal-light.svg`);