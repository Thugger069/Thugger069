// scripts/generate-header.js
const fs = require('fs');

const width = 1000;
const height = 200;

const headerSVG = `
<svg viewBox="0 0 ${width} ${height}" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="neonGradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#39FF14"/>
      <stop offset="50%" stop-color="#00FFF0"/>
      <stop offset="100%" stop-color="#FF00FF"/>
      <animate attributeName="x1" values="0%;100%;0%" dur="6s" repeatCount="indefinite"/>
      <animate attributeName="x2" values="100%;0%;100%" dur="6s" repeatCount="indefinite"/>
    </linearGradient>

    <filter id="glow">
      <feGaussianBlur stdDeviation="4" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <rect width="100%" height="100%" fill="#0d0d0d" />
  
  <text x="50%" y="50%" text-anchor="middle" dominant-baseline="middle"
        font-family="Fira Code, monospace" font-size="60" fill="url(#neonGradient)"
        filter="url(#glow)">
    𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ
  </text>

  <!-- Particle Overlay -->
  <g id="particles">
    ${Array.from({ length: 80 }).map(() => {
      const cx = Math.random() * width;
      const cy = Math.random() * height;
      const r = Math.random() * 2 + 1;
      return `<circle cx="${cx}" cy="${cy}" r="${r}" fill="#39FF14" opacity="0.3">
        <animate attributeName="cy" values="${cy};${cy-20};${cy}" dur="${2+Math.random()*3}s" repeatCount="indefinite"/>
      </circle>`;
    }).join('')}
  </g>

  <style>
    @media (prefers-color-scheme: light) {
      rect { fill: #ffffff; }
      text { fill: #0d0d0d; }
      circle { fill: #0d0d0d; opacity: 0.2; }
    }
  </style>
</svg>
`;

fs.writeFileSync('dist/header.svg', headerSVG.trim());
console.log("✅ Enhanced header.svg generated successfully.");