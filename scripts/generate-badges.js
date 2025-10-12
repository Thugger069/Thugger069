// scripts/generate-badges.js
const fs = require('fs');
const path = require('path');

const DIST_DIR = path.join(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR);

const badges = [
  { label: 'Commits', value: '145', color: '#39FF14' },
  { label: 'PRs', value: '58', color: '#00fff0' },
  { label: 'Issues', value: '12', color: '#ff00ff' },
  { label: 'Stars', value: '420', color: '#ff0000' }
];

const svgContent = `
<svg xmlns="http://www.w3.org/2000/svg" width="600" height="${badges.length * 50}" viewBox="0 0 600 ${badges.length * 50}">
  <defs>
    <linearGradient id="grad" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#39FF14">
        <animate attributeName="stop-color" values="#39FF14;#00fff0;#ff00ff;#ff0000;#39FF14" dur="8s" repeatCount="indefinite"/>
      </stop>
      <stop offset="100%" stop-color="#ff00ff">
        <animate attributeName="stop-color" values="#ff00ff;#ff0000;#39FF14;#00fff0;#ff00ff" dur="8s" repeatCount="indefinite"/>
      </stop>
    </linearGradient>
    <style>
      .label { font-family: 'Fira Code', monospace; font-size: 16px; fill: #ffffff; }
      .value { font-family: 'Fira Code', monospace; font-size: 16px; fill: url(#grad); font-weight: bold; }
      @media (prefers-color-scheme: light) {
        .label { fill: #0d0d0d; }
      }
    </style>
  </defs>

  ${badges.map((b, i) => `
    <g transform="translate(10, ${i * 50 + 30})">
      <text class="label">${b.label}:</text>
      <text class="value" x="120">${b.value}</text>
    </g>
  `).join('')}
</svg>
`;

fs.writeFileSync(path.join(DIST_DIR, 'badges.svg'), svgContent.trim());
console.log("✅ Dynamic neon badges generated at dist/badges.svg");