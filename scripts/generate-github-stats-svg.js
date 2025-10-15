#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import fetch from 'node-fetch';

const DIST_DIR = path.resolve('./dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const STATS_SVG = path.join(DIST_DIR, 'github-stats.svg');
const USER = 'Thugger069';
const REPOS = ['cryptovault']; // optionally multiple repos

async function fetchGitHubStats(user, repos) {
  const stats = { followers: 0, stars: 0, commits: 0 };
  try {
    const userData = await fetch(`https://api.github.com/users/${user}`)
      .then(res => res.json());
    stats.followers = userData.followers;

    for (const repo of repos) {
      const repoData = await fetch(`https://api.github.com/repos/${user}/${repo}`)
        .then(res => res.json());
      stats.stars += repoData.stargazers_count || 0;
    }
  } catch (e) {
    console.error('⚠ Failed to fetch GitHub stats:', e);
  }
  return stats;
}

function generateAnimatedCounter(x, y, label, value, delay = 0) {
  return `
    <text x="${x}" y="${y}" font-family="Monaco, Consolas, monospace" font-size="20" fill="#00ffcc" class="counter">
      ${label}: 
      <tspan class="value">0</tspan>
      <animate 
        attributeName="opacity" 
        values="0.2;1;0.2" 
        dur="2s" 
        begin="${delay}s" 
        repeatCount="indefinite"/>
      <set attributeName="textContent" to="${value}" begin="0.1s"/>
    </text>`;
}

function generateParticles(count) {
  return Array.from({ length: count }).map(() => {
    const cx = Math.random() * 400;
    const cy = Math.random() * 120;
    const r = 1 + Math.random() * 2;
    const dur = 2 + Math.random() * 3;
    return `<circle cx="${cx}" cy="${cy}" r="${r}" fill="#00ffcc" opacity="0.5">
      <animate attributeName="cy" values="${cy};${cy + 20};${cy}" dur="${dur}s" repeatCount="indefinite"/>
      <animate attributeName="fill" values="#00ffcc;#ff00ff;#00ffcc" dur="3s" repeatCount="indefinite"/>
    </circle>`;
  }).join('\n  ');
}

(async () => {
  const stats = await fetchGitHubStats(USER, REPOS);

  const svgContent = `
<svg width="400" height="120" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <style>
      .counter { cursor: default; transition: fill 0.3s; }
      .counter:hover { fill: #ff00ff; }
    </style>
  </defs>

  ${generateAnimatedCounter(20, 30, 'Followers', stats.followers, 0)}
  ${generateAnimatedCounter(20, 60, 'Stars', stats.stars, 0.2)}

  ${generateParticles(40)}
</svg>`;

  fs.writeFileSync(STATS_SVG, svgContent, 'utf8');
  console.log('✅ Generated animated GitHub stats SVG with hover & particle effects');
})();
