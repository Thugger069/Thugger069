const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR);

const terminalLines = [
  "Last login: 𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ on ttys000",
  "🜂 Walking the Path Where Bits & Dreams Intersect ®",
  "user@github ~ % uptime",
  "user@github ~ % ls -la Projects/",
  "user@github ~ % cat Projects/TODO.md"
];

const neonColors = ["#39FF14", "#00FFF0", "#FF00FF", "#FFDD00"]; // cycling neon palette

// Generate typewriter content
const typingContent = terminalLines.map(line => `<span class="line">${line}</span>`).join("\n");

const svg = `
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="200">
  <defs>
    <linearGradient id="neonGradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="${neonColors[0]}" />
      <stop offset="50%" stop-color="${neonColors[1]}" />
      <stop offset="100%" stop-color="${neonColors[2]}" />
      <animate attributeName="x1" values="0%;100%;0%" dur="10s" repeatCount="indefinite"/>
      <animate attributeName="x2" values="100%;0%;100%" dur="10s" repeatCount="indefinite"/>
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="2.5" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  <rect x="0" y="0" width="800" height="200" fill="#0d0d0d" rx="12"/>
  <foreignObject x="20" y="20" width="760" height="160">
    <div xmlns="http://www.w3.org/1999/xhtml" style="font-family: 'Fira Code', monospace; font-size: 16px; color: url(#neonGradient); filter: url(#glow); white-space: pre;">
      <span class="typing">${terminalLines.join("\n")}</span>
      <span class="cursor">█</span>
    </div>
  </foreignObject>
  <style>
    .cursor {
      animation: blink 1s steps(1) infinite;
    }
    @keyframes blink {
      0%,49% { opacity:1; } 50%,100% { opacity:0; }
    }
    .typing {
      animation: typing ${terminalLines.join("\n").length/2}s steps(${terminalLines.join("\n").length}, end) 1;
      overflow: hidden;
      white-space: pre;
      display: inline-block;
    }
    @keyframes typing {
      from { width: 0; } to { width: 100%; }
    }
  </style>
</svg>
`;

fs.writeFileSync(path.join(DIST_DIR, 'terminal.svg'), svg);
console.log("✅ Neon typewriter terminal SVG generated!");