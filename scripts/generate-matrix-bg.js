// scripts/generate-matrix-bg.js - 3D Matrix Background with Particle Effects
const fs = require('fs');

class MatrixBackground {
  constructor() {
    this.width = 1200;
    this.height = 400;
    this.columns = 40;
    this.rows = 15;
    this.chars = '01ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+-=[]{}|;:,.<>?αβγδεζηθικλμνξοπρστυφχψω∀∃∈∉∋∌∅∆∇∂∫∮∑∏∞';
  }

  generateMatrixColumn(colIndex) {
    const charCount = Math.floor(Math.random() * 8) + 5;
    const startDelay = Math.random() * 10;
    const duration = Math.random() * 15 + 10;
    const xPos = (colIndex * this.width / this.columns) + Math.random() * 20 - 10;
    
    let column = '';
    
    for (let i = 0; i < charCount; i++) {
      const char = this.chars[Math.floor(Math.random() * this.chars.length)];
      const yStart = -50 + (i * 25);
      const yEnd = this.height + 50;
      const opacity = Math.max(0.1, 1 - (i * 0.15));
      const fontSize = Math.floor(Math.random() * 8) + 12;
      
      column += `
        <text x="${xPos}" y="${yStart}" 
              font-family="monospace" 
              font-size="${fontSize}px" 
              fill="#00ff41" 
              fill-opacity="${opacity}"
              font-weight="${Math.random() > 0.7 ? 'bold' : 'normal'}">
          ${char}
          <animateTransform
            attributeName="transform"
            type="translate"
            values="0 0; 0 ${yEnd - yStart}"
            dur="${duration}s"
            begin="${startDelay}s"
            repeatCount="indefinite"/>
          <animate
            attributeName="fill-opacity"
            values="${opacity}; 0; ${opacity}"
            dur="${duration}s"
            begin="${startDelay}s"
            repeatCount="indefinite"/>
        </text>`;
    }
    
    return column;
  }

  generateParticleEffect() {
    let particles = '';
    const particleCount = 20;
    
    for (let i = 0; i < particleCount; i++) {
      const x = Math.random() * this.width;
      const y = Math.random() * this.height;
      const size = Math.random() * 3 + 1;
      const duration = Math.random() * 20 + 10;
      const delay = Math.random() * 5;
      
      particles += `
        <circle cx="${x}" cy="${y}" r="${size}" fill="#00ff41" fill-opacity="0.6">
          <animate
            attributeName="r"
            values="${size}; ${size * 2}; ${size}"
            dur="${duration}s"
            begin="${delay}s"
            repeatCount="indefinite"/>
          <animate
            attributeName="fill-opacity"
            values="0.6; 0.1; 0.6"
            dur="${duration}s"
            begin="${delay}s"
            repeatCount="indefinite"/>
        </circle>`;
    }
    
    return particles;
  }

  generateQuantumGrid() {
    let grid = '';
    const gridSpacing = 50;
    
    // Vertical lines
    for (let x = 0; x <= this.width; x += gridSpacing) {
      grid += `
        <line x1="${x}" y1="0" x2="${x}" y2="${this.height}" 
              stroke="#003311" stroke-width="0.5" stroke-opacity="0.3">
          <animate
            attributeName="stroke-opacity"
            values="0.3; 0.6; 0.3"
            dur="${Math.random() * 10 + 5}s"
            repeatCount="indefinite"/>
        </line>`;
    }
    
    // Horizontal lines
    for (let y = 0; y <= this.height; y += gridSpacing) {
      grid += `
        <line x1="0" y1="${y}" x2="${this.width}" y2="${y}" 
              stroke="#003311" stroke-width="0.5" stroke-opacity="0.3">
          <animate
            attributeName="stroke-opacity"
            values="0.3; 0.6; 0.3"
            dur="${Math.random() * 10 + 5}s"
            repeatCount="indefinite"/>
        </line>`;
    }
    
    return grid;
  }

  generatePulsingBorder() {
    return `
      <rect x="2" y="2" width="${this.width - 4}" height="${this.height - 4}" 
            fill="none" stroke="#00ff41" stroke-width="2" rx="8">
        <animate
          attributeName="stroke-opacity"
          values="0.3; 1; 0.3"
          dur="3s"
          repeatCount="indefinite"/>
        <animate
          attributeName="stroke-width"
          values="2; 4; 2"
          dur="3s"
          repeatCount="indefinite"/>
      </rect>`;
  }

  generateMatrix() {
    let matrixColumns = '';
    
    for (let col = 0; col < this.columns; col++) {
      matrixColumns += this.generateMatrixColumn(col);
    }
    
    const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg width="${this.width}" height="${this.height}" viewBox="0 0 ${this.width} ${this.height}" 
     xmlns="http://www.w3.org/2000/svg">
  
  <defs>
    <filter id="glow" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur stdDeviation="2" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
    
    <radialGradient id="bgGrad" cx="50%" cy="50%" r="80%">
      <stop offset="0%" stop-color="#000811"/>
      <stop offset="100%" stop-color="#000000"/>
    </radialGradient>
    
    <linearGradient id="scanline" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" stop-color="#00ff41" stop-opacity="0"/>
      <stop offset="50%" stop-color="#00ff41" stop-opacity="0.1"/>
      <stop offset="100%" stop-color="#00ff41" stop-opacity="0"/>
    </linearGradient>
  </defs>
  
  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#bgGrad)"/>
  
  <!-- Quantum Grid -->
  <g opacity="0.4">
    ${this.generateQuantumGrid()}
  </g>
  
  <!-- Matrix Effect -->
  <g filter="url(#glow)" opacity="0.8">
    ${matrixColumns}
  </g>
  
  <!-- Particle Effects -->
  <g opacity="0.7">
    ${this.generateParticleEffect()}
  </g>
  
  <!-- Scanning Line Effect -->
  <rect width="100%" height="4" fill="url(#scanline)">
    <animateTransform
      attributeName="transform"
      type="translate"
      values="0 0; 0 ${this.height}; 0 0"
      dur="8s"
      repeatCount="indefinite"/>
  </rect>
  
  <!-- Pulsing Border -->
  ${this.generatePulsingBorder()}
  
  <!-- Corner Indicators -->
  <g stroke="#00ff41" stroke-width="2" fill="none">
    <path d="M 20 20 L 20 5 L 5 5" opacity="0.7">
      <animate attributeName="opacity" values="0.7; 1; 0.7" dur="2s" repeatCount="indefinite"/>
    </path>
    <path d="M ${this.width - 20} 20 L ${this.width - 20} 5 L ${this.width - 5} 5" opacity="0.7">
      <animate attributeName="opacity" values="0.7; 1; 0.7" dur="2s" begin="0.5s" repeatCount="indefinite"/>
    </path>
    <path d="M 20 ${this.height - 20} L 20 ${this.height - 5} L 5 ${this.height - 5}" opacity="0.7">
      <animate attributeName="opacity" values="0.7; 1; 0.7" dur="2s" begin="1s" repeatCount="indefinite"/>
    </path>
    <path d="M ${this.width - 20} ${this.height - 20} L ${this.width - 20} ${this.height - 5} L ${this.width - 5} ${this.height - 5}" opacity="0.7">
      <animate attributeName="opacity" values="0.7; 1; 0.7" dur="2s" begin="1.5s" repeatCount="indefinite"/>
    </path>
  </g>
  
</svg>`;

    return svg;
  }
}

// Generate the matrix background
const matrix = new MatrixBackground();
const svg = matrix.generateMatrix();

// Ensure dist directory exists
if (!fs.existsSync('dist')) {
  fs.mkdirSync('dist', { recursive: true });
}

fs.writeFileSync('dist/matrix-bg.svg', svg);
console.log('✅ 3D Matrix background with particle effects generated');