// scripts/generate-terminal-svg.js
const fs = require('fs');

const DIST_DIR = 'dist';
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR);

const username = "𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ";
const currentTime = new Date().toISOString().replace("T", " ").split(".")[0];

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
`;

const svg = `
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 260" width="100%" height="260">
  <defs>
    <linearGradient id="neon" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#00fff0">
        <animate attributeName="stop-color" values="#00fff0;#ff00ff;#00fff0" dur="6s" repeatCount="indefinite"/>
      </stop>
      <stop offset="100%" stop-color="#ff00ff">
        <animate attributeName="stop-color" values="#ff00ff;#00fff0;#ff00ff" dur="6s" repeatCount="indefinite"/>
      </stop>
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="2.5" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <rect x="10" y="10" width="780" height="240" rx="12" fill="#0d0d0d" filter="url(#glow)"/>
  
  <foreignObject x="20" y="20" width="760" height="220">
    <div xmlns="http://www.w3.org/1999/xhtml" style="font-family:'Fira Code', monospace; font-size:16px; color:#00fff0; white-space:pre; overflow:hidden;">
      <span style="display:inline-block; animation: typing 4s steps(${terminalContent.length}, end) 1;">${terminalContent}</span>
      <span style="color:#00fff0; animation: blink 1s steps(1) infinite;">█</span>
    </div>
  </foreignObject>

  <style>
    @keyframes typing {
      from { width: 0 }
      to { width: ${terminalContent.length}ch; }
    }
    @keyframes blink {
      0%,49% { opacity:1 }
      50%,100% { opacity:0 }
    }
    @media (prefers-color-scheme: light) {
      rect { fill: #ffffff; }
      div { color: #0d0d0d; }
    }
  </style>
</svg>
`;

fs.writeFileSync(`${DIST_DIR}/terminal.svg`, svg.trim());
console.log("✅ Terminal SVG generated with typewriter effect & neon animation.");