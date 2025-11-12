const { createCanvas } = require('canvas');
const GIFEncoder = require('gifencoder');
const fs = require('fs');
const path = require('path');

const WIDTH = 1200;
const HEIGHT = 300;
const FPS = 10;
const DURATION = 3; // seconds
const TOTAL_FRAMES = FPS * DURATION;

const encoder = new GIFEncoder(WIDTH, HEIGHT);
encoder.createReadStream().pipe(fs.createWriteStream(path.join(__dirname, '../dist/cosmic-glitch-banner.gif')));

encoder.start();
encoder.setRepeat(0); // 0 for repeat, -1 for no-repeat
encoder.setDelay(1000 / FPS); // frame delay in ms
encoder.setQuality(10); // image quality. 10 is default.

const canvas = createCanvas(WIDTH, HEIGHT);
const ctx = canvas.getContext('2d');

const colors = {
  cyan: '#00FFFF',
  magenta: '#FF00FF',
  white: '#FFFFFF',
  black: '#000000',
  purple: '#1A0B2E',
  darkBlue: '#0F0F2A'
};

// Initialize stars
const stars = [];
for (let i = 0; i < 40; i++) {
  stars.push({
    x: Math.random() * WIDTH,
    y: Math.random() * HEIGHT,
    r: 1 + Math.random() * 2,
    color: Math.random() > 0.5 ? colors.cyan : colors.magenta,
    opacity: Math.random(),
    speed: 0.02 + Math.random() * 0.03
  });
}

const nebulas = [
  { x: WIDTH * 0.2, y: HEIGHT * 0.3, rx: WIDTH * 0.3, ry: HEIGHT * 0.4, color: colors.magenta },
  { x: WIDTH * 0.8, y: HEIGHT * 0.7, rx: WIDTH * 0.35, ry: HEIGHT * 0.5, color: colors.cyan }
];

for (let frame = 0; frame < TOTAL_FRAMES; frame++) {
  // Background gradient
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
    gradient.addColorStop(0, nebula.color + '40');
    gradient.addColorStop(0.5, nebula.color + '20');
    gradient.addColorStop(1, nebula.color + '00');
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.ellipse(
      nebula.x + Math.sin(frame * 0.1 + idx) * 10,
      nebula.y + Math.cos(frame * 0.15 + idx) * 8,
      nebula.rx + Math.sin(frame * 0.2) * 20,
      nebula.ry + Math.cos(frame * 0.25) * 15,
      0, 0, Math.PI * 2
    );
    ctx.fill();
  });
  
  // Draw stars
  stars.forEach(star => {
    star.opacity = (Math.sin(frame * star.speed) + 1) / 2;
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
  
  encoder.addFrame(ctx);
}

encoder.finish();
console.log('✅ GIF generated: dist/cosmic-glitch-banner.gif');
