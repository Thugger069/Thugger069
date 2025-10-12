/**
 * generate_particles.js
 * Q.R.I.P ALL-IN: Neon Quantum Particle Animation for README
 */

const fs = require('fs');

const WIDTH = 800;
const HEIGHT = 200;
const NUM_PARTICLES = 60;
const DIST_DIR = '../dist';

// Generate random particles with positions, radius, and colors
function randomParticles() {
  const colors = ['#39FF14', '#00FFF0', '#FF00FF', '#FFDD00'];
  const particles = [];
  for (let i = 0; i < NUM_PARTICLES; i++) {
    particles.push({
      x: Math.random() * WIDTH,
      y: Math.random() * HEIGHT,
      r: 1 + Math.random() * 3,
      color: colors[Math.floor(Math.random() * colors.length)],
      dx: (Math.random() - 0.5) * 0.8,
      dy: (Math.random() - 0.5) * 0.8
    });
  }
  return particles;
}

// Generate SVG particle elements
function generateSVG(particles) {
  const defs = `
    <defs>
      <filter id="glow">
        <feGaussianBlur stdDeviation="2.5" result="coloredBlur"/>
        <feMerge>
          <feMergeNode in="coloredBlur"/>
          <feMergeNode in="SourceGraphic"/>
        </feMerge>
      </filter>
    </defs>
  `;

  const circles = particles.map(p => `
    <circle cx="${p.x}" cy="${p.y}" r="${p.r}" fill="${p.color}" filter="url(#glow)">
      <animate attributeName="cx" values="${p.x};${p.x + p.dx};${p.x}" dur="6s" repeatCount="indefinite"/>
      <animate attributeName="cy" values="${p.y};${p.y + p.dy};${p.y}" dur="6s" repeatCount="indefinite"/>
    </circle>
  `).join('\n');

  return `
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${WIDTH} ${HEIGHT}" width="100%" height="${HEIGHT}">
  ${defs}
  ${circles}
</svg>
  `.trim();
}

// Main
function main() {
  if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

  const particles = randomParticles();
  const svg = generateSVG(particles);

  fs.writeFileSync(`${DIST_DIR}/particles.svg`, svg);
  console.log('✅ Neon quantum particles SVG saved as dist/particles.svg');
}

main();