/**
 * 🜂 Q.R.L.P ENHANCED — generate-badges.js
 * Deterministic neon badge generator with CI-safe, reproducible output.
 */

import fs from 'fs';
import path from 'path';
import crypto from 'crypto';
import fetch from 'node-fetch';
import { makeBadge } from 'badge-maker';

const ROOT = process.cwd();
const DIST_DIR = path.join(ROOT, 'dist');
fs.mkdirSync(DIST_DIR, { recursive: true });

const template = {
  labelColor: '#0d0d0d',
  color: '#39FF14',
  style: 'flat',
  fontFamily: 'Fira Code, monospace',
};

function hashData(data) {
  return crypto.createHash('sha256').update(data).digest('hex');
}

async function safeFetch(url, label) {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 5000);
  try {
    const res = await fetch(url, { signal: controller.signal });
    if (!res.ok) throw new Error(`${label} fetch failed: ${res.statusText}`);
    const text = await res.text();
    clearTimeout(timeout);
    return text;
  } catch (err) {
    console.warn(`⚠️ ${label}: ${err.message} — fallback to local badge.`);
    const fallback = makeBadge({
      ...template,
      label,
      message: 'offline',
      color: '#FF00FF',
    });
    return fallback;
  }
}

// ----------------------------
// Generate Dynamic Badges
// ----------------------------
async function generateGitHubStatsBadge(username) {
  const url = `https://img.shields.io/github/followers/${username}?label=Followers&style=flat&color=39FF14&labelColor=0d0d0d`;
  const svg = await safeFetch(url, 'GitHub Followers');
  const file = path.join(DIST_DIR, 'github-followers.svg');
  fs.writeFileSync(file, svg);
  return { file: 'github-followers.svg', hash: hashData(svg) };
}

async function generateStarsBadge(username) {
  const url = `https://img.shields.io/github/stars/${username}?label=Stars&style=flat&color=FF00FF&labelColor=0d0d0d`;
  const svg = await safeFetch(url, 'GitHub Stars');
  const file = path.join(DIST_DIR, 'github-stars.svg');
  fs.writeFileSync(file, svg);
  return { file: 'github-stars.svg', hash: hashData(svg) };
}

function generateCustomBadge(label, message, color) {
  const svg = makeBadge({ ...template, label, message, color });
  const filename = `badge-${label.toLowerCase()}.svg`;
  const file = path.join(DIST_DIR, filename);
  fs.writeFileSync(file, svg);
  return { file: filename, hash: hashData(svg) };
}

// ----------------------------
// Main Execution
// ----------------------------
async function main() {
  const username = process.env.GITHUB_USER || 'Thugger069';
  const offline = process.argv.includes('--offline');

  console.log(`🧠 Q.R.L.P ENHANCED badge generation for @${username}`);
  const results = [];

  if (!offline) {
    results.push(await generateGitHubStatsBadge(username));
    results.push(await generateStarsBadge(username));
  } else {
    console.log('🚫 Offline mode active — skipping external fetches.');
  }

  results.push(generateCustomBadge('Q.R.I.P', 'ALL-IN', '#39FF14'));
  results.push(generateCustomBadge('Status', 'Quantum Ready', '#00FFF0'));

  // Manifest write
  const manifest = {
    generated: new Date().toISOString(),
    badges: results,
    system: 'Q.R.L.P ENHANCED',
    author: '𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ',
  };
  fs.writeFileSync(path.join(DIST_DIR, 'badges_meta.json'), JSON.stringify(manifest, null, 2));

  console.log('✅ All badges generated.');
  results.forEach(r => console.log(`🧬 ${r.file} → ${r.hash}`));
}

main();