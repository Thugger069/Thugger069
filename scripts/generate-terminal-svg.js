#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const TERMINAL_SVG = path.join(DIST_DIR, 'terminal.svg');
const nowUTC = new Date().toISOString().replace('T', ' ').split('.')[0] + ' UTC';

// Terminal content
const username = '𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ';
const currentTime = nowUTC;
const loadAvg = '0.15, 0.12, 0.10';
const projects = ['DevOps','OpenSource','Scripts'];
const todoList = [
  'Automating deployment workflows',
  'Contributing to open source',
  'Learning Kubernetes',
  'Building shell script utilities'
];

// Generate matrix letters behind terminal
const signature = '𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ';
const matrixLetters = signature.split('');
const generateMatrixText = (letters) => 
  letters.map((char, i) => {
    const delay = (i * 0.2).toFixed(2);
    return `<text x="${50 + i*36}" y="50" font-family="Monaco, Consolas, monospace" font-size="36" font-weight="bold" fill="#00ff41" class="matrix">
      ${char}
      <animate attributeName="y" values="-20;400;-20" dur="4s" begin="${delay}s" repeatCount="indefinite"/>
      <animate attributeName="opacity" values="0.2;1;0.2" dur="2s" begin="${delay}s" repeatCount="indefinite"/>
    </text>`;
  }).join('\n  ');

// Generate TODO list as SVG text
const generateTODOText = (list, startY) => list.map((item,i) =>
  `<text x="40" y="${startY + i*24}" font-family="Monaco, Consolas, monospace" font-size="16" fill="#b967ff">→ ${item}</text>`
).join('\n  ');

// Particle layer
const generateParticles = (count=50) => Array.from({ length: count }).map(() => {
  const cx = Math.random()*1200;
  const cy = Math.random()*400;
  const r = 1 + Math.random()*3;
  const dur = 2 + Math.random()*3;
  return `<circle cx="${cx}" cy="${cy}" r="${r}" fill="#00f3ff" opacity="0.5">
    <animate attributeName="cy" values="${cy};${cy+60};${cy}" dur="${dur}s" repeatCount="indefinite"/>
    <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite"/>
  </circle>`;
}).join('\n  ');

const svgContent = `
<svg width="100%" height="400" viewBox="0 0 1200 400" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bgDark" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0a0a0f"/>
      <stop offset="50%" stop-color="#1a1b26"/>
      <stop offset="100%" stop-color="#0a0a0f"/>
    </linearGradient>
    <linearGradient id="bgLight" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#ffffff"/>
      <stop offset="50%" stop-color="#e0e0e0"/>
      <stop offset="100%" stop-color="#ffffff"/>
    </linearGradient>

    <style>
      .bg { fill: url(#bgDark); }
      .matrix { fill: #00ff41; }
      @media (prefers-color-scheme: light) {
        .bg { fill: url(#bgLight); }
        .matrix { fill: #0077aa; }
      }
    </style>
  </defs>

  <rect width="1200" height="400" rx="15" class="bg"/>

  <!-- Matrix letters -->
  ${generateMatrixText(matrixLetters)}

  <!-- Terminal content -->
  <text x="40" y="40" font-family="Monaco, Consolas, monospace" font-size="18" fill="#00ffff">
    ${username}@github ~ % uptime
  </text>
  <text x="40" y="70" font-family="Monaco, Consolas, monospace" font-size="16" fill="#ffffff">
    ${currentTime} up 02:51, 1 user, load average: ${loadAvg}
  </text>

  <text x="40" y="110" font-family="Monaco, Consolas, monospace" font-size="16" fill="#00ff41">
    ${username}@github ~ % ls -la Projects/
  </text>
  ${projects.map((p,i)=>`<text x="60" y="${140+i*24}" font-family="Monaco, Consolas, monospace" font-size="16" fill="#ffffff">${p}/</text>`).join('\n  ')}

  <text x="40" y="240" font-family="Monaco, Consolas, monospace" font-size="16" fill="#00ff41">
    ${username}@github ~ % cat Projects/TODO.md
  </text>
  ${generateTODOText(todoList, 270)}

  <!-- Timestamp bottom-right -->
  <text x="1180" y="390" font-family="Monaco, Consolas, monospace" font-size="12" fill="#888" text-anchor="end">
    ${currentTime}
  </text>

  <!-- Blinking cursor -->
  <text x="500" y="40" font-family="Monaco, Consolas, monospace" font-size="18" fill="#00ffff">
    <animate attributeName="opacity" values="0;1;0" dur="1s" repeatCount="indefinite"/>
    █
  </text>

  <!-- Particle layer -->
  ${generateParticles(70)}
</svg>
`;

fs.writeFileSync(TERMINAL_SVG, svgContent, 'utf8');
console.log('✅ Generated fully enhanced terminal.svg with matrix, cursor, TODOs, and particles');
