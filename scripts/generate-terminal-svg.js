const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const username = process.env.USERNAME || "𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ";
const currentTime = new Date().toISOString().replace('T', ' ').split('.')[0];

const terminalContent = `
Last login: ${currentTime} on ttys000
${username}@github ~ % uptime
${currentTime} up 02:51, 1 user, load average: 0.56 0.62 0.48

${username}@github ~ % ls -la Projects/
total 40
drwxr-xr-x  8 ${username}  staff  256 May 07 02:51 .
drwxr-xr-x  5 ${username}  staff  160 May 07 02:51 ..
drwxr-xr-x  7 ${username}  staff  224 May 07 02:51 DevOps
drwxr-xr-x  6 ${username}  staff  192 May 07 02:51 OpenSource
drwxr-xr-x  5 ${username}  staff  160 May 07 02:51 Scripts
-rw-r--r--  1 ${username}  staff  925 May 07 02:51 TODO.md

${username}@github ~ % cat Projects/TODO.md
# ℭ𝔲𝔯𝔯𝔢𝔫𝔱 𝔓𝔯𝔬𝔧𝔢𝔠𝔱𝔰 📋

→ Automating deployment workflows
→ Contributing to open source
→ Learning Kubernetes
→ Building shell script utilities
`;

const lines = terminalContent.split('\n');

const svg = `
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 ${lines.length * 22 + 40}" width="100%" height="${lines.length * 22 + 40}">
  <defs>
    <filter id="glow">
      <feGaussianBlur stdDeviation="2" result="blur1"/>
      <feMerge>
        <feMergeNode in="blur1"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <!-- Background -->
  <rect x="0" y="0" width="800" height="${lines.length * 22 + 40}" rx="16" fill="#0d0d0d" filter="url(#glow)"/>

  <!-- Terminal text -->
  <text x="20" y="30" font-family="Fira Code, monospace" font-size="18" fill="#00fff0">
    ${lines.map((line, i) => `<tspan x="20" dy="${i === 0 ? 0 : 22}">${line.replace(/&/g, '&amp;')}</tspan>`).join('')}
  </text>

  <!-- Blinking cursor -->
  <text x="20" y="${lines.length * 22 + 10}" font-family="Fira Code, monospace" font-size="18" fill="#00fff0">
    <tspan class="cursor">█</tspan>
    <animate attributeName="opacity" values="1;0;1" dur="1s" repeatCount="indefinite"/>
  </text>

  <style>
    @media (prefers-color-scheme: light) {
      rect { fill: #f5f5f5; filter: none; }
      text { fill: #0d0d0d; }
    }
  </style>
</svg>
`;

fs.writeFileSync(path.join(DIST_DIR, 'terminal.svg'), svg.trim());
console.log("✅ Terminal SVG updated with neon cyberpunk style!");