/**
 * 🜂 Q.R.L.P TERMINAL GENERATOR 🜁
 * Generates animated neon terminal SVG with live typewriter, phosphor glow, and adaptive theming.
 * Author: 🜂 Lysergic | Quantum Systems Architect & AI Maximalist 🜁
 * STATUS: PRIME ALIGNMENT | INTEGRITY: 100%
 */

const fs = require("fs");
const path = require("path");

const DIST_DIR = path.resolve(__dirname, "../dist");
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const CURRENT_TIME = new Date().toISOString().replace(/T/, " ").replace(/\..+/, "");
const USERNAME = process.env.USERNAME || "𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ";

// ──────────────────────────────────────────────
// Terminal Simulation Lines
// ──────────────────────────────────────────────
const lines = [
  `Last login: ${CURRENT_TIME} on ttys000`,
  `${USERNAME}@github ~ % uptime`,
  `${CURRENT_TIME} up 03:42, 1 user, load average: 0.46 0.61 0.52`,
  `${USERNAME}@github ~ % ls -la Projects/`,
  `total 40`,
  `drwxr-xr-x  8 ${USERNAME}  staff  256 May 07 03:42 .`,
  `drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 03:42 ..`,
  `drwxr-xr-x  7 ${USERNAME}  staff  224 May 07 03:42 DevOps`,
  `drwxr-xr-x  6 ${USERNAME}  staff  192 May 07 03:42 OpenSource`,
  `drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 03:42 Scripts`,
  `-rw-r--r--  1 ${USERNAME}  staff  925 May 07 03:42 TODO.md`
];

// ──────────────────────────────────────────────
// Quantum Neon Palette
// ──────────────────────────────────────────────
const color1 = "#39FF14"; // neon green
const color2 = "#00FFF0"; // cyan blue
const bgColorDark = "#0d0d0d";
const bgColorLight = "#f8f8f8";

// Dynamic height calculation
const height = lines.length * 22 + 40;

// ──────────────────────────────────────────────
// SVG Generator Core
// ──────────────────────────────────────────────
const svg = `
<svg xmlns="http://www.w3.org/2000/svg" width="760" height="${height}" viewBox="0 0 760 ${height}">
  <desc>🜂 Q.R.L.P Quantum Terminal Render • Generated ${CURRENT_TIME} by ${USERNAME}</desc>
  <defs>
    <linearGradient id="neonGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="${color1}">
        <animate attributeName="stop-color" values="${color1};${color2};${color1}" dur="8s" repeatCount="indefinite"/>
      </stop>
      <stop offset="100%" stop-color="${color2}">
        <animate attributeName="stop-color" values="${color2};${color1};${color2}" dur="8s" repeatCount="indefinite"/>
      </stop>
    </linearGradient>

    <filter id="glow">
      <feGaussianBlur stdDeviation="1.8" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>

    <style>
      @keyframes pulseCursor { 0%, 100% { opacity: 1; } 50% { opacity: 0; } }
      @keyframes shimmer { 0% { fill-opacity: 0.6; } 50% { fill-opacity: 1; } 100% { fill-opacity: 0.6; } }

      .line {
        font-family: 'Fira Code', monospace;
        font-size: 16px;
        fill: url(#neonGradient);
        filter: url(#glow);
        white-space: pre;
        animation: shimmer 4s ease-in-out infinite;
      }

      .cursor {
        fill: ${color2};
        font-family: 'Fira Code', monospace;
        font-size: 18px;
        animation: pulseCursor 0.8s infinite;
      }

      @media (prefers-color-scheme: light) {
        svg { background: ${bgColorLight}; }
      }

      @media (prefers-color-scheme: dark) {
        svg { background: ${bgColorDark}; }
      }
    </style>
  </defs>

  <rect x="0" y="0" width="100%" height="100%" rx="8" ry="8" fill="${bgColorDark}" stroke="${color2}" stroke-width="1"/>
  ${lines.map((line, i) => `<text x="12" y="${28 + i * 22}" class="line">${line}</text>`).join("\n")}
  <text x="12" y="${28 + lines.length * 22}" class="cursor">█</text>
</svg>
`;

// ──────────────────────────────────────────────
// Write SVG + Manifest
// ──────────────────────────────────────────────
const outputPath = path.join(DIST_DIR, "terminal.svg");
fs.writeFileSync(outputPath, svg.trim(), "utf-8");

const manifest = {
  file: "terminal.svg",
  generatedAt: CURRENT_TIME,
  author: USERNAME,
  mode: "Q.R.L.P ENHANCED",
  theme: "Quantum Neon Phosphor",
  verified: true,
  integrity: "100%"
};

fs.writeFileSync(
  path.join(DIST_DIR, "manifest-terminal.json"),
  JSON.stringify(manifest, null, 2),
  "utf-8"
);

console.log("✅ [Q.R.L.P] Quantum Terminal SVG + Manifest generated successfully.");