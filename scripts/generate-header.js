const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const lines = [
  "𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ",
  "Walking The Path Where Bits & Dreams Intersect ®.",
  "卞廾凵呂呂ヨ尺."
];

const svg = `
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="200" viewBox="0 0 800 200">
  <defs>
    <!-- Neon glow filter -->
    <filter id="neon">
      <feGaussianBlur stdDeviation="2" result="blur1"/>
      <feGaussianBlur stdDeviation="4" result="blur2"/>
      <feMerge>
        <feMergeNode in="blur1"/>
        <feMergeNode in="blur2"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>

    <!-- Background gradient animation -->
    <linearGradient id="bg-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#0d0d0d"/>
      <stop offset="50%" stop-color="#0a0a0a"/>
      <stop offset="100%" stop-color="#0d0d0d"/>
      <animate attributeName="x1" values="0%;100%;0%" dur="12s" repeatCount="indefinite"/>
      <animate attributeName="x2" values="100%;0%;100%" dur="12s" repeatCount="indefinite"/>
    </linearGradient>
  </defs>

  <!-- Background rectangle -->
  <rect width="800" height="200" rx="16" fill="url(#bg-gradient)" filter="url(#neon)"/>

  <!-- Signature block lines -->
  ${lines.map((line, i) => `
  <text x="50%" y="${60 + i*50}" text-anchor="middle"
        font-family="Fira Code, monospace" font-size="28"
        fill="#00fff0" filter="url(#neon)">
    <tspan x="50%">
      ${line}
    </tspan>
    <!-- Flicker animation -->
    <animate attributeName="opacity"
             values="0.3;1;0.8;1;0.5;1"
             dur="${2 + i*0.5}s"
             repeatCount="indefinite"/>
  </text>
  `).join('')}

  <style>
    @media (prefers-color-scheme: light) {
      rect { fill: #f0f0f0; filter: none; }
      text { fill: #0d0d0d; }
    }
  </style>
</svg>
`;

fs.writeFileSync(path.join(DIST_DIR, 'header.svg'), svg.trim());
console.log("✅ Signature block is now a flickering neon header SVG!");