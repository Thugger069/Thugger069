#!/usr/bin/env node
/**
 * Generate Glitching macOS Terminal Animation
 * Creates an animated SVG terminal that can be converted to GIF
 */

const fs = require('fs');
const path = require('path');

const WIDTH = 800;
const HEIGHT = 500;
const OUTPUT_DIR = path.join(__dirname, '../assets');
const OUTPUT_FILE = path.join(OUTPUT_DIR, 'terminal-glitch-animation.svg');

// Ensure output directory exists
if (!fs.existsSync(OUTPUT_DIR)) {
  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
}

function generateTerminalAnimation() {
  const colors = {
    bg: '#000000',
    bgDark: '#0a0a0a',
    cyan: '#00FFFF',
    magenta: '#FF00FF',
    white: '#FFFFFF',
    green: '#00FF41',
    purple: '#1A0B2E'
  };

  const fontFamily = 'Monaco, "Courier New", monospace';
  const fontSize = 14;
  const lineHeight = 20;
  const padding = 20;
  
  const commands = [
    { text: 'Last login: Wed Oct 15 07:57:41 on ttys000', delay: 0, color: colors.cyan },
    { text: '[SYSTEM_ROOT]: VIRTUALIZING... OK', delay: 0.5, color: colors.green },
    { text: '', delay: 1 },
    { text: 'Thugger069@github ~ % uptime', delay: 1.5, color: colors.magenta },
    { text: '> 2025-10-15 07:57:41 up 02:51, 1 user, load average: 0.58 0.92 0.30', delay: 2, color: colors.white },
    { text: '', delay: 2.5 },
    { text: 'Thugger069@github ~ % ls -la Projects/', delay: 3, color: colors.magenta },
    { text: '> total 40', delay: 3.5, color: colors.white },
    { text: '> drwxr-xr-x  8 Thugger069  staff  256 May 07 02:51 .', delay: 3.7, color: colors.cyan },
    { text: '> drwxr-xr-x  5 Thugger069  staff  160 May 07 02:51 ..', delay: 3.9, color: colors.cyan },
    { text: '> drwxr-xr-x  7 Thugger069  staff  224 May 07 02:51 DevOps', delay: 4.1, color: colors.cyan },
    { text: '> drwxr-xr-x  6 Thugger069  staff  192 May 07 02:51 OpenSource', delay: 4.3, color: colors.cyan },
    { text: '> drwxr-xr-x  5 Thugger069  staff  160 May 07 02:51 Scripts', delay: 4.5, color: colors.cyan },
    { text: '> -rw-r--r--  1 Thugger069  staff  925 May 07 02:51 TODO.md', delay: 4.7, color: colors.white },
    { text: '', delay: 5 },
    { text: 'Thugger069@github ~ % cat Projects/TODO.md', delay: 5.5, color: colors.magenta },
    { text: '>', delay: 6, color: colors.white },
    { text: '> # Current Projects 📋', delay: 6.2, color: colors.cyan },
    { text: '>', delay: 6.4 },
    { text: '> → Automating deployment workflows', delay: 6.6, color: colors.white },
    { text: '> → Contributing to open_source', delay: 6.8, color: colors.white },
    { text: '> → Learning Kubernetes...', delay: 7, color: colors.white },
    { text: '> → Building shell script utilities', delay: 7.2, color: colors.white },
    { text: '', delay: 7.5 },
    { text: 'Thugger069@github ~ % █', delay: 8, color: colors.cyan }
  ];

  // Generate command lines with typing animation
  const commandLines = commands.map((cmd, idx) => {
    if (!cmd.text) {
      return `<text x="${padding}" y="${padding + (idx * lineHeight)}" font-family="${fontFamily}" font-size="${fontSize}" fill="${colors.bg}"> </text>`;
    }
    
    const chars = cmd.text.split('');
    const charElements = chars.map((char, charIdx) => {
      const charDelay = cmd.delay + (charIdx * 0.05);
      return `<tspan x="${padding + (charIdx * 8)}" y="${padding + (idx * lineHeight)}" fill="${cmd.color || colors.white}" opacity="0">
        ${char === ' ' ? '&nbsp;' : char === '<' ? '&lt;' : char === '>' ? '&gt;' : char}
        <animate attributeName="opacity" values="0;1" dur="0.05s" begin="${charDelay}s" fill="freeze"/>
      </tspan>`;
    }).join('');
    
    return `<text x="${padding}" y="${padding + (idx * lineHeight)}" font-family="${fontFamily}" font-size="${fontSize}">${charElements}</text>`;
  }).join('\n');

  // Glitch effects
  const glitchLines = [];
  for (let i = 0; i < 20; i++) {
    glitchLines.push({
      y: Math.random() * HEIGHT,
      delay: Math.random() * 2,
      offset: (Math.random() - 0.5) * 4
    });
  }

  const glitchSVG = glitchLines.map(line => `
    <line x1="0" y1="${line.y}" x2="${WIDTH}" y2="${line.y}" stroke="${colors.cyan}" stroke-width="1" opacity="0">
      <animate attributeName="opacity" values="0;0.3;0" dur="0.1s" begin="${line.delay}s" repeatCount="indefinite"/>
    </line>`).join('\n');

  // RGB channel shift
  const rgbShift = `
    <g opacity="0.15">
      <rect x="0" y="0" width="${WIDTH}" height="${HEIGHT}" fill="none">
        <animateTransform attributeName="transform" type="translate" values="0,0; -2,0; 0,0; 2,0; 0,0" dur="0.2s" repeatCount="indefinite"/>
      </rect>
    </g>`;

  // CRT scanlines
  const scanlines = [];
  for (let i = 0; i < HEIGHT; i += 2) {
    scanlines.push(`<line x1="0" y1="${i}" x2="${WIDTH}" y2="${i}" stroke="${colors.cyan}" stroke-width="1" opacity="0.03">
      <animate attributeName="opacity" values="0.03;0.08;0.03" dur="0.1s" begin="${(i / HEIGHT) * 0.5}s" repeatCount="indefinite"/>
    </line>`);
  }

  return `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
     viewBox="0 0 ${WIDTH} ${HEIGHT}" width="${WIDTH}" height="${HEIGHT}">
  <defs>
    <linearGradient id="termBg" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:${colors.bgDark};stop-opacity:1" />
      <stop offset="100%" style="stop-color:${colors.bg};stop-opacity:1" />
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="2" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#termBg)" rx="8"/>
  <rect x="5" y="5" width="${WIDTH - 10}" height="${HEIGHT - 10}" fill="none" stroke="${colors.cyan}" stroke-width="2" rx="6" opacity="0.5">
    <animate attributeName="opacity" values="0.3;0.6;0.3" dur="2s" repeatCount="indefinite"/>
  </rect>
  
  <!-- Terminal Content -->
  <g font-family="${fontFamily}" font-size="${fontSize}">
    ${commandLines}
  </g>
  
  <!-- Glitch Effects -->
  <g filter="url(#glow)">
    ${glitchSVG}
  </g>
  
  <!-- CRT Scanlines -->
  <g opacity="0.4">
    ${scanlines.join('\n')}
  </g>
  
  <!-- RGB Channel Shift -->
  ${rgbShift}
  
  <!-- Cursor Blink -->
  <rect x="${padding + 8 * commands[commands.length - 1].text.length}" y="${padding + ((commands.length - 1) * lineHeight) - 12}" width="8" height="16" fill="${colors.cyan}" opacity="1">
    <animate attributeName="opacity" values="1;0;1" dur="1s" begin="8s" repeatCount="indefinite"/>
  </rect>
</svg>`;
}

// Write SVG file
const svgContent = generateTerminalAnimation();
fs.writeFileSync(OUTPUT_FILE, svgContent);
console.log(`✅ Generated terminal glitch animation: ${OUTPUT_FILE}`);
console.log(`📝 To convert to GIF, use: convert -delay 10 -loop 0 ${OUTPUT_FILE} ${OUTPUT_FILE.replace('.svg', '.gif')}`);
