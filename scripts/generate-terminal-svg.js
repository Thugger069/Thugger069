// scripts/generate-terminal-svg.js
const fs = require('fs');

const uptime = new Date().toUTCString();
const loadAvg = Array.from({ length: 3 }, () =>
  (Math.random() * 1.5 + 0.1).toFixed(2)
);

const lines = [
  `[QUANTUM TERMINAL v1.4.2]`,
  `Last login: ${uptime}`,
  `> uptime --quantum`,
  `⏱ load average: ${loadAvg.join('  ')}`,
  `> measure qubits`,
  `Qubit[0]: |0⟩ ⇅`,
  `Qubit[1]: |1⟩ ↻`,
  `Qubit[2]: |ψ⟩ ⇄`
];

const startY = 45;
const lineHeight = 26;
const typingDelay = 1.2;

const animatedLines = lines.map((line, i) => {
  const delay = i * typingDelay;
  return `
    <text class="term-text" x="20" y="${startY + i * lineHeight}">
      <tspan textLength="0">
        <animate attributeName="textLength" values="0;${line.length}" dur="1s" begin="${delay}s" repeatCount="1" fill="freeze"/>
        ${line}
      </tspan>
    </text>
  `;
}).join('\n');

const totalCycleTime = (lines.length + 1) * typingDelay;

const svg = `<?xml version="1.0"?>
<svg width="800" height="300" xmlns="http://www.w3.org/2000/svg">
  <style>
    .term-bg { fill: #0e0e1a; }
    .term-text {
      font-family: 'Courier New', monospace;
      font-size: 16px;
      fill: #00ffee;
    }
    .cursor {
      animation: blink 1s steps(2, start) infinite;
    }
    @keyframes blink { to { visibility: hidden; } }
  </style>

  <rect class="term-bg" width="800" height="300" rx="12" ry="12"/>

  <g>
    ${animatedLines}
    <text class="term-text cursor" x="20" y="${startY + lines.length * lineHeight + 10}">▌</text>

    <!-- Loop fade out and reset -->
    <animateTransform
      attributeName="transform"
      type="translate"
      values="0 0; -800 0; 0 0"
      begin="0s;reset.end"
      dur="0.1s"
      repeatCount="indefinite"
      id="reset"
      fill="remove"
    />
  </g>
</svg>`;

fs.writeFileSync('assets/quantum_terminal.svg', svg);
console.log('✔️ Looping quantum terminal animation generated.');