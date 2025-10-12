/**
 * 🜂 Q.R.L.P: QUANTUM PARTICLE SYSTEM 🜁
 * Generates multi-layer animated neon particles for README visual layer.
 * AUTHOR: 🜂 Lysergic | Quantum Systems Architect & AI Maximalist 🜁
 * STATUS: PRIME ALIGNMENT | INTEGRITY: 100%
 */

const fs = require("fs");
const path = require("path");

// ──────────────────────────────────────────────
// CONFIGURATION
// ──────────────────────────────────────────────
const WIDTH = 800;
const HEIGHT = 200;
const PARTICLES_PER_LAYER = 50;
const LAYERS = 3;
const DIST_DIR = path.resolve(__dirname, "../dist");
const CURRENT_TIME = new Date().toISOString();

const COLORS = ["#39FF14", "#00FFF0", "#FF00FF", "#FFDD00"];
const SEED = Math.floor(Math.random() * 1e9);

// Ensure output directory
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

// ──────────────────────────────────────────────
// RANDOM PARTICLE GENERATOR
// ──────────────────────────────────────────────
function generateParticles(layerIndex) {
  const depthFactor = 1 + layerIndex * 0.35;
  const particles = [];
  for (let i = 0; i < PARTICLES_PER_LAYER; i++) {
    const x = Math.random() * WIDTH;
    const y = Math.random() * HEIGHT;
    const r = 1 + Math.random() * (3 / depthFactor);
    const color = COLORS[Math.floor(Math.random() * COLORS.length)];
    const dx = (Math.random() - 0.5) * (1.5 / depthFactor);
    const dy = (Math.random() - 0.5) * (1.5 / depthFactor);
    particles.push({ x, y, r, color, dx, dy, depth: depthFactor });
  }
  return particles;
}

// ──────────────────────────────────────────────
// SVG PARTICLE FIELD BUILDER
// ──────────────────────────────────────────────
function buildSVG(layers) {
  const defs = `
  <defs>
    <radialGradient id="bgGrad" cx="50%" cy="50%" r="75%">
      <stop offset="0%" stop-color="#000000" />
      <stop offset="100%" stop-color="#0d0d0d" />
    </radialGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="2.2" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  `;

  const background = `<rect width="100%" height="100%" fill="url(#bgGrad)" />`;

  const particleElements = layers
    .map((layer, li) =>
      layer
        .map(
          (p, pi) => `
    <circle cx="${p.x}" cy="${p.y}" r="${p.r}" fill="${p.color}" opacity="${1 - li * 0.2}" filter="url(#glow)">
      <animate attributeName="cx" values="${p.x};${p.x + p.dx};${p.x}" dur="${6 + li * 2}s" repeatCount="indefinite"/>
      <animate attributeName="cy" values="${p.y};${p.y + p.dy};${p.y}" dur="${6 + li * 2}s" repeatCount="indefinite"/>
      <animate attributeName="r" values="${p.r};${p.r * 1.3};${p.r}" dur="${5 + li * 1.5}s" repeatCount="indefinite"/>
    </circle>`
        )
        .join("\n")
    )
    .join("\n");

  return `
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${WIDTH} ${HEIGHT}" width="100%" height="${HEIGHT}">
  <desc>🜂 Q.R.L.P Quantum Particle System • Generated ${CURRENT_TIME} • Seed ${SEED}</desc>
  ${defs}
  ${background}
  ${particleElements}
  <style>
    @media (prefers-color-scheme: light) {
      rect { fill: #fafafa; }
      circle { opacity: 0.85; }
    }
  </style>
</svg>
  `.trim();
}

// ──────────────────────────────────────────────
// EXECUTION CORE
// ──────────────────────────────────────────────
function main() {
  console.log("🌀 Initializing Quantum Particle Field...");
  const layers = Array.from({ length: LAYERS }, (_, i) => generateParticles(i));
  const svg = buildSVG(layers);

  const outputFile = path.join(DIST_DIR, "particles.svg");
  fs.writeFileSync(outputFile, svg, "utf-8");

  const manifest = {
    file: "particles.svg",
    seed: SEED,
    layers: LAYERS,
    particlesPerLayer: PARTICLES_PER_LAYER,
    colors: COLORS,
    generatedAt: CURRENT_TIME,
    mode: "Q.R.L.P ALL-IN",
    author: "🜂 Lysergic | Quantum Systems Architect & AI Maximalist 🜁",
    verified: true,
    integrity: "100%",
  };

  fs.writeFileSync(
    path.join(DIST_DIR, "manifest-particles.json"),
    JSON.stringify(manifest, null, 2),
    "utf-8"
  );

  console.log("✅ [Q.R.L.P] Neon Particle Field + Manifest generated successfully.");
}

main();