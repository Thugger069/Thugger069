/**
 * Q.R.I.P ALL-IN: generate-badges.js
 * Generates dynamic neon badges for README.md
 */

import fs from 'fs';
import { makeBadge } from 'badge-maker';
import fetch from 'node-fetch';

const DIST_DIR = 'dist';
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR);

// Neon badge template
const template = {
  labelColor: '#0d0d0d',
  color: '#39FF14', // Neon green
  style: 'flat',
  fontFamily: 'Fira Code',
};

// ----------------------------
// Generate GitHub Stats Badge
// ----------------------------
async function generateGitHubStatsBadge(username) {
  const url = `https://img.shields.io/github/followers/${username}?label=Followers&style=flat&color=39FF14&labelColor=0d0d0d`;
  const res = await fetch(url);
  const svg = await res.text();
  fs.writeFileSync(`${DIST_DIR}/github-followers.svg`, svg);
  console.log('✅ Generated github-followers.svg');
}

// ----------------------------
// Generate Stars Badge
// ----------------------------
async function generateStarsBadge(username) {
  const url = `https://img.shields.io/github/stars/${username}?label=Stars&style=flat&color=FF00FF&labelColor=0d0d0d`;
  const res = await fetch(url);
  const svg = await res.text();
  fs.writeFileSync(`${DIST_DIR}/github-stars.svg`, svg);
  console.log('✅ Generated github-stars.svg');
}

// ----------------------------
// Generate Custom Neon Badge
// ----------------------------
function generateCustomBadge(label, message, color) {
  const svg = makeBadge({
    ...template,
    label,
    message,
    color,
  });
  fs.writeFileSync(`${DIST_DIR}/badge-${label.toLowerCase()}.svg`, svg);
  console.log(`✅ Generated badge-${label.toLowerCase()}.svg`);
}

// ----------------------------
// Main Execution
// ----------------------------
async function main() {
  const username = process.env.GITHUB_USER || 'thugger069';

  await generateGitHubStatsBadge(username);
  await generateStarsBadge(username);
  generateCustomBadge('Q.R.I.P', 'ALL-IN', '#39FF14');
  generateCustomBadge('Status', 'Quantum Ready', '#00FFF0');
}

main();