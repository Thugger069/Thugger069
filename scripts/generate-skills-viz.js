// scripts/generate-skills-viz.js - Interactive Skills Visualization
const fs = require('fs');

class SkillsVisualization {
  constructor() {
    this.width = 800;
    this.height = 600;
    this.skills = [
      { name: 'JavaScript/TypeScript', level: 95, category: 'Frontend', trend: '+5%' },
      { name: 'React/Next.js', level: 90, category: 'Frontend', trend: '+3%' },
      { name: 'Node.js/Express', level: 88, category: 'Backend', trend: '+7%' },
      { name: 'Python/AI/ML', level: 85, category: 'AI/ML', trend: '+12%' },
      { name: 'Docker/Kubernetes', level: 82, category: 'DevOps', trend: '+8%' },
      { name: 'AWS/Cloud', level: 80, category: 'Cloud', trend: '+6%' },
      { name: 'GraphQL/Apollo', level: 78, category: 'API', trend: '+4%' },
      { name: 'WebAssembly', level: 65, category: 'Emerging', trend: '+15%' },
      { name: 'Rust/Systems', level: 60, category: 'Systems', trend: '+20%' },
      { name: 'Quantum Computing', level: 45, category: 'Research', trend: '+25%' }
    ];
    
    this.categories = {
      'Frontend': '#61DAFB',
      'Backend': '#339933',
      'AI/ML': '#FF6F00',
      'DevOps': '#326CE5',
      'Cloud': '#FF9900',
      'API': '#E10098',
      'Emerging': '#FF4081',
      'Systems': '#DEA584',
      'Research': '#9C27B0'
    };
  }

  generateSkillBar(skill, index) {
    const y = 80 + (index * 50);
    const barWidth = (skill.level / 100) * 500;
    const color = this.categories[skill.category];
    const animationDelay = index * 0.2;
    
    return `
      <g transform="translate(20, ${y})">
        <!-- Skill Name -->
        <text x="0" y="-5" font-family="monospace" font-size="14" fill="#E0E0E0" font-weight="bold">
          ${skill.name}
        </text>
        
        <!-- Category Badge -->
        <rect x="200" y="-18" width="60" height="16" rx="8" fill="${color}" opacity="0.8"/>
        <text x="230" y="-8" font-family="monospace" font-size="10" fill="white" text-anchor="middle">
          ${skill.category}
        </text>
        
        <!-- Trend Indicator -->
        <text x="270" y="-5" font-family="monospace" font-size="12" fill="#4CAF50" font-weight="bold">
          ${skill.trend}
        </text>
        
        <!-- Background Bar -->
        <rect x="0" y="5" width="500" height="20" rx="10" fill="#1E1E1E" stroke="#333" stroke-width="1"/>
        
        <!-- Progress Bar -->
        <rect x="0" y="5" width="0" height="20" rx="10" fill="${color}" opacity="0.8">
          <animate
            attributeName="width"
            from="0"
            to="${barWidth}"
            dur="2s"
            begin="${animationDelay}s"
            fill="freeze"/>
          <animate
            attributeName="opacity"
            values="0.8; 1; 0.8"
            dur="3s"
            begin="${animationDelay + 2}s"
            repeatCount="indefinite"/>
        </rect>
        
        <!-- Skill Level Text -->
        <text x="510" y="20" font-family="monospace" font-size="14" fill="#E0E0E0" text-anchor="start">
          ${skill.level}%
        </text>
        
        <!-- Progress Particles -->
        <g opacity="0">
          <animate
            attributeName="opacity"
            values="0; 1; 0"
            dur="1s"
            begin="${animationDelay + 1}s"
            repeatCount="3"/>
          ${this.generateProgressParticles(barWidth, color)}
        </g>
        
        <!-- Hover Effect -->
        <rect x="0" y="-20" width="580" height="45" fill="transparent" class="skill-hover">
          <animate
            attributeName="fill"
            values="transparent; rgba(255,255,255,0.05); transparent"
            dur="0.3s"
            begin="mouseover"
            fill="freeze"/>
          <animate
            attributeName="fill"
            values="rgba(255,255,255,0.05); transparent"
            dur="0.3s"
            begin="mouseout"
            fill="freeze"/>
        </rect>
      </g>`;
  }

  generateProgressParticles(barWidth, color) {
    let particles = '';
    const particleCount = 5;
    
    for (let i = 0; i < particleCount; i++) {
      const x = Math.random() * barWidth;
      const y = 5 + Math.random() * 20;
      const size = Math.random() * 3 + 1;
      
      particles += `
        <circle cx="${x}" cy="${y}" r="${size}" fill="${color}" opacity="0.6">
          <animate
            attributeName="r"
            values="${size}; ${size * 2}; 0"
            dur="1s"
            repeatCount="indefinite"/>
          <animate
            attributeName="opacity"
            values="0.6; 0"
            dur="1s"
            repeatCount="indefinite"/>
        </circle>`;
    }
    
    return particles;
  }

  generateRadarChart() {
    const centerX = 650;
    const centerY = 200;
    const radius = 120;
    const categories = ['Frontend', 'Backend', 'DevOps', 'AI/ML', 'Cloud'];
    const values = [92, 85, 82, 80, 78]; // Average skill levels per category
    
    let radar = `
      <g transform="translate(${centerX}, ${centerY})">
        <!-- Background Circles -->
        <circle r="30" fill="none" stroke="#333" stroke-width="1" opacity="0.5"/>
        <circle r="60" fill="none" stroke="#333" stroke-width="1" opacity="0.5"/>
        <circle r="90" fill="none" stroke="#333" stroke-width="1" opacity="0.5"/>
        <circle r="120" fill="none" stroke="#333" stroke-width="1" opacity="0.5"/>
        
        <!-- Axis Lines -->`;
    
    categories.forEach((category, index) => {
      const angle = (index * 72 - 90) * Math.PI / 180;
      const x = Math.cos(angle) * radius;
      const y = Math.sin(angle) * radius;
      
      radar += `
        <line x1="0" y1="0" x2="${x}" y2="${y}" stroke="#333" stroke-width="1" opacity="0.5"/>
        <text x="${x * 1.2}" y="${y * 1.2}" font-family="monospace" font-size="12" 
              fill="#E0E0E0" text-anchor="middle" dominant-baseline="middle">
          ${category}
        </text>`;
    });
    
    // Data polygon
    let polygonPoints = '';
    values.forEach((value, index) => {
      const angle = (index * 72 - 90) * Math.PI / 180;
      const distance = (value / 100) * radius;
      const x = Math.cos(angle) * distance;
      const y = Math.sin(angle) * distance;
      polygonPoints += `${x},${y} `;
    });
    
    radar += `
        <!-- Data Area -->
        <polygon points="${polygonPoints}" fill="#00ff41" fill-opacity="0.2" 
                 stroke="#00ff41" stroke-width="2">
          <animate
            attributeName="fill-opacity"
            values="0; 0.2; 0.3; 0.2"
            dur="3s"
            repeatCount="indefinite"/>
        </polygon>
        
        <!-- Data Points -->`;
    
    values.forEach((value, index) => {
      const angle = (index * 72 - 90) * Math.PI / 180;
      const distance = (value / 100) * radius;
      const x = Math.cos(angle) * distance;
      const y = Math.sin(angle) * distance;
      
      radar += `
        <circle cx="${x}" cy="${y}" r="4" fill="#00ff41">
          <animate
            attributeName="r"
            values="4; 6; 4"
            dur="2s"
            begin="${index * 0.3}s"
            repeatCount="indefinite"/>
        </circle>`;
    });
    
    radar += `</g>`;
    return radar;
  }

  generateLegend() {
    let legend = '';
    const categories = Object.keys(this.categories);
    
    categories.forEach((category, index) => {
      const x = 20;
      const y = 520 + (index * 25);
      const color = this.categories[category];
      
      legend += `
        <g transform="translate(${x}, ${y})">
          <rect x="0" y="0" width="15" height="15" rx="3" fill="${color}"/>
          <text x="25" y="12" font-family="monospace" font-size="12" fill="#E0E0E0">
            ${category}
          </text>
        </g>`;
    });
    
    return legend;
  }

  generateSkillsViz() {
    const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg width="${this.width}" height="${this.height}" viewBox="0 0 ${this.width} ${this.height}" 
     xmlns="http://www.w3.org/2000/svg">
  
  <defs>
    <linearGradient id="bgGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0F0F23"/>
      <stop offset="100%" stop-color="#1A1A2E"/>
    </linearGradient>
    
    <filter id="skillGlow" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur stdDeviation="2" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#bgGradient)"/>
  
  <!-- Title -->
  <text x="400" y="30" font-family="monospace" font-size="24" fill="#00ff41" 
        text-anchor="middle" font-weight="bold">
    ⚡ Skills & Expertise Matrix ⚡
  </text>
  
  <text x="400" y="55" font-family="monospace" font-size="14" fill="#E0E0E0" 
        text-anchor="middle" opacity="0.8">
    Real-time proficiency tracking with growth indicators
  </text>
  
  <!-- Skills Bars -->
  <g filter="url(#skillGlow)">
    ${this.skills.map((skill, index) => this.generateSkillBar(skill, index)).join('')}
  </g>
  
  <!-- Radar Chart -->
  ${this.generateRadarChart()}
  
  <!-- Legend -->
  <text x="20" y="510" font-family="monospace" font-size="16" fill="#00ff41" font-weight="bold">
    Categories:
  </text>
  ${this.generateLegend()}
  
  <!-- Performance Metrics -->
  <g transform="translate(550, 350)">
    <rect x="0" y="0" width="230" height="120" rx="8" fill="#1E1E1E" stroke="#333" stroke-width="1"/>
    <text x="115" y="20" font-family="monospace" font-size="14" fill="#00ff41" 
          text-anchor="middle" font-weight="bold">
      📊 Growth Metrics
    </text>
    <text x="10" y="40" font-family="monospace" font-size="12" fill="#E0E0E0">
      • Average Growth: +9.8%/quarter
    </text>
    <text x="10" y="55" font-family="monospace" font-size="12" fill="#E0E0E0">
      • Fastest Growing: Quantum (+25%)
    </text>
    <text x="10" y="70" font-family="monospace" font-size="12" fill="#E0E0E0">
      • Total Skills: ${this.skills.length} technologies
    </text>
    <text x="10" y="85" font-family="monospace" font-size="12" fill="#E0E0E0">
      • Expertise Level: Senior+
    </text>
    <text x="10" y="100" font-family="monospace" font-size="12" fill="#4CAF50">
      • Status: Actively Learning ✨
    </text>
  </g>
  
  <!-- Animated Border -->
  <rect x="2" y="2" width="${this.width - 4}" height="${this.height - 4}" 
        fill="none" stroke="#00ff41" stroke-width="1" rx="8" opacity="0.5">
    <animate
      attributeName="opacity"
      values="0.5; 1; 0.5"
      dur="4s"
      repeatCount="indefinite"/>
  </rect>
  
</svg>`;

    return svg;
  }
}

// Generate the skills visualization
const skillsViz = new SkillsVisualization();
const svg = skillsViz.generateSkillsViz();

// Ensure dist directory exists
if (!fs.existsSync('dist')) {
  fs.mkdirSync('dist', { recursive: true });
}

fs.writeFileSync('dist/skills-viz.svg', svg);
console.log('✅ Interactive skills visualization generated');