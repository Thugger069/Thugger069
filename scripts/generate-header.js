const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..');
const README_FILE = path.join(REPO_ROOT, 'README.md');
const ASSETS_DIR = path.join(REPO_ROOT, 'assets');
const SVG_FILE = path.join(ASSETS_DIR, 'header.svg');

const AUTHOR = "𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ";
const GITHUB_USERNAME = "Thugger069";
const CURRENT_TIME = new Date().toUTCString().replace(/GMT/, 'UTC');

// Ensure assets directory exists
if (!fs.existsSync(ASSETS_DIR)) {
  fs.mkdirSync(ASSETS_DIR, { recursive: true });
}

// Static neon grid background
function generateGrid(width, height) {
  let grid = '';
  const spacing = 60;
  for (let x = spacing; x < width; x += spacing) {
    const opacity = 0.1 + (x / width) * 0.15;
    grid += `<line x1="${x}" y1="0" x2="${x}" y2="${height}" stroke="#00f3ff" stroke-width="0.5" opacity="${opacity}"/>`;
  }
  for (let y = spacing; y < height; y += spacing) {
    const opacity = 0.1 + (y / height) * 0.15;
    grid += `<line x1="0" y1="${y}" x2="${width}" y2="${y}" stroke="#ff00ff" stroke-width="0.5" opacity="${opacity}"/>`;
  }
  return grid;
}

// Matrix-style falling characters
function generateMatrix(width, height) {
  let chars = '';
  const characters = ['0','1','A','B','C','D','E','F','X'];
  const columns = 25;
  for (let i = 0; i < columns; i++) {
    const x = (i * width) / columns + 20;
    const char = characters[Math.floor(Math.random() * characters.length)];
    const delay = Math.random() * 5;
    const duration = 3 + Math.random() * 2;
    chars += `<text x="${x}" y="-20" font-family="monospace" font-size="16" fill="#00ff41" opacity="0.6" font-weight="bold">
      ${char}
      <animate attributeName="y" values="-20;${height+20}" dur="${duration}s" begin="${delay}s" repeatCount="indefinite"/>
      <animate attributeName="opacity" values="0.6;0.3;0.6" dur="1s" repeatCount="indefinite"/>
    </text>`;
  }
  return chars;
}

// Quantum symbols & rotation
function generateQuantumSymbols(width, height) {
  const symbols = [
    { text: '|0>', x: 150, y: 80, color: '#00f3ff' },
    { text: '|1>', x: width-150, y: 100, color: '#ff00ff' },
    { text: 'PSI', x: 200, y: height-120, color: '#b967ff' },
    { text: 'H', x: width-200, y: height-100, color: '#fff000' },
    { text: 'CNOT', x: width/2-150, y: 60, color: '#00f3ff' },
    { text: 'X', x: width/2+150, y: 70, color: '#00ff41' }
  ];
  let html = '';
  symbols.forEach((sym, idx) => {
    const rotateValue = (idx * 60) % 360;
    html += `<text x="${sym.x}" y="${sym.y}" font-family="Monaco, Consolas, monospace" font-size="20" font-weight="bold" fill="${sym.color}" opacity="0.7" filter="url(#glow)" transform="rotate(${rotateValue} ${sym.x} ${sym.y})">
      ${sym.text}
      <animate attributeName="opacity" values="0.5;0.9;0.5" dur="3s" begin="${idx*0.5}s" repeatCount="indefinite"/>
      <animateTransform attributeName="transform" type="rotate" values="${rotateValue} ${sym.x} ${sym.y};${rotateValue+360} ${sym.x} ${sym.y}" dur="20s" repeatCount="indefinite"/>
    </text>`;
  });
  return html;
}

// HUD elements
function generateHUD(width, height) {
  return `
  <g transform="translate(${width-180}, 40)">
    <text font-family="Monaco, Consolas, monospace" font-size="11" fill="#00f3ff">
      <tspan x="0" y="0">SYSTEM: ONLINE</tspan>
      <tspan x="0" y="18" fill="#00ff41">STATUS: ACTIVE</tspan>
      <tspan x="0" y="36" fill="#ff00ff">USER: ${GITHUB_USERNAME}</tspan>
      <tspan x="0" y="54" fill="#fff000">MODE: QUANTUM</tspan>
    </text>
    <animate attributeName="opacity" values="1;0.7;1" dur="2s" repeatCount="indefinite"/>
  </g>
  <g transform="translate(30, ${height-80})">
    <text font-family="Monaco, Consolas, monospace" font-size="10" fill="#ff00ff" opacity="0.8">
      <tspan x="0" y="0">// QUANTUM_INTERFACE_ACTIVE</tspan>
      <tspan x="0" y="15">// CYBERPUNK_PROTOCOL_ENGAGED</tspan>
      <tspan x="0" y="30">// AWAITING_USER_INPUT...</tspan>
    </text>
  </g>`;
}

// Generate complete SVG
function generateSVG() {
  const width = 1200;
  const height = 400;
  return `<svg width="${width}" height="${height}" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bgGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#0a0a0f;stop-opacity:1"/>
      <stop offset="50%" style="stop-color:#1a1b26;stop-opacity:1"/>
      <stop offset="100%" style="stop-color:#0a0a0f;stop-opacity:1"/>
    </linearGradient>
    <radialGradient id="coreGlow">
      <stop offset="0%" style="stop-color:#00f3ff;stop-opacity:0.9"/>
      <stop offset="50%" style="stop-color:#ff00ff;stop-opacity:0.6"/>
      <stop offset="100%" style="stop-color:#b967ff;stop-opacity:0"/>
    </radialGradient>
    <filter id="glow" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur stdDeviation="3" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  <rect width="${width}" height="${height}" fill="url(#bgGradient)" rx="20"/>
  <rect x="2" y="2" width="${width-4}" height="${height-4}" fill="none" stroke="#00f3ff" stroke-width="3" rx="18"/>
  ${generateGrid(width, height)}
  ${generateMatrix(width, height)}
  <g transform="translate(${width/2}, ${height/2})">
    <circle r="20" fill="url(#coreGlow)" filter="url(#glow)">
      <animate attributeName="r" values="18;25;18" dur="2s" repeatCount="indefinite"/>
    </circle>
  </g>
  ${generateQuantumSymbols(width, height)}
  ${generateHUD(width, height)}
  <text x="${width/2}" y="${height-100}" font-family="Monaco, Consolas, monospace" font-size="56" font-weight="bold" fill="#00f3ff" text-anchor="middle" filter="url(#glow)">
    ${AUTHOR}
    <animate attributeName="opacity" values="1;0.8;1" dur="3s" repeatCount="indefinite"/>
  </text>
  <text x="${width/2}" y="${height-60}" font-family="Monaco, Consolas, monospace" font-size="18" fill="#ff00ff" text-anchor="middle" filter="url(#glow)">
    QUANTUM DEVELOPER | CYBERPUNK ARCHITECT
    <animate attributeName="opacity" values="0.8;1;0.8" dur="2.5s" repeatCount="indefinite"/>
  </text>
  <text x="${width/2}" y="${height-20}" font-family="Monaco, Consolas, monospace" font-size="12" fill="#b967ff" text-anchor="middle" opacity="0.8">
    SYSTEM UPDATE: ${CURRENT_TIME}
  </text>
</svg>`;
}

// Generate README header snippet
function generateReadmeHeader() {
  return `<!-- Quantum Cyberpunk Header -->
<div align="center">
  <img src="./assets/header.svg" alt="Quantum Cyberpunk Header" width="100%"/>
</div>
<!-- Header End -->`;
}

// Write SVG and update README
try {
  const svg = generateSVG();
  fs.writeFileSync(SVG_FILE, svg);
  console.log('✅ Generated header.svg');

  let content = '';
  if (fs.existsSync(README_FILE)) {
    content = fs.readFileSync(README_FILE, 'utf8');
    content = content.replace(/<!-- Quantum Cyberpunk Header -->[\s\S]*?<!-- Header End -->/g, '').trim();
  }

  const header = generateReadmeHeader();
  fs.writeFileSync(README_FILE, `${header}\n\n${content}`);
  console.log('✅ Updated README.md with header');
} catch (err) {
  console.error('❌ Error generating header:', err);
  process.exit(1);
}
