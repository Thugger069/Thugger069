#!/usr/bin/env node
// Minimal animated terminal panel (separate from text block)
// Env: NODE_THEME (unused here but kept for future styling)

const fs = require('fs');
const path = require('path');

const outDir = process.argv[2] || 'dist';
fs.mkdirSync(outDir, { recursive: true });

const W = 940, H = 220, pad = 16;
const now = new Date().toISOString().replace('T',' ').replace('Z',' UTC');

const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg width="${W}" height="${H}" viewBox="0 0 ${W} ${H}" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Terminal panel">
  <defs>
    <linearGradient id="bar" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#00ffcc"/><stop offset="50%" stop-color="#66ff66"/><stop offset="100%" stop-color="#00e6ff"/>
      <animate attributeName="x1" values="0%;-40%;0%" dur="10s" repeatCount="indefinite"/>
      <animate attributeName="x2" values="100%;140%;100%" dur="10s" repeatCount="indefinite"/>
    </linearGradient>
    <filter id="noise" x="0" y="0" width="100%" height="100%">
      <feTurbulence type="fractalNoise" baseFrequency="0.8" numOctaves="2" seed="2" stitchTiles="stitch">
        <animate attributeName="seed" values="1;2;3;1" dur="6s" repeatCount="indefinite"/>
      </feTurbulence>
      <feColorMatrix type="saturate" values="0"/>
      <feComponentTransfer><feFuncA type="table" tableValues="0 0 0 0 0.05 0.10 0.05 0"/></feComponentTransfer>
    </filter>
  </defs>

  <rect x="${pad}" y="${pad}" rx="10" ry="10" width="${W - pad*2}" height="${H - pad*2}" fill="#0b0f14" stroke="#122637" stroke-width="1.2"/>
  <rect x="${pad}" y="${pad}" width="${W - pad*2}" height="${H - pad*2}" filter="url(#noise)" opacity="0.15"/>

  <text x="${pad + 12}" y="${pad + 18}" fill="#9bd6ff" font-family="ui-monospace, SFMono-Regular, Menlo, Consolas, monospace" font-size="12">
    cyber-shell :: terminal · ${now}
  </text>

  <g transform="translate(${pad + 12} ${pad + 32})">
    <text fill="#a8ffec" font-family="ui-monospace, SFMono-Regular, Menlo, Consolas, monospace" font-size="13">
      $ echo "hello, world"
      <animate attributeName="opacity" values="1;0.96;1;0.98;1" dur="7s" repeatCount="indefinite"/>
    </text>
    <text y="22" fill="#b0c4d4" font-family="ui-monospace, SFMono-Regular, Menlo, Consolas, monospace" font-size="13">
      hello, world
    </text>
  </g>

  <g transform="translate(${pad + 12} ${H - pad - 24})">
    <rect x="0" y="-10" width="${W - pad*3}" height="6" rx="3" fill="#0f1f2e" stroke="#122637"/>
    <rect x="0" y="-10" width="${W - pad*3 - 200}" height="6" rx="3" fill="url(#bar)">
      <animate attributeName="width" values="${W - pad*3 - 200};${W - pad*3 - 230};${W - pad*3 - 200}" dur="3.6s" repeatCount="indefinite"/>
    </rect>
  </g>
</svg>
`;

fs.writeFileSync(path.join(outDir, 'terminal.svg'), svg, 'utf8');
console.log('[terminal] generated terminal.svg');