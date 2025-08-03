// scripts/fetch-quote.js

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
      const cleanQuote = quoteText.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");

// scripts/fetch-quote.js - Enhanced with AI-style animations and effects

process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

const fs = require('fs');
const https = require('https');

const endpoints = [
  'https://zenquotes.io/api/random',
  // Fallback tech quotes
  null
];

const techQuotes = [
  "The future belongs to those who learn more skills and combine them in creative ways. — Robert Greene",
  "Any sufficiently advanced technology is indistinguishable from magic. — Arthur C. Clarke", 
  "The best way to predict the future is to invent it. — Alan Kay",
  "Code is like humor. When you have to explain it, it's bad. — Cory House",
  "First, solve the problem. Then, write the code. — John Johnson",
  "Experience is the name everyone gives to their mistakes. — Oscar Wilde",
  "In order to be irreplaceable, one must always be different. — Coco Chanel",
  "Programming isn't about what you know; it's about what you can figure out. — Chris Pine"
];

function generateTechQuote() {
  const quote = techQuotes[Math.floor(Math.random() * techQuotes.length)];
  return { q: quote.split(' — ')[0], a: quote.split(' — ')[1] || 'Tech Wisdom' };
}

function createEnhancedQuoteSVG(quoteText) {
  const cleanQuote = quoteText.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
  
  return `<svg viewBox="0 0 900 200" width="100%" height="200" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="terminalBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0d1117"/>
      <stop offset="50%" stop-color="#161b22"/>
      <stop offset="100%" stop-color="#21262d"/>
    </linearGradient>
    
    <filter id="glow" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur stdDeviation="3" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
    
    <filter id="scanlines">
      <feFlood flood-color="#00ff41" flood-opacity="0.1" result="flood"/>
      <feComposite in="flood" in2="SourceGraphic" operator="multiply"/>
    </filter>
  </defs>

  <!-- Background with animated gradient -->
  <rect width="900" height="200" fill="url(#terminalBg)" rx="12"/>
  
  <!-- Animated border -->
  <rect x="2" y="2" width="896" height="196" rx="10" fill="none" 
        stroke="#00ff41" stroke-width="2" opacity="0.6">
    <animate attributeName="opacity" values="0.6; 1; 0.6" dur="3s" repeatCount="indefinite"/>
  </rect>
  
  <!-- Terminal header -->
  <rect x="10" y="10" width="880" height="25" rx="8" fill="#1a1a1a"/>
  <circle cx="25" cy="22" r="4" fill="#ff5f56"/>
  <circle cx="40" cy="22" r="4" fill="#ffbd2e"/>
  <circle cx="55" cy="22" r="4" fill="#27ca3f"/>
  <text x="80" y="27" font-family="monospace" font-size="12" fill="#8b949e">
    quantum-terminal v2.1 • AI Enhanced
  </text>
  
  <!-- Matrix effect background -->
  <g opacity="0.1">
    ${Array.from({length: 20}, (_, i) => `
      <text x="${i * 45}" y="60" font-family="monospace" font-size="10" fill="#00ff41">
        ${Math.random() > 0.5 ? '1' : '0'}
        <animateTransform attributeName="transform" type="translate" 
                         values="0 0; 0 200; 0 0" dur="${5 + Math.random() * 10}s" 
                         repeatCount="indefinite"/>
      </text>
    `).join('')}
  </g>
  
  <!-- Quote content with typewriter effect -->
  <foreignObject x="30" y="50" width="840" height="120">
    <div xmlns="http://www.w3.org/1999/xhtml" style="color: #00ff41; font-family: 'Courier New', monospace; font-size: 16px; line-height: 1.6;">
      <div style="opacity: 0; animation: fadeInType 4s ease-in forwards;">
        "${cleanQuote}"
      </div>
    </div>
  </foreignObject>
  
  <!-- Cursor with enhanced animation -->
  <rect x="50" y="150" width="12" height="20" fill="#00ff41" opacity="0.8">
    <animate attributeName="opacity" values="0.8; 0; 0.8" dur="1s" repeatCount="indefinite"/>
    <animate attributeName="width" values="12; 15; 12" dur="1s" repeatCount="indefinite"/>
  </rect>
  
  <!-- Scanning line effect -->
  <line x1="30" y1="170" x2="870" y2="170" stroke="#00ff41" stroke-width="1" opacity="0.5">
    <animate attributeName="x2" values="30; 870; 30" dur="8s" repeatCount="indefinite"/>
    <animate attributeName="opacity" values="0.5; 1; 0.5" dur="8s" repeatCount="indefinite"/>
  </line>
  
  <!-- Corner indicators -->
  <g stroke="#00ff41" stroke-width="2" fill="none" opacity="0.7">
    <path d="M 20 20 L 20 15 L 15 15">
      <animate attributeName="opacity" values="0.7; 1; 0.7" dur="2s" repeatCount="indefinite"/>
    </path>
    <path d="M 880 20 L 880 15 L 885 15">
      <animate attributeName="opacity" values="0.7; 1; 0.7" dur="2s" begin="0.5s" repeatCount="indefinite"/>
    </path>
    <path d="M 20 180 L 20 185 L 15 185">
      <animate attributeName="opacity" values="0.7; 1; 0.7" dur="2s" begin="1s" repeatCount="indefinite"/>
    </path>
    <path d="M 880 180 L 880 185 L 885 185">
      <animate attributeName="opacity" values="0.7; 1; 0.7" dur="2s" begin="1.5s" repeatCount="indefinite"/>
    </path>
  </g>
  
  <style>
    @keyframes fadeInType {
      0% { opacity: 0; width: 0; }
      50% { opacity: 1; }
      100% { opacity: 1; width: 100%; }
    }
  </style>
</svg>`;

      fs.writeFileSync('dist/quote.svg', svg.trim());
      console.log("✅ Quote with typewriter & blinking cursor saved.");
    } catch (e) {
      console.error("❌ Failed to parse quote:", e.message);
      process.exit(1);
    }
  });

}).on('error', (err) => {
  console.error('❌ HTTPS error:', err.message);
  process.exit(1);
});