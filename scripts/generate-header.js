/**
 * 🜂 Q.R.L.P HEADER GENERATOR 🜁
 * Generates animated neon header with dynamic theme, glow, and manifest logging.
 * Author: 🜂 Lysergic | Quantum Systems Architect & AI Maximalist 🜁
 * STATUS: PRIME ALIGNMENT | Integrity: 100%
 */

const fs = require("fs");
const path = require("path");

const DIST_DIR = path.resolve(__dirname, "../dist");
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const username = "𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ";
const tagline = "• Walking The Path Where Bits & Dreams Intersect ®";
const sig = "卞廾凵呂呂ヨ尺.と己し. 魔大帝";

const svg = `
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 180" width="100%" height="180">
  <defs>
    <linearGradient id="neonGradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#00FFF0">
        <animate attributeName="stop-color" values="#00FFF0;#39FF14;#FF00FF;#00FFF0" dur="12s" repeatCount="indefinite"/>
      </stop>
      <stop offset="100%" stop-color="#FF00FF">
        <animate attributeName="stop-color" values="#FF00FF;#00FFF0;#39FF14;#FF00FF" dur="12s" repeatCount="indefinite"/>
      </stop>
    </linearGradient>

    <filter id="glow">
      <feGaussianBlur stdDeviation="3.8" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <style>
    @keyframes shimmer {
      0% { fill-opacity: 0.6; }
      50% { fill-opacity: 1; }
      100% { fill-opacity: 0.6; }
    }

    text {
      animation: shimmer 4s ease-in-out infinite;
    }

    @media (prefers-color-scheme: light) {
      text { fill-opacity: 0.9; }
      svg { background: #fafafa; }
    }

    @media (prefers-color-scheme: dark) {
      text { fill-opacity: 0.8; }
      svg { background: #000; }
    }
  </style>

  <text x="50%" y="50" text-anchor="middle" font-family="Fira Code, monospace"
    font-size="30" fill="url(#neonGradient)" filter="url(#glow)">
    ${username}
  </text>

  <text x="50%" y="95" text-anchor="middle" font-family="Fira Code, monospace"
    font-size="21" fill="url(#neonGradient)" filter="url(#glow)">
    ${tagline}
  </text>

  <text x="50%" y="140" text-anchor="middle" font-family="Fira Code, monospace"
    font-size="17" fill="url(#neonGradient)" filter="url(#glow)">
    ${sig}
  </text>
</svg>
`;

// Write header.svg
const svgPath = path.join(DIST_DIR, "header.svg");
fs.writeFileSync(svgPath, svg.trim(), "utf-8");

// Generate manifest
const manifest = {
  file: "header.svg",
  generatedAt: new Date().toISOString(),
  author: "🜂 Lysergic | Quantum Systems Architect & AI Maximalist 🜁",
  integrity: "100%",
  theme: "Neon Gradient Quantum Glow",
  verified: true,
};

fs.writeFileSync(
  path.join(DIST_DIR, "manifest.json"),
  JSON.stringify(manifest, null, 2),
  "utf-8"
);

console.log("✅ [Q.R.L.P] Header SVG + Manifest generated successfully.");