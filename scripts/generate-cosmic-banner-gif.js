#!/usr/bin/env node
/**
 * Generate Cosmic Glitch Banner Animation
 * Creates an animated SVG that can be converted to GIF
 */

const fs = require('fs');
const path = require('path');

const WIDTH = 1200;
const HEIGHT = 300;
const OUTPUT_DIR = path.join(__dirname, '../assets');
const OUTPUT_FILE = path.join(OUTPUT_DIR, 'cosmic-glitch-banner.svg');

// Ensure output directory exists
if (!fs.existsSync(OUTPUT_DIR)) {
  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
}

// Generate animated cosmic glitch banner SVG
function generateCosmicBanner() {
  const colors = {
    cyan: '#00FFFF',
    magenta: '#FF00FF',
    white: '#FFFFFF',
    black: '#000000',
    purple: '#1A0B2E',
    darkBlue: '#0F0F2A'
  };

  // Create stars/particles
  const stars = [];
  for (let i = 0; i < 40; i++) {
    stars.push({
      x: Math.random() * WIDTH,
      y: Math.random() * HEIGHT,
      r: 1 + Math.random() * 2,
      color: Math.random() > 0.5 ? colors.cyan : colors.magenta,
      delay: Math.random() * 3,
      duration: 2 + Math.random() * 3
    });
  }

  // Create nebula gradients
  const nebulas = [
    { cx: WIDTH * 0.2, cy: HEIGHT * 0.3, rx: WIDTH * 0.3, ry: HEIGHT * 0.4, color: colors.magenta },
    { cx: WIDTH * 0.8, cy: HEIGHT * 0.7, rx: WIDTH * 0.35, ry: HEIGHT * 0.5, color: colors.cyan }
  ];

  // Create glitch scanlines
  const scanlines = [];
  for (let i = 0; i < HEIGHT; i += 3) {
    scanlines.push({
      y: i,
      opacity: 0.02 + Math.random() * 0.03,
      delay: (i / HEIGHT) * 2
    });
  }

  const starsSVG = stars.map(star => `
    <circle cx="${star.x}" cy="${star.y}" r="${star.r}" fill="${star.color}" opacity="0">
      <animate attributeName="opacity" values="0;1;0.3;1;0" dur="${star.duration}s" begin="${star.delay}s" repeatCount="indefinite"/>
      <animate attributeName="r" values="${star.r};${star.r * 1.5};${star.r}" dur="${star.duration}s" begin="${star.delay}s" repeatCount="indefinite"/>
    </circle>`).join('\n');

  const nebulasSVG = nebulas.map((nebula, idx) => `
    <ellipse cx="${nebula.cx}" cy="${nebula.cy}" rx="${nebula.rx}" ry="${nebula.ry}" fill="${nebula.color}" opacity="0.15">
      <animate attributeName="opacity" values="0.1;0.25;0.1" dur="${4 + idx * 2}s" repeatCount="indefinite"/>
      <animateTransform attributeName="transform" type="translate" values="0,0; ${10 - idx * 5},${-5 + idx * 3}; 0,0" dur="${8 + idx * 2}s" repeatCount="indefinite"/>
    </ellipse>`).join('\n');

  const scanlinesSVG = scanlines.map(line => `
    <line x1="0" y1="${line.y}" x2="${WIDTH}" y2="${line.y}" stroke="${colors.cyan}" stroke-width="1" opacity="${line.opacity}">
      <animate attributeName="opacity" values="${line.opacity};${line.opacity * 3};${line.opacity}" dur="0.1s" begin="${line.delay}s" repeatCount="indefinite"/>
    </line>`).join('\n');

  // RGB channel shift effect
  const rgbShift = `
    <rect x="0" y="0" width="${WIDTH}" height="${HEIGHT}" fill="none">
      <animateTransform attributeName="transform" type="translate" values="0,0; -2,0; 0,0; 2,0; 0,0" dur="0.15s" repeatCount="indefinite"/>
    </rect>`;

  return `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
     viewBox="0 0 ${WIDTH} ${HEIGHT}" width="${WIDTH}" height="${HEIGHT}">
  <defs>
    <linearGradient id="bgGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:${colors.black};stop-opacity:1" />
      <stop offset="30%" style="stop-color:${colors.purple};stop-opacity:1" />
      <stop offset="60%" style="stop-color:${colors.darkBlue};stop-opacity:1" />
      <stop offset="100%" style="stop-color:${colors.black};stop-opacity:1" />
    </linearGradient>
    <radialGradient id="starGrad">
      <stop offset="0%" stop-color="${colors.cyan}" stop-opacity="1"/>
      <stop offset="100%" stop-color="${colors.magenta}" stop-opacity="0"/>
    </radialGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="3" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#bgGrad)"/>
  
  <!-- Nebulas -->
  ${nebulasSVG}
  
  <!-- Stars -->
  <g filter="url(#glow)">
    ${starsSVG}
  </g>
  
  <!-- CRT Scanlines -->
  <g opacity="0.6">
    ${scanlinesSVG}
  </g>
  
  <!-- RGB Glitch Shift -->
  <g opacity="0.1">
    ${rgbShift}
  </g>
  
  <!-- Pixel Sort Effect Overlay -->
  <defs>
    <pattern id="pixelSort" width="20" height="20" patternUnits="userSpaceOnUse">
      <path d="M 20 0 L 0 0 0 20" fill="none" stroke="${colors.cyan}" stroke-width="0.5" opacity="0.2"/>
    </pattern>
  </defs>
  <rect width="100%" height="100%" fill="url(#pixelSort)" opacity="0.3"/>
</svg>`;
}

// Write SVG file
const svgContent = generateCosmicBanner();
fs.writeFileSync(OUTPUT_FILE, svgContent);
console.log(`✅ Generated cosmic glitch banner: ${OUTPUT_FILE}`);
console.log(`📝 To convert to GIF, use: convert -delay 10 -loop 0 ${OUTPUT_FILE} ${OUTPUT_FILE.replace('.svg', '.gif')}`);
