// scripts/generate-quote.js
const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const QUOTE = "Walking the Path Where Bits & Dreams Intersect.";
const AUTHOR = "— 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ";

const svg = `<svg width="700" height="100" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="neonGrad" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#FF00FF">
        <animate attributeName="stop-color" values="#FF00FF;#39FF14;#00FFF0;#FF00FF" dur="8s" repeatCount="indefinite"/>
      </stop>
      <stop offset="100%" stop-color="#00FFF0">
        <animate attributeName="stop-color" values="#00FFF0;#FF00FF;#39FF14;#00FFF0" dur="8s" repeatCount="indefinite"/>
      </stop>
    </linearGradient>
  </defs>

  <rect width="700" height="100" fill="transparent"/>
  <text x="50%" y="40%" text-anchor="middle" font-family="monospace" font-size="18" fill="url(#neonGrad)">
    <tspan>${QUOTE}</tspan>
  </text>
  <text x="50%" y="75%" text-anchor="middle" font-family="monospace" font-size="14" fill="url(#neonGrad)">
    <tspan>${AUTHOR}</tspan>
  </text>
  <animate attributeName="opacity" values="0;1" dur="0.5s" repeatCount="indefinite"/>
</svg>`;

fs.writeFileSync(path.join(DIST_DIR, 'quote.svg'), svg);
console.log("✅ Quote SVG generated");