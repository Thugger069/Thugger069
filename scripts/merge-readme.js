/**
 * ╔══════════════════════════════════════════════════════════════════╗
 * ║ Q.R.I.P ALL-IN: README Quantum Merger                            ║
 * ║ Merges neon SVG assets + live badges + quote block + signature   ║
 * ║ Layered: Header → Terminal → Particles → Snake → Quote + Stats   ║
 * ╚══════════════════════════════════════════════════════════════════╝
 */

import fs from "fs";
import path from "path";

const ROOT = path.resolve(process.cwd(), ".");
const DIST = path.join(ROOT, "dist");
const LOG_DIR = path.join(ROOT, "logs");
const README = path.join(ROOT, "README.md");
const BACKUP = path.join(LOG_DIR, `README_BACKUP_${Date.now()}.md`);

// SVG Assets
const assets = {
  header: "header.svg",
  terminal: "terminal.svg",
  particles: "particles.svg",
  snake: "snake.svg",
  quote: "quote.svg",
  followers: "github-followers.svg",
  stars: "github-stars.svg",
};

// Signature Block
const SIGNATURE = `
𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ • Walking The Path Where Bits & Dreams Intersect ®  
🜂 Q.R.I.P ACTIVE | Integrity: 100% | Pulse Synced 🜁
`;

// Utility: Safe read
const readSafe = (p) => (fs.existsSync(p) ? fs.readFileSync(p, "utf8") : "");

// Main injector
function mergeReadme() {
  console.log("🧩 Initiating Q.R.I.P Merge Protocol...");

  fs.mkdirSync(LOG_DIR, { recursive: true });
  const oldReadme = readSafe(README);
  fs.writeFileSync(BACKUP, oldReadme);
  console.log(`💾 Backup created → ${BACKUP}`);

  // Timestamp for regeneration tracking
  const TIMESTAMP = new Date().toISOString();

  // Build the new visual block
  const section = `
<!-- Q.R.I.P:START -->
<p align="center">
  <img src="./dist/${assets.header}" width="100%" alt="Quantum Header" />
</p>

<p align="center">
  <img src="./dist/${assets.terminal}" width="700" alt="Quantum Terminal" />
</p>

<p align="center">
  <img src="./dist/${assets.particles}" width="100%" alt="Quantum Particle Field" />
</p>

<p align="center">
  <img src="./dist/${assets.quote}" width="600" alt="Quantum Quote" />
</p>

<p align="center">
  <img src="./dist/${assets.snake}" width="100%" alt="Activity Snake" />
</p>

<p align="center">
  <img src="./dist/${assets.followers}" height="22" alt="Followers Badge" />
  <img src="./dist/${assets.stars}" height="22" alt="Stars Badge" />
</p>

---

<p align="center"><sub>${SIGNATURE}</sub></p>
<p align="center"><sub>Last Regeneration: ${TIMESTAMP}</sub></p>
<!-- Q.R.I.P:END -->
  `.trim();

  // Replace or append Q.R.I.P section
  const START = "<!-- Q.R.I.P:START -->";
  const END = "<!-- Q.R.I.P:END -->";
  let updated;

  if (oldReadme.includes(START) && oldReadme.includes(END)) {
    updated = oldReadme.replace(
      new RegExp(`${START}[\\s\\S]*?${END}`, "m"),
      section
    );
  } else {
    updated = `${oldReadme.trim()}\n\n${section}`;
  }

  fs.writeFileSync(README, updated.trim() + "\n");
  console.log("✅ Quantum README merge completed successfully ⚡");
}

mergeReadme();