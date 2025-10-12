process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

const fs = require('fs');
const https = require('https');

const endpoint = 'https://zenquotes.io/api/random';

https.get(endpoint, (res) => {
  let data = '';

  res.on('data', chunk => data += chunk);
  res.on('end', () => {
    try {
      const json = JSON.parse(data)[0];
      const quoteText = `${json.q} — ${json.a}`;
      const cleanQuote = quoteText
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");

      const svg = `
<svg viewBox="0 0 800 160" width="100%" height="160" xmlns="http://www.w3.org/2000/svg">
  <style>
    .bg {
      fill: #0d0d0d;
      stroke: #00fff0;
      stroke-width: 2;
      rx: 20;
      filter: url(#glow);
    }

    .text {
      font-family: 'Fira Code', monospace;
      font-size: 18px;
      fill: #00fff0;
      white-space: pre;
    }

    .cursor {
      animation: blink 1s steps(1) infinite;
    }

    .typing {
      animation: typing 4s steps(${cleanQuote.length}, end) 1;
      overflow: hidden;
      white-space: nowrap;
      width: 0;
    }

    @keyframes blink {
      0%, 49% { opacity: 1; }
      50%, 100% { opacity: 0; }
    }

    @keyframes typing {
      from { width: 0 }
      to { width: ${cleanQuote.length}ch; }
    }

    @media (prefers-color-scheme: light) {
      .bg { fill: #ffffff; stroke: #0d0d0d; }
      .text { fill: #0d0d0d; }
    }
  </style>

  <defs>
    <filter id="glow">
      <feGaussianBlur stdDeviation="3.5" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <rect x="10" y="10" width="780" height="140" rx="16" class="bg"/>
  <foreignObject x="30" y="30" width="740" height="100">
    <div xmlns="http://www.w3.org/1999/xhtml" style="color: inherit;">
      <span class="text typing">${cleanQuote}</span><span class="text cursor">█</span>
    </div>
  </foreignObject>
</svg>
`;

      fs.writeFileSync('dist/quote.svg', svg.trim());
      console.log("✅ Quote SVG generated with typewriter & blinking cursor effect.");
    } catch (e) {
      console.error("❌ Failed to parse quote:", e.message);
      process.exit(1);
    }
  });
}).on('error', (err) => {
  console.error('❌ HTTPS error:', err.message);
  process.exit(1);
});