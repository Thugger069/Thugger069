// scripts/system-monitor.js - Real-time System Status Monitor Simulation
const fs = require('fs');

class SystemMonitor {
  constructor() {
    this.width = 1000;
    this.height = 300;
    
    this.systemMetrics = {
      cpu: {
        cores: 8,
        usage: Math.floor(Math.random() * 40) + 20, // 20-60%
        temperature: Math.floor(Math.random() * 20) + 45, // 45-65°C
        frequency: (Math.random() * 1.5 + 2.5).toFixed(2) // 2.5-4.0 GHz
      },
      memory: {
        total: 32,
        used: Math.floor(Math.random() * 16) + 8, // 8-24 GB
        cache: Math.floor(Math.random() * 4) + 2, // 2-6 GB
        swap: Math.floor(Math.random() * 2) // 0-2 GB
      },
      network: {
        upload: (Math.random() * 50 + 10).toFixed(1), // 10-60 Mbps
        download: (Math.random() * 200 + 50).toFixed(1), // 50-250 Mbps
        latency: Math.floor(Math.random() * 30) + 5, // 5-35ms
        packets: Math.floor(Math.random() * 1000) + 500 // 500-1500 pps
      },
      disk: {
        read: Math.floor(Math.random() * 500) + 100, // 100-600 MB/s
        write: Math.floor(Math.random() * 300) + 50, // 50-350 MB/s
        usage: Math.floor(Math.random() * 30) + 45, // 45-75%
        temperature: Math.floor(Math.random() * 15) + 35 // 35-50°C
      }
    };
  }

  generateCPUCores() {
    const coreSize = 25;
    const spacing = 35;
    const startX = 50;
    const startY = 100;
    
    return Array.from({ length: this.systemMetrics.cpu.cores }, (_, i) => {
      const x = startX + (i % 4) * spacing;
      const y = startY + Math.floor(i / 4) * spacing;
      const usage = Math.floor(Math.random() * 60) + 20;
      const color = usage > 70 ? '#ff6b6b' : usage > 50 ? '#feca57' : '#48dbfb';
      
      return `
        <g transform="translate(${x}, ${y})">
          <rect width="${coreSize}" height="${coreSize}" rx="4" fill="${color}" opacity="0.8">
            <animate attributeName="opacity" values="0.8; 1; 0.8" dur="2s" repeatCount="indefinite"/>
          </rect>
          <text x="${coreSize/2}" y="${coreSize/2 + 4}" font-family="monospace" font-size="10" 
                fill="white" text-anchor="middle" font-weight="bold">
            ${i}
          </text>
          <text x="${coreSize/2}" y="${coreSize + 15}" font-family="monospace" font-size="8" 
                fill="#e0e0e0" text-anchor="middle">
            ${usage}%
          </text>
        </g>`;
    }).join('');
  }

  generateMemoryBars() {
    const barWidth = 200;
    const barHeight = 20;
    const startX = 300;
    const startY = 100;
    
    const memoryTypes = [
      { name: 'Used', value: this.systemMetrics.memory.used, total: this.systemMetrics.memory.total, color: '#ff6b6b' },
      { name: 'Cache', value: this.systemMetrics.memory.cache, total: this.systemMetrics.memory.total, color: '#feca57' },
      { name: 'Swap', value: this.systemMetrics.memory.swap, total: 4, color: '#ff9ff3' }
    ];
    
    return memoryTypes.map((mem, index) => {
      const y = startY + index * 30;
      const fillWidth = (mem.value / mem.total) * barWidth;
      const percentage = ((mem.value / mem.total) * 100).toFixed(1);
      
      return `
        <g transform="translate(${startX}, ${y})">
          <!-- Background bar -->
          <rect width="${barWidth}" height="${barHeight}" rx="10" fill="#2c2c54" stroke="#40407a" stroke-width="1"/>
          
          <!-- Fill bar -->
          <rect width="0" height="${barHeight}" rx="10" fill="${mem.color}" opacity="0.8">
            <animate attributeName="width" from="0" to="${fillWidth}" dur="2s" fill="freeze"/>
            <animate attributeName="opacity" values="0.8; 1; 0.8" dur="3s" repeatCount="indefinite"/>
          </rect>
          
          <!-- Label -->
          <text x="-10" y="15" font-family="monospace" font-size="12" fill="#e0e0e0" text-anchor="end">
            ${mem.name}:
          </text>
          
          <!-- Value -->
          <text x="${barWidth + 10}" y="15" font-family="monospace" font-size="12" fill="${mem.color}" font-weight="bold">
            ${mem.value}${mem.name === 'Swap' ? 'GB' : `/${mem.total}GB`} (${percentage}%)
          </text>
        </g>`;
    }).join('');
  }

  generateNetworkIndicators() {
    const startX = 600;
    const startY = 100;
    
    return `
      <g transform="translate(${startX}, ${startY})">
        <!-- Network status panel -->
        <rect x="0" y="0" width="180" height="120" rx="8" fill="#0f3460" stroke="#16537e" stroke-width="2"/>
        
        <text x="90" y="20" font-family="monospace" font-size="14" fill="#0abde3" 
              text-anchor="middle" font-weight="bold">
          Network Status
        </text>
        
        <!-- Upload indicator -->
        <g transform="translate(10, 35)">
          <polygon points="0,10 10,0 20,10 15,10 15,20 5,20 5,10" fill="#00d2d3"/>
          <text x="30" y="12" font-family="monospace" font-size="11" fill="#e0e0e0">
            Up: ${this.systemMetrics.network.upload} Mbps
          </text>
        </g>
        
        <!-- Download indicator -->
        <g transform="translate(10, 55)">
          <polygon points="0,0 10,10 20,0 15,0 15,-10 5,-10 5,0" fill="#ff6348" transform="translate(0,10)"/>
          <text x="30" y="12" font-family="monospace" font-size="11" fill="#e0e0e0">
            Down: ${this.systemMetrics.network.download} Mbps
          </text>
        </g>
        
        <!-- Latency -->
        <text x="10" y="85" font-family="monospace" font-size="11" fill="#feca57">
          Latency: ${this.systemMetrics.network.latency}ms
        </text>
        
        <!-- Packets -->
        <text x="10" y="100" font-family="monospace" font-size="11" fill="#48dbfb">
          Packets: ${this.systemMetrics.network.packets}/s
        </text>
        
        <!-- Signal strength animation -->
        <g transform="translate(150, 80)">
          ${Array.from({ length: 4 }, (_, i) => `
            <rect x="${i * 6}" y="${15 - i * 3}" width="4" height="${i * 3 + 5}" 
                  fill="#00d2d3" opacity="0.8">
              <animate attributeName="opacity" 
                       values="0.8; 1; 0.8" 
                       dur="${1 + i * 0.2}s" 
                       repeatCount="indefinite"/>
            </rect>
          `).join('')}
        </g>
      </g>`;
  }

  generateSystemInfo() {
    const startX = 50;
    const startY = 220;
    
    const info = [
      { label: 'CPU Freq', value: `${this.systemMetrics.cpu.frequency} GHz`, color: '#48dbfb' },
      { label: 'CPU Temp', value: `${this.systemMetrics.cpu.temperature}°C`, color: this.systemMetrics.cpu.temperature > 60 ? '#ff6b6b' : '#48dbfb' },
      { label: 'Disk R/W', value: `${this.systemMetrics.disk.read}/${this.systemMetrics.disk.write} MB/s`, color: '#feca57' },
      { label: 'Disk Usage', value: `${this.systemMetrics.disk.usage}%`, color: this.systemMetrics.disk.usage > 70 ? '#ff6b6b' : '#48dbfb' },
      { label: 'Disk Temp', value: `${this.systemMetrics.disk.temperature}°C`, color: '#48dbfb' }
    ];
    
    return info.map((item, index) => `
      <g transform="translate(${startX + index * 180}, ${startY})">
        <rect x="0" y="0" width="170" height="40" rx="6" fill="#2c2c54" stroke="#40407a" stroke-width="1"/>
        
        <text x="10" y="17" font-family="monospace" font-size="11" fill="#e0e0e0">
          ${item.label}:
        </text>
        
        <text x="10" y="32" font-family="monospace" font-size="13" fill="${item.color}" font-weight="bold">
          ${item.value}
        </text>
        
        <!-- Status indicator -->
        <circle cx="150" cy="20" r="4" fill="${item.color}" opacity="0.8">
          <animate attributeName="opacity" values="0.8; 1; 0.8" dur="2s" repeatCount="indefinite"/>
        </circle>
      </g>
    `).join('');
  }

  generateSystemMonitor() {
    const currentTime = new Date().toLocaleTimeString();
    
    return `<?xml version="1.0" encoding="UTF-8"?>
<svg width="${this.width}" height="${this.height}" viewBox="0 0 ${this.width} ${this.height}" 
     xmlns="http://www.w3.org/2000/svg">
  
  <defs>
    <linearGradient id="monitorBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0f0f23"/>
      <stop offset="100%" stop-color="#1a1a2e"/>
    </linearGradient>
    
    <filter id="monitorGlow">
      <feGaussianBlur stdDeviation="2" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#monitorBg)"/>
  
  <!-- Title and header -->
  <text x="500" y="30" font-family="monospace" font-size="20" fill="#00ff41" 
        text-anchor="middle" font-weight="bold">
    🖥️ Real-time System Performance Monitor
  </text>
  
  <text x="20" y="55" font-family="monospace" font-size="12" fill="#e0e0e0">
    System Status: Online • Uptime: 72h 43m • Last Update: ${currentTime}
  </text>
  
  <!-- Live indicator -->
  <circle cx="970" cy="50" r="6" fill="#00ff41">
    <animate attributeName="opacity" values="1; 0.3; 1" dur="2s" repeatCount="indefinite"/>
  </circle>
  <text x="950" y="55" font-family="monospace" font-size="12" fill="#00ff41" text-anchor="end">
    LIVE
  </text>
  
  <!-- CPU Cores section -->
  <text x="20" y="85" font-family="monospace" font-size="14" fill="#e0e0e0" font-weight="bold">
    CPU Cores (${this.systemMetrics.cpu.usage}% avg)
  </text>
  
  <g filter="url(#monitorGlow)">
    ${this.generateCPUCores()}
  </g>
  
  <!-- Memory section -->
  <text x="280" y="85" font-family="monospace" font-size="14" fill="#e0e0e0" font-weight="bold">
    Memory Usage
  </text>
  
  ${this.generateMemoryBars()}
  
  <!-- Network section -->
  ${this.generateNetworkIndicators()}
  
  <!-- System info -->
  ${this.generateSystemInfo()}
  
  <!-- Performance graph placeholder -->
  <g transform="translate(800, 100)">
    <rect x="0" y="0" width="180" height="100" rx="6" fill="#2c2c54" stroke="#40407a" stroke-width="1"/>
    <text x="90" y="20" font-family="monospace" font-size="12" fill="#e0e0e0" text-anchor="middle">
      Performance Graph
    </text>
    
    <!-- Simple performance line -->
    <polyline points="10,80 30,60 50,70 70,45 90,55 110,40 130,50 150,35 170,45" 
              fill="none" stroke="#00ff41" stroke-width="2" opacity="0.8">
      <animate attributeName="stroke-opacity" values="0.8; 1; 0.8" dur="3s" repeatCount="indefinite"/>
    </polyline>
  </g>
  
  <!-- Border animation -->
  <rect x="2" y="2" width="${this.width - 4}" height="${this.height - 4}" 
        fill="none" stroke="#00ff41" stroke-width="1" rx="8" opacity="0.4">
    <animate attributeName="opacity" values="0.4; 0.8; 0.4" dur="4s" repeatCount="indefinite"/>
  </rect>
  
</svg>`;
  }
}

// Generate the system monitor
const monitor = new SystemMonitor();
const svg = monitor.generateSystemMonitor();

// Ensure dist directory exists
if (!fs.existsSync('dist')) {
  fs.mkdirSync('dist', { recursive: true });
}

fs.writeFileSync('dist/system-monitor.svg', svg);
console.log('✅ Real-time system performance monitor generated');