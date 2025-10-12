// scripts/generate-header.js
const fs = require('fs');

const signature = `𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ
• Walking The Path Where Bits & Dreams Intersect ®
卞廾凵呂呂ヨ尺.と己し. 魔大帝`;

const svg = `
<svg viewBox="0 0 900 250" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="neonGradient" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#00fff0"/>
      <stop offset="50%" stop-color="#ff00ff"/>
      <stop offset="100%" stop-color="#ff0000"/>
    </linearGradient>
    <filter id="glow" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur stdDeviation="4" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
    <animate xlink:href="#neonGradient" attributeName="x1" values="0;1;0" dur="12s" repeatCount="indefinite"/>
  </defs>

  <rect width="900" height="250" rx="20" fill="#0d0d0d"/>

  <text x="50%" y="50%" text-anchor="middle" dominant-baseline="middle"
        font-family="Fira Code, monospace" font-size="20"
        fill="url(#neonGradient)" filter="url(#glow)">
    ${signature}
  </text>
</svg>
`;

fs.writeFileSync('dist/header.svg', svg.trim());
console.log("✅ Signature header.svg generated with neon gradient animation.");