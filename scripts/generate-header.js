// generate-header.js
const fs = require('fs');
const path = require('path');
const DIST_DIR = path.resolve(__dirname, '../dist');

if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR);

// Quantum glyphs for header animation
const glyphs = [
  'ꚩ', 'ꚶ', 'ꛎ', 'ꛘ', '𖢧', 'ꚶ', '𖢑', '𖦪', '𖤢', 'ꛎ', 'ꚳ', '𖢑'
];

// Generate a repeating glyph string for SVG
const repeatGlyphs = (count) => Array.from({ length: count }, () => glyphs[Math.floor(Math.random() * glyphs.length)]).join('');

// Current UTC timestamp for cache-busting
const timestamp = new Date().toISOString();

// SVG template for quantum header
const svgContent = `
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="120" viewBox="0 0 1200 120">
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap');
    .background { fill: #0f0f0f; }
    .glyph { font-family: 'Share Tech Mono', monospace; font-size: 36px; fill: #39FF14; }
    .shadow { fill: rgba(0, 255, 0, 0.2); }
    .wave { animation: wave 2s infinite linear; }
    @keyframes wave {
      0% { transform: translateY(0); }
      25% { transform: translateY(-5px); }
      50% { transform: translateY(0); }
      75% { transform: translateY(5px); }
      100% { transform: translateY(0); }
    }
  </style>

  <!-- Background -->
  <rect width="1200" height="120" class="background" />

  <!-- Layered shadow for depth -->
  <text x="50" y="60" class="glyph shadow">${repeatGlyphs(30)}</text>

  <!-- Foreground quantum glyphs with wave animation -->
  <text x="50" y="60" class="glyph wave">${repeatGlyphs(30)}</text>

  <!-- Optional signature block -->
  <text x="50" y="100" class="glyph">𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ ⚡</text>
  
  <!-- Timestamp for cache-busting -->
  <text x="1050" y="110" class="glyph" font-size="10px" fill="#00FF9C">${timestamp}</text>
</svg>
`;

// Write the SVG to the dist directory
const outputPath = path.join(DIST_DIR, 'header.svg');
fs.writeFileSync(outputPath, svgContent, 'utf-8');
console.log(`✔ Quantum header SVG generated at ${outputPath}`);