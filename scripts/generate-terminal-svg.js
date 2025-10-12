// scripts/generate-terminal-svg.js
const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

const USERNAME = "𖢧ꛅ𖤢ꚽꚳꛈ𖢧ꛕꛅ";
const CURRENT_TIME = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '');
const lines = [
  `Last login: ${CURRENT_TIME} on ttys000`,
  `${USERNAME}@github ~ % uptime`,
  `${CURRENT_TIME} up 02:51, 1 user, load average: 0.56 0.62 0.48`,
  `${USERNAME}@github ~ % ls -la Projects/`,
  `total 40`,
  `drwxr-xr-x  8 ${USERNAME}  staff  256 May 07 02:51 .`,
  `drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 02:51 ..`,
  `drwxr-xr-x  7 ${USERNAME}  staff  224 May 07 02:51 DevOps`,
  `drwxr-xr-x  6 ${USERNAME}  staff  192 May 07 02:51 OpenSource`,
  `drwxr-xr-x  5 ${USERNAME}  staff  160 May 07 02:51 Scripts`,
  `-rw-r--r--  1 ${USERNAME}  staff  925 May 07 02:51 TODO.md`
];

const color1 = "#39FF14";
const color2 = "#00FFF0";

let svg = `<svg width="700" height="${lines.length * 22 + 20}" xmlns="http://www.w3.org/2000/svg">
  <rect width="100%" height="100%" rx="8" ry="8" fill="#0d0d0d" stroke="${color2}" stroke-width="1"/>
  <style>
    .line { font-family: monospace; font-size: 16px; fill: ${color1}; white-space: pre; }
    .cursor { fill: ${color2}; }
    .typing { animation: typing 4s steps(40, end) forwards; }
    @keyframes typing { from { width: 0 } to { width: 100% } }
  </style>`;

lines.forEach((line, idx) => {
  const y = 20 + idx * 20;
  svg += `<text x="10" y="${y}" class="line typing">${line}</text>`;
});

svg += `<text x="10" y="${20 + lines.length * 20}" class="line cursor">_</text></svg>`;

fs.writeFileSync(path.join(DIST_DIR, 'terminal.svg'), svg);
console.log("✅ Terminal SVG generated");