// scripts/generate-header.js
const fs = require('fs');

// SVG template with a simple animated radial gradient shift
const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg width="800" height="200" viewBox="0 0 800 200" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <radialGradient id="halo" cx="50%" cy="50%" r="50%">
      <stop offset="0%" stop-color="#00f" />
      <stop offset="100%" stop-color="#f0f" />
      <animate 
        xlink:href="#halo stop[offset='0%']" 
        attributeName="stop-color" 
        values="#00f;#0ff;#00f" 
        dur="6s" repeatCount="indefinite" />
      <animate 
        xlink:href="#halo stop[offset='100%']" 
        attributeName="stop-color" 
        values="#f0f;#ff0;#f0f" 
        dur="6s" repeatCount="indefinite" />
    </radialGradient>
  </defs>
  <rect width="800" height="200" fill="url(#halo)" />
  <text x="50%" y="50%" text-anchor="middle" dy=".35em"
        font-family="monospace" font-size="48" fill="#fff" letter-spacing="4">
    ꙳ 👨‍💻 𖢧ꛅꚶꚽꚽ𖤢𖦪'ꕷ 𖦪𖤢ꛎꚳ𖢑 ꙳
  </text>
</svg>`;

fs.writeFileSync('assets/quantum_tunnel.svg', svg);
console.log('✔️  Wrote assets/quantum_tunnel.svg');