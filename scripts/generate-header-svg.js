#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const HEADER_SVG = path.join(DIST_DIR, 'header.svg');
const nowUTC = new Date().toISOString().replace('T', ' ').split('.')[0] + ' UTC';

const signature = '𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ';
const matrixLetters = signature.split('');

const generateMatrixText = (letters, startX, startY) =>
  letters.map((char, i) => {
    const delay = (i * 0.2).toFixed(2);
    return `<text x="${startX + i * 48}" y="${startY}" font-family="Monaco, Consolas, monospace" font-size="56" font-weight="bold" class="matrix">
      ${char}
      <animate attributeName="y" values="-20;400;-20" dur="4s" begin="${delay}s" repeatCount="indefinite"/>
      <animate attributeName="opacity" values="0.2;1;0.2" dur="2s" begin="${delay}s" repeatCount="indefinite"/>
    </text>`;
  }).join('\n  ');

const svgContent = `
<svg viewBox="0 0 1200 400" width="100%" height="auto" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bgGradientDark" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0a0a0f"/>
      <stop offset="50%" stop-color="#1a1b26"/>
      <stop offset="100%" stop-color="#0a0a0f"/>
    </linearGradient>
    <linearGradient id="bgGradientLight" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#ffffff"/>
      <stop offset="50%" stop-color="#e0e0e0"/>
      <stop offset="100%" stop-color="#ffffff"/>
    </linearGradient>
    <radialGradient id="coreGlow">
      <stop offset="0%" stop-color="#00f3ff" stop-opacity="0.9"/>
      <stop offset="50%" stop-color="#ff00ff" stop-opacity="0.6"/>
      <stop offset="100%" stop-color="#b967ff" stop-opacity="0"/>
    </radialGradient>
    <filter id="glow" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur stdDeviation="3" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
    <style>
      .bg { fill: url(#bgGradientDark); transition: fill 0.5s;}
      .matrix { fill: #00ff41; }
      @media (prefers-color-scheme: light) {
        .bg { fill: url(#bgGradientLight); }
        .matrix { fill: #0077aa; }
      }
    </style>
  </defs>

  <rect width="1200" height="400" rx="20" class="bg"/>
  <g transform="translate(600,200)">
    <circle r="20" fill="url(#coreGlow)" filter="url(#glow)">
      <animate attributeName="r" values="18;25;18" dur="2s" repeatCount="indefinite"/>
      <animateTransform attributeName="transform" type="rotate" values="0;360" dur="10s" repeatCount="indefinite"/>
    </circle>
    <circle r="30" fill="none" stroke="#ff00ff" stroke-width="2">
      <animateTransform attributeName="transform" type="rotate" values="360;0" dur="15s" repeatCount="indefinite"/>
    </circle>
  </g>

  ${generateMatrixText(matrixLetters, 600 - matrixLetters.length * 24, 300)}

  <text x="600" y="340" font-family="Monaco, Consolas, monospace" font-size="18" fill="#ff00ff" text-anchor="middle" filter="url(#glow)">
    QUANTUM DEVELOPER | CYBERPUNK ARCHITECT
    <animateTransform attributeName="transform" type="rotate" values="0 600 340;360 600 340" dur="20s" repeatCount="indefinite"/>
    <animate attributeName="opacity" values="0.8;1;0.8" dur="2.5s" repeatCount="indefinite"/>
  </text>

  <text x="600" y="380" font-family="Monaco, Consolas, monospace" font-size="12" fill="#b967ff" text-anchor="middle" opacity="0.8">
    SYSTEM UPDATE: ${nowUTC}
  </text>

  ${Array.from({ length: 70 }).map((_, i) => {
    const cx = Math.random() * 1200;
    const cy = Math.random() * 400;
    const r = 1 + Math.random() * 3;
    const dur = 2 + Math.random() * 3;
    return `<circle cx="${cx}" cy="${cy}" r="${r}" fill="#00f3ff" opacity="0.5" class="particle">
      <animate attributeName="cy" values="${cy};${cy + 60};${cy}" dur="${dur}s" repeatCount="indefinite"/>
      <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite"/>
    </circle>`;
  }).join('\n  ')}

</svg>
`;

fs.writeFileSync(HEADER_SVG, svgContent, 'utf8');
console.log('✅ Generated enhanced header.svg with responsive & neon animations');
