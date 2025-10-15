// scripts/generate-terminal-svg.js
const fs = require('fs');
const path = require('path');

const DIST_DIR = path.resolve(__dirname, '../dist');
if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR, { recursive: true });

// Configuration with your specific usernames
const DISPLAY_NAME = "ɬɧɛ ɠıɬƈɧ";
const GITHUB_USERNAME = "Thugger069";
const CURRENT_TIME = new Date().toUTCString().replace(/GMT/, 'UTC');

// Color schemes for different themes
const THEMES = {
  matrix: {
    background: '#0d0d0d',
    text: '#39FF14',
    accent: '#00FFF0',
    border: '#00FF00'
  },
  cyberpunk: {
    background: '#1a1b26',
    text: '#7dcfff',
    accent: '#bb9af7',
    border: '#2ac3de'
  },
  hacker: {
    background: '#000000',
    text: '#00ff00',
    accent: '#ffff00',
    border: '#00ff00'
  }
};

// Select theme (you can rotate these or choose one)
const THEME = THEMES.matrix;

// Enhanced terminal content with more realistic output
const generateTerminalContent = () => {
  const loadAvg = `${(Math.random() * 0.8 + 0.1).toFixed(2)} ${(Math.random() * 0.8 + 0.2).toFixed(2)} ${(Math.random() * 0.8 + 0.1).toFixed(2)}`;
  
  return [
    `Last login: ${CURRENT_TIME} on ttys001`,
    `${DISPLAY_NAME}@github ~ % whoami`,
    `${DISPLAY_NAME}`,
    '',
    `${DISPLAY_NAME}@github ~ % uname -a`,
    `Darwin github-pro 22.5.0 Darwin Kernel Version 22.5.0: x86_64`,
    '',
    `${DISPLAY_NAME}@github ~ % uptime`,
    `${CURRENT_TIME} up 14 days, 2:51, 1 user, load averages: ${loadAvg}`,
    '',
    `${DISPLAY_NAME}@github ~ % ls -la Projects/`,
    `total 48`,
    `drwxr-xr-x   9 ${DISPLAY_NAME}  staff   288 Jun 15 10:30 .`,
    `drwxr-xr-x   6 ${DISPLAY_NAME}  staff   192 Jun 15 10:30 ..`,
    `drwxr-xr-x   8 ${DISPLAY_NAME}  staff   256 Jun 15 10:30 .git`,
    `-rw-r--r--   1 ${DISPLAY_NAME}  staff   113 Jun 15 10:30 .gitignore`,
    `drwxr-xr-x   7 ${DISPLAY_NAME}  staff   224 Jun 15 10:30 DevOps`,
    `drwxr-xr-x   6 ${DISPLAY_NAME}  staff   192 Jun 15 10:30 OpenSource`,
    `drwxr-xr-x   5 ${DISPLAY_NAME}  staff   160 Jun 15 10:30 Scripts`,
    `-rw-r--r--   1 ${DISPLAY_NAME}  staff  1024 Jun 15 10:30 README.md`,
    `-rw-r--r--   1 ${DISPLAY_NAME}  staff   925 Jun 15 10:30 TODO.md`,
    '',
    `${DISPLAY_NAME}@github ~ % cat Projects/TODO.md`,
    `# 📋 Current Projects`,
    `## 🚀 Active Development`,
    `- [ ] Kubernetes cluster autoscaling`,
    `- [ ] Terraform multi-cloud deployment`,
    `- [ ] CI/CD pipeline optimization`,
    `- [ ] Monitoring stack with Prometheus & Grafana`,
    '',
    `${DISPLAY_NAME}@github ~ % docker ps`,
    `CONTAINER ID   IMAGE           COMMAND                  STATUS       PORTS     NAMES`,
    `a1b2c3d4e5f6   nginx:alpine    "nginx -g 'daemon off;" Up 2 hours   80/tcp    webserver`,
    `f6e5d4c3b2a1   redis:7-alpine  "docker-entrypoint.s…"  Up 2 hours   6379/tcp  cache`,
    '',
    `${DISPLAY_NAME}@github ~ %`
  ];
};

const lines = generateTerminalContent();

// Calculate dynamic height based on content
const LINE_HEIGHT = 18;
const PADDING = 20;
const height = lines.length * LINE_HEIGHT + PADDING * 2;

// Calculate dynamic width based on longest line
const maxLineLength = Math.max(...lines.map(line => line.length));
const CHAR_WIDTH = 8;
const width = Math.max(700, maxLineLength * CHAR_WIDTH + PADDING * 2);

// Generate blinking cursor animation
const cursorAnimation = `
  <animate attributeName="opacity" 
           values="1;0;1" 
           dur="1s" 
           repeatCount="indefinite" />
`;

// Generate typing animation for lines
const generateLineAnimations = (lines) => {
  let animations = '';
  let currentDelay = 0;
  
  lines.forEach((line, idx) => {
    if (line.trim() === '') {
      currentDelay += 0.2; // Short delay for empty lines
      return;
    }
    
    const duration = Math.max(0.5, line.length * 0.03); // Dynamic duration based on line length
    animations += `
    <text x="${PADDING}" y="${PADDING + idx * LINE_HEIGHT}" class="line" opacity="0">
      <animate attributeName="opacity" 
               from="0" to="1" 
               dur="0.1s" 
               begin="${currentDelay.toFixed(2)}s" 
               fill="freeze" />
      ${line}
    </text>`;
    
    currentDelay += duration;
  });
  
  return animations;
};

// Generate the complete SVG
const generateSVG = () => {
  return `<svg width="${width}" height="${height}" xmlns="http://www.w3.org/2000/svg">
  <!-- Background with gradient -->
  <defs>
    <linearGradient id="bgGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="${THEME.background}" />
      <stop offset="100%" stop-color="#1a1a1a" />
    </linearGradient>
    <filter id="glow" x="-20%" y="-20%" width="140%" height="140%">
      <feGaussianBlur stdDeviation="2" result="coloredBlur"/>
      <feMerge> 
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <!-- Terminal window -->
  <rect width="100%" height="100%" rx="12" ry="12" fill="url(#bgGradient)" 
        stroke="${THEME.border}" stroke-width="2" filter="url(#glow)"/>
  
  <!-- Terminal header -->
  <rect x="0" y="0" width="100%" height="30" rx="12" ry="12" fill="${THEME.background}" 
        stroke="${THEME.border}" stroke-width="2"/>
  <circle cx="15" cy="15" r="4" fill="#ff5f56"/>
  <circle cx="30" cy="15" r="4" fill="#ffbd2e"/>
  <circle cx="45" cy="15" r="4" fill="#27ca3f"/>
  <text x="60" y="18" class="header">${DISPLAY_NAME}@github: ~</text>
  
  <style>
    .header { 
      font-family: 'Monaco', 'Consolas', 'Courier New', monospace; 
      font-size: 12px; 
      fill: ${THEME.text};
      font-weight: bold;
    }
    .line { 
      font-family: 'Monaco', 'Consolas', 'Courier New', monospace; 
      font-size: 14px; 
      fill: ${THEME.text};
      white-space: pre;
    }
    .accent { 
      fill: ${THEME.accent};
      font-weight: bold;
    }
    .comment { 
      fill: #666;
      font-style: italic;
    }
  </style>
  
  <!-- Terminal content with typing animation -->
  ${generateLineAnimations(lines)}
  
  <!-- Blinking cursor -->
  <text x="${PADDING}" y="${PADDING + (lines.length - 1) * LINE_HEIGHT + 4}" 
        class="line accent" font-weight="bold">█${cursorAnimation}</text>
  
  <!-- Footer with timestamp -->
  <text x="${width - PADDING}" y="${height - 5}" 
        text-anchor="end" class="comment" font-size="10">
    Generated: ${new Date().toISOString().split('T')[0]}
  </text>
</svg>`;
};

// Generate both dark and light themes
const generateThemedSVGs = () => {
  const svgDark = generateSVG();
  
  // Generate light theme variant
  const lightTheme = {
    background: '#ffffff',
    text: '#333333',
    accent: '#0366d6',
    border: '#d1d5da'
  };
  
  const svgLight = svgDark
    .replace(new RegExp(THEME.background, 'g'), lightTheme.background)
    .replace(new RegExp(THEME.text, 'g'), lightTheme.text)
    .replace(new RegExp(THEME.accent, 'g'), lightTheme.accent)
    .replace(new RegExp(THEME.border, 'g'), lightTheme.border)
    .replace('fill: #666', 'fill: #999'); // Adjust comment color for light mode

  return { svgDark, svgLight };
};

// Main execution
try {
  const { svgDark, svgLight } = generateThemedSVGs();
  
  // Write SVG files
  fs.writeFileSync(path.join(DIST_DIR, 'terminal.svg'), svgDark);
  fs.writeFileSync(path.join(DIST_DIR, 'terminal-light.svg'), svgLight);
  
  console.log("✅ Terminal SVGs generated successfully!");
  console.log(`📁 Files created:`);
  console.log(`   - dist/terminal.svg (dark theme)`);
  console.log(`   - dist/terminal-light.svg (light theme)`);
  console.log(`👤 Display Name: ${DISPLAY_NAME}`);
  console.log(`🔗 GitHub: ${GITHUB_USERNAME}`);
  console.log(`🕒 Generated at: ${new Date().toUTCString()}`);
  
} catch (error) {
  console.error('❌ Error generating terminal SVGs:', error);
  process.exit(1);
}