// generate-terminal-svg.js
const fs = require('fs');
const path = require('path');
const DIST_DIR = path.resolve(__dirname, '../dist');

if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR);

// Quantum user signature
const QUANTUM_USER = '𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ ⚡';

// Terminal prompt colors
const FG_COLOR = '#39FF14';
const BG_COLOR = '#0f0f0f';
const FONT_FAMILY = 'Share Tech Mono, monospace';

// Simulate dynamic load average
const generateLoadAvg = () => {
  const rand = () => (Math.random() * 2 + 0.1).toFixed(2);
  return `${rand()} ${rand()} ${rand()}`;
};

// Simulate file listing
const generateFileList = () => {
  const files = [
    'DevOps', 'OpenSource', 'Scripts', 'TODO.md'
  ];
  return files.map(f => `- ${f}`).join('\n');
};

// Simulate TODO content
const generateTodo = () => `
# ℭ𝔲𝔯𝔯𝔢𝔫𝔱 𝔓𝔯𝔬𝔧𝔢𝔠𝔱𝔰 📋

→ Automating deployment workflows
→ Contributing to open source
→ Learning Kubernetes
→ Building shell script utilities
`;

// Current UTC timestamp
const timestamp = new Date().toISOString();

// Generate terminal-style SVG
const svgContent = `
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="400" viewBox="0 0 1200 400">
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap');
    .background { fill: ${BG_COLOR}; }
    .text { font-family: ${FONT_FAMILY}; font-size: 16px; fill: ${FG_COLOR}; white-space: pre; }
    .prompt { font-weight: bold; }
    .cursor { animation: blink 1s infinite; fill: ${FG_COLOR}; }
    @keyframes blink {
      0%, 50%, 100% { opacity: 1; }
      25%, 75% { opacity: 0; }
    }
    .flicker { animation: flicker 2s infinite; }
    @keyframes flicker {
      0%, 100% { opacity: 1; }
      50% { opacity: 0.6; }
    }
  </style>

  <!-- Background -->
  <rect width="1200" height="400" class="background" />

  <!-- Terminal prompt and content -->
  <text x="20" y="40" class="text prompt">${QUANTUM_USER}@github ~ % uptime</text>
  <text x="20" y="70" class="text flicker">load average: ${generateLoadAvg()}</text>

  <text x="20" y="110" class="text prompt">${QUANTUM_USER}@github ~ % ls -la Projects/</text>
  <text x="20" y="140" class="text flicker">${generateFileList()}</text>

  <text x="20" y="180" class="text prompt">${QUANTUM_USER}@github ~ % cat Projects/TODO.md</text>
  <text x="20" y="210" class="text flicker">${generateTodo()}</text>

  <!-- Blinking cursor -->
  <text x="20" y="360" class="text cursor">█</text>

  <!-- Timestamp for cache-busting -->
  <text x="1050" y="390" class="text" font-size="10px" fill="#00FF9C">${timestamp}</text>
</svg>
`;

// Write SVG file
const outputPath = path.join(DIST_DIR, 'terminal.svg');
fs.writeFileSync(outputPath, svgContent, 'utf-8');
console.log(`✔ Quantum terminal SVG generated at ${outputPath}`);