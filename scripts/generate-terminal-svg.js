// scripts/generate-terminal-svg.js
const fs = require('fs');

const terminalOutput = `
Last login: ${new Date().toUTCString()} on ttys000
𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ@github ~ % uptime
  14:02  up 2:51, 1 user, load averages: 0.56 0.62 0.48

𖢧ꛅ𖤢 ꚽꚳꛈ𖢧ꛕꛅ@github ~ % ls -la Projects/
total 40
drwxr-xr-x  8 user  staff  256 May 07 02:51 .
drwxr-xr-x  5 user  staff  160 May 07 02:51 ..
drwxr-xr-x  7 user  staff  224 May 07 02:51 DevOps
drwxr-xr-x  6 user  staff  192 May 07 02:51 OpenSource
drwxr-xr-x  5 user  staff  160 May 07 02:51 Scripts
-rw-r--r--  1 user  staff  925 May 07 02:51 TODO.md
`;

const svg = `
<svg viewBox="0 0 800 320" xmlns="http://www.w3.org/2000/svg">
  <style>
    .bg { fill: #0d0d0d; stroke: #00fff0; stroke-width: 2; rx: 16; filter: url(#glow); }
    .text { font-family: 'Fira Code', monospace; font-size: 14px; fill: #00fff0; white-space: pre; }
    .cursor { animation: blink 1s steps(1) infinite; }
    .typing { animation: typing 6s steps(${terminalOutput.length}, end) 1; overflow: hidden; white-space: nowrap; width: 0; }
    @keyframes blink { 0%,49%{opacity:1}50%,100%{opacity:0} }
    @keyframes typing { from{width:0} to{width:${terminalOutput.length}ch} }
    @media (prefers-color-scheme: light) {
      .bg { fill: #ffffff; stroke: #0d0d0d; }
      .text { fill: #0d0d0d; }
    }
  </style>
  <defs>
    <filter id="glow"><feGaussianBlur stdDeviation="3.5" result="coloredBlur"/>
      <feMerge><feMergeNode in="coloredBlur"/><feMergeNode in="SourceGraphic"/></feMerge>
    </filter>
  </defs>
  <rect x="10" y="10" width="780" height="300" rx="16" class="bg"/>
  <foreignObject x="20" y="20" width="760" height="280">
    <div xmlns="http://www.w3.org/1999/xhtml" style="color: inherit;">
      <span class="text typing">${terminalOutput}</span><span class="text cursor">█</span>
    </div>
  </foreignObject>
</svg>
`;

fs.writeFileSync('dist/terminal.svg', svg.trim());
console.log("✅ Enhanced terminal.svg generated successfully.");