#!/usr/bin/env node
/**
 * Generate Animated GIFs using Node.js
 * Creates cosmic glitch banner and terminal animation GIFs
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const ASSETS_DIR = path.join(__dirname, '../assets');
const DIST_DIR = path.join(__dirname, '../dist');

// Ensure directories exist
[ASSETS_DIR, DIST_DIR].forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

console.log('🎬 Generating animated GIFs...\n');

// Method 1: Try using sharp/ffmpeg if available
// Method 2: Use online conversion service
// Method 3: Create HTML5 canvas animation that can be recorded

// For now, let's create a script that uses a web-based approach
// We'll create an HTML file that can be opened in a browser and recorded

function createGIFGeneratorHTML() {
  return `<!DOCTYPE html>
<html>
<head>
  <title>Cosmic Glitch GIF Generator</title>
  <style>
    body { margin: 0; background: #000; overflow: hidden; }
    canvas { display: block; }
  </style>
</head>
<body>
  <canvas id="bannerCanvas" width="1200" height="300"></canvas>
  <script>
    const canvas = document.getElementById('bannerCanvas');
    const ctx = canvas.getContext('2d');
    const WIDTH = 1200;
    const HEIGHT = 300;
    
    const colors = {
      cyan: '#00FFFF',
      magenta: '#FF00FF',
      white: '#FFFFFF',
      black: '#000000',
      purple: '#1A0B2E',
      darkBlue: '#0F0F2A'
    };
    
    // Stars
    const stars = [];
    for (let i = 0; i < 40; i++) {
      stars.push({
        x: Math.random() * WIDTH,
        y: Math.random() * HEIGHT,
        r: 1 + Math.random() * 2,
        color: Math.random() > 0.5 ? colors.cyan : colors.magenta,
        opacity: 0,
        targetOpacity: 0.8 + Math.random() * 0.2,
        speed: 0.02 + Math.random() * 0.03
      });
    }
    
    // Nebulas
    const nebulas = [
      { x: WIDTH * 0.2, y: HEIGHT * 0.3, rx: WIDTH * 0.3, ry: HEIGHT * 0.4, color: colors.magenta, opacity: 0.15 },
      { x: WIDTH * 0.8, y: HEIGHT * 0.7, rx: WIDTH * 0.35, ry: HEIGHT * 0.5, color: colors.cyan, opacity: 0.15 }
    ];
    
    let frame = 0;
    let glitchOffset = 0;
    
    function draw() {
      // Clear with gradient background
      const bgGrad = ctx.createLinearGradient(0, 0, WIDTH, HEIGHT);
      bgGrad.addColorStop(0, colors.black);
      bgGrad.addColorStop(0.3, colors.purple);
      bgGrad.addColorStop(0.6, colors.darkBlue);
      bgGrad.addColorStop(1, colors.black);
      ctx.fillStyle = bgGrad;
      ctx.fillRect(0, 0, WIDTH, HEIGHT);
      
      // Draw nebulas
      nebulas.forEach((nebula, idx) => {
        const gradient = ctx.createRadialGradient(nebula.x, nebula.y, 0, nebula.x, nebula.y, nebula.rx);
        gradient.addColorStop(0, nebula.color + 'FF');
        gradient.addColorStop(0.5, nebula.color + '80');
        gradient.addColorStop(1, nebula.color + '00');
        ctx.fillStyle = gradient;
        ctx.beginPath();
        ctx.ellipse(
          nebula.x + Math.sin(frame * 0.01 + idx) * 10,
          nebula.y + Math.cos(frame * 0.015 + idx) * 8,
          nebula.rx + Math.sin(frame * 0.02) * 20,
          nebula.ry + Math.cos(frame * 0.025) * 15,
          0, 0, Math.PI * 2
        );
        ctx.fill();
      });
      
      // Draw stars
      stars.forEach(star => {
        star.opacity += (Math.random() > 0.5 ? star.speed : -star.speed);
        if (star.opacity < 0) star.opacity = 0;
        if (star.opacity > star.targetOpacity) star.opacity = star.targetOpacity;
        
        ctx.globalAlpha = star.opacity;
        ctx.fillStyle = star.color;
        ctx.shadowBlur = 10;
        ctx.shadowColor = star.color;
        ctx.beginPath();
        ctx.arc(star.x, star.y, star.r, 0, Math.PI * 2);
        ctx.fill();
      });
      ctx.globalAlpha = 1;
      ctx.shadowBlur = 0;
      
      // CRT Scanlines
      ctx.strokeStyle = colors.cyan;
      ctx.lineWidth = 1;
      for (let y = 0; y < HEIGHT; y += 3) {
        ctx.globalAlpha = 0.03 + Math.sin(frame * 0.1 + y * 0.1) * 0.02;
        ctx.beginPath();
        ctx.moveTo(0, y);
        ctx.lineTo(WIDTH, y);
        ctx.stroke();
      }
      ctx.globalAlpha = 1;
      
      // RGB Glitch
      if (frame % 3 === 0) {
        glitchOffset = (Math.random() - 0.5) * 4;
      }
      
      frame++;
      requestAnimationFrame(draw);
    }
    
    draw();
  </script>
</body>
</html>`;
}

// Create HTML generator file
const htmlFile = path.join(ASSETS_DIR, 'gif-generator-banner.html');
fs.writeFileSync(htmlFile, createGIFGeneratorHTML());
console.log(`✅ Created HTML generator: ${htmlFile}`);

// Create a script that uses headless browser or online service
const conversionScript = `#!/bin/bash
# Convert HTML5 canvas animations to GIF
# Option 1: Use puppeteer/playwright to record
# Option 2: Use online service like ezgif.com API
# Option 3: Manual recording instructions

echo "📝 To generate GIFs from the HTML files:"
echo "1. Open assets/gif-generator-banner.html in Chrome"
echo "2. Use a screen recorder or browser extension to record"
echo "3. Or use: npm install puppeteer && node scripts/record-canvas.js"
`;

fs.writeFileSync(path.join(__dirname, 'convert-html-to-gif.sh'), conversionScript);
fs.chmodSync(path.join(__dirname, 'convert-html-to-gif.sh'), '755');

console.log('\n📋 Next steps:');
console.log('1. SVG files generated in assets/');
console.log('2. HTML5 canvas generator created');
console.log('3. To create GIFs:');
console.log('   - Install ImageMagick: sudo apt-get install imagemagick');
console.log('   - Run: bash scripts/convert-svg-to-gif.sh');
console.log('   - Or use online converter: https://ezgif.com/svg-to-gif');
console.log('   - Or record the HTML5 canvas animations\n');
