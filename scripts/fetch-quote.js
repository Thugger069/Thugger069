// fetch-quote.js
const https = require('https');
const fs = require('fs');
const path = require('path');

const QUOTE_API = 'https://api.quotable.io/random';

https.get(QUOTE_API, (res) => {
  let data = '';
  res.on('data', chunk => (data += chunk));
  res.on('end', () => {
    const { content, author } = JSON.parse(data);

    const svg = `
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="100" viewBox="0 0 800 100">
  <style>
    text { fill: white; font-family: monospace; font-size: 16px; }
    .glow { animation: glow 3s ease-in-out infinite alternate; }
    @keyframes glow {
      0% { fill: #00ffff; }
      100% { fill: #ff00ff; }
    }
  </style>
  <rect width="100%" height="100%" fill="black"/>
  <text x="20" y="50" class="glow">
    "${content}" — ${author}
  </text>
</svg>`;

    fs.writeFileSync(path.join(__dirname, '../dist/quote.svg'), svg.trim());
    console.log('✔️  Quote SVG generated.');
  });
});