const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

// Fake terminal content
const terminalContent = `
Last login: ${new Date().toUTCString()} on ttys000
𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ@github ~ % uptime
  ${new Date().toUTCString()} up 02:51, 1 user, load average: 0.56 0.62 0.48

𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ@github ~ % ls -la Projects/
total 40
drwxr-xr-x  8 𖢧ꛅ𖤢  staff  256 May 07 02:51 .
drwxr-xr-x  5 𖢧ꛅ𖤢  staff  160 May 07 02:51 ..
drwxr-xr-x  7 𖢧ꛅ𖤢  staff  224 May 07 02:51 DevOps
drwxr-xr-x  6 𖢧ꛅ𖤢  staff  192 May 07 02:51 OpenSource
-rw-r--r--  1 𖢧ꛅ𖤢  staff  925 May 07 02:51 TODO.md
`;

// Clean escape chars
const escapedContent = terminalContent
  .replace(/&/g, "&amp;")
  .replace(/</g, "&lt;")
  .replace(/>/g, "&gt;");

const svg = `
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 300" width="100%" height="300">
  <style>
    .bg { fill: #0d0d0d; rx: 16; filter: url(#glow); }
    .text { 
      font-family: 'Fira Code', monospace; 
      font-size: 14px; 
      fill: url(#neon-gradient);
      white-space: pre; 
    }
    .cursor { 
      fill: #39FF14; 
      animation: blink 1s steps(1) infinite; 
    }
    @keyframes blink { 0%,49%{opacity:1;}50%,100%{opacity:0;} }
    @media (prefers-color-scheme: light) {
      .bg { fill: #ffffff; }
      .text { fill: url(#neon-gradient-light); }
    }
  </style>
  <defs>
    <linearGradient id="neon-gradient" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#39FF14"/>
      <stop offset="50%" stop-color="#00FFF0"/>
      <stop offset="100%" stop-color="#FF00FF"/>
    </linearGradient>
    <linearGradient id="neon-gradient-light" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#0d0d0d"/>
      <stop offset="50%" stop-color="#333"/>
      <stop offset="100%" stop-color="#555"/>
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="3" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <rect x="0" y="0" width="800" height="300" class="bg"/>
  <text x="20" y="30" class="text">
${escapedContent}
  </text>
  <text x="20" y="30" class="cursor">█</text>
</svg>
`;

fs.writeFileSync(path.join(DIST_DIR, 'terminal.svg'), svg.trim());
console.log("✅ Enhanced terminal SVG generated with neon cyberpunk style.");