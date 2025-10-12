// scripts/generate-terminal-svg.js
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';
const fs = require('fs');

const DIST_DIR = 'dist';
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR);

// Terminal content
const TERMINAL_LINES = [
  "Last login: 𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ on ttys000",
  "𖢧ꛅꛅ@github ~ % uptime",
  " 02:51 up 2 users, load average: 0.56 0.62 0.48",
  "𖢧ꛅꛅ@github ~ % ls -la Projects/",
  "total 40",
  "drwxr-xr-x  8 𖢧ꛅꛅ  staff  256 May 07 02:51 .",
  "drwxr-xr-x  5 𖢧ꛅꛅ  staff  160 May 07 02:51 ..",
  "drwxr-xr-x  7 𖢧ꛅꛅ  staff  224 May 07 02:51 DevOps",
  "drwxr-xr-x  6 𖢧ꛅꛅ  staff  192 May 07 02:51 OpenSource",
  "drwxr-xr-x  5 𖢧ꛅꛅ  staff  160 May 07 02:51 Scripts",
  "-rw-r--r--  1 𖢧ꛅꛅ  staff  925 May 07 02:51 TODO.md",
  "𖢧ꛅꛅ@github ~ % cat Projects/TODO.md",
  "# ℭ𝔲𝔯𝔯𝔢𝔫𝔱 𝔓𝔯𝔬𝔧𝔢𝔠𝔱𝔰 📋",
  "→ Automating deployment workflows",
  "→ Contributing to open source",
  "→ Learning Kubernetes",
  "→ Building shell script utilities"
];

const TERMINAL_TEXT = TERMINAL_LINES.join('\n');
const CHAR_COUNT = TERMINAL_TEXT.length;

// Neon gradient animation
const svg = `
<svg viewBox="0 0 800 320" width="100%" height="320" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="neon" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#00ffea">
        <animate attributeName="stop-color" values="#00ffea;#ff00ff;#00ffea" dur="10s" repeatCount="indefinite"/>
      </stop>
      <stop offset="100%" stop-color="#ff00ff">
        <animate attributeName="stop-color" values="#ff00ff;#00ffea;#ff00ff" dur="10s" repeatCount="indefinite"/>
      </stop>
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="2.5" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <rect x="0" y="0" width="800" height="320" fill="#0d0d0d" rx="16"/>

  <text x="20" y="40" font-family="Fira Code, monospace" font-size="16" fill="url(#neon)" filter="url(#glow)">
    <tspan class="typing">
      ${TERMINAL_TEXT.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;")}
    </tspan>
    <tspan class="cursor">█</tspan>
  </text>

  <style>
    .cursor { animation: blink 1s steps(1) infinite; }
    @keyframes blink { 0%,49% { opacity:1 } 50%,100% { opacity:0 } }

    .typing {
      overflow: hidden;
      white-space: pre;
      display: inline-block;
      animation: typing 6s steps(${CHAR_COUNT}, end) 1 forwards;
    }

    @keyframes typing { from { width:0 } to { width:${CHAR_COUNT}ch } }
    
    @media (prefers-color-scheme: light) {
      rect { fill: #fff; }
      text { fill: url(#neon); filter: url(#glow); }
    }
  </style>
</svg>
`;

fs.writeFileSync(`${DIST_DIR}/terminal.svg`, svg.trim());
console.log("✅ Terminal SVG with typewriter & neon gradient saved!");