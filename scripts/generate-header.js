// scripts/generate-header.js
const fs = require('fs');

const DIST_DIR = 'dist';
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR);

const username = "𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ";
const tagline = "• Walking The Path Where Bits & Dreams Intersect ®";
const sig = "卞廾凵呂呂ヨ尺.と己し. 魔大帝";

const svg = `
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 180" width="100%" height="180">
  <defs>
    <linearGradient id="neonGradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#00fff0">
        <animate attributeName="stop-color" values="#00fff0;#ff00ff;#00fff0" dur="8s" repeatCount="indefinite"/>
      </stop>
      <stop offset="100%" stop-color="#ff00ff">
        <animate attributeName="stop-color" values="#ff00ff;#00fff0;#ff00ff" dur="8s" repeatCount="indefinite"/>
      </stop>
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="3.5" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <text x="50%" y="50" text-anchor="middle" font-family="Fira Code, monospace" font-size="28" fill="url(#neonGradient)" filter="url(#glow)">
    ${username}
  </text>

  <text x="50%" y="90" text-anchor="middle" font-family="Fira Code, monospace" font-size="20" fill="url(#neonGradient)" filter="url(#glow)">
    ${tagline}
  </text>

  <text x="50%" y="130" text-anchor="middle" font-family="Fira Code, monospace" font-size="16" fill="url(#neonGradient)" filter="url(#glow)">
    ${sig}
  </text>

  <style>
    @media (prefers-color-scheme: light) {
      text { fill-opacity: 0.9; }
    }
  </style>
</svg>
`;

fs.writeFileSync(`${DIST_DIR}/header.svg`, svg.trim());
console.log("✅ Header SVG generated with signature and neon gradient animation.");