// scripts/generate-header.js
/**
 * Q.R.I.P ALL-IN: Header & Signature SVG Generator
 * Author: 𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ
 */

const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const USERNAME = "𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ";
const TAGLINE = "• Walking The Path Where Bits & Dreams Intersect ®";
const SIGNATURE = "卞廾凵呂呂ヨ尺.と己し. 魔大帝";

// Neon gradient colors
const COLOR_START = "#39FF14"; // neon green
const COLOR_END = "#00FFF0";   // cyan

const svg = `
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 180" width="100%" height="180">
  <defs>
    <linearGradient id="neonGradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="${COLOR_START}">
        <animate attributeName="stop-color" values="${COLOR_START};#FF00FF;${COLOR_END}" dur="8s" repeatCount="indefinite"/>
      </stop>
      <stop offset="100%" stop-color="${COLOR_END}">
        <animate attributeName="stop-color" values="${COLOR_END};${COLOR_START};#FF00FF" dur="8s" repeatCount="indefinite"/>
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
    ${USERNAME}
  </text>

  <text x="50%" y="90" text-anchor="middle" font-family="Fira Code, monospace" font-size="20" fill="url(#neonGradient)" filter="url(#glow)">
    ${TAGLINE}
  </text>

  <text x="50%" y="130" text-anchor="middle" font-family="Fira Code, monospace" font-size="16" fill="url(#neonGradient)" filter="url(#glow)">
    ${SIGNATURE}
  </text>

  <style>
    @media (prefers-color-scheme: light) {
      text { fill-opacity: 0.9; }
    }
  </style>
</svg>
`;

// Write the header SVG to dist/
fs.writeFileSync(path.join(DIST_DIR, 'header.svg'), svg.trim());
console.log("✅ Header SVG generated with signature and neon gradient animation.");