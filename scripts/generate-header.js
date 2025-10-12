const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

// Header text & glyphs
const headerText = "𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ";
const tagline = "Walking The Path Where Bits & Dreams Intersect ®";

const svg = `
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 160" width="100%" height="160">
  <defs>
    <linearGradient id="neon-header" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#39FF14"/>
      <stop offset="50%" stop-color="#00FFF0"/>
      <stop offset="100%" stop-color="#FF00FF"/>
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="4" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <rect x="0" y="0" width="800" height="160" rx="20" fill="#0d0d0d" filter="url(#glow)"/>
  
  <text x="50%" y="55" text-anchor="middle" class="header-text" font-family="Fira Code, monospace" font-size="32" fill="url(#neon-header)" filter="url(#glow)">
    ${headerText}
  </text>
  <text x="50%" y="110" text-anchor="middle" class="tagline-text" font-family="Fira Code, monospace" font-size="16" fill="#00FFF0">
    ${tagline}
  </text>

  <style>
    @media (prefers-color-scheme: light) {
      rect { fill: #ffffff; }
      .header-text { fill: #0d0d0d; }
      .tagline-text { fill: #333333; }
    }
  </style>
</svg>
`;

fs.writeFileSync(path.join(DIST_DIR, 'header.svg'), svg.trim());
console.log("✅ Enhanced neon cyberpunk header SVG generated.");