// scripts/devops-dashboard.js - DevOps Performance Monitoring Dashboard
const fs = require('fs');

class DevOpsDashboard {
  constructor() {
    this.width = 1000;
    this.height = 700;
    
    // Simulate real DevOps metrics
    this.metrics = {
      deployment: {
        frequency: '47/day',
        successRate: 99.2,
        meanTime: '8.3min',
        rollbacks: 2
      },
      infrastructure: {
        uptime: 99.98,
        responseTime: '42ms',
        throughput: '15.2k req/s',
        errorRate: 0.02
      },
      security: {
        vulnerabilities: 3,
        compliance: 98.5,
        lastScan: '2h ago',
        patchLevel: 'Current'
      },
      performance: {
        cpuUsage: 23.5,
        memoryUsage: 67.8,
        diskUsage: 45.2,
        networkLatency: 8.3
      }
    };
    
    this.services = [
      { name: 'API Gateway', status: 'healthy', instances: 5, response: '35ms' },
      { name: 'Auth Service', status: 'healthy', instances: 3, response: '12ms' },
      { name: 'Data Pipeline', status: 'warning', instances: 8, response: '156ms' },
      { name: 'ML Inference', status: 'healthy', instances: 12, response: '89ms' },
      { name: 'Cache Layer', status: 'healthy', instances: 6, response: '2ms' },
      { name: 'Message Queue', status: 'healthy', instances: 4, response: '5ms' }
    ];
  }

  generateMetricsPanel(title, metrics, x, y, width, height) {
    return `
      <g transform="translate(${x}, ${y})">
        <!-- Panel Background -->
        <rect x="0" y="0" width="${width}" height="${height}" rx="8" 
              fill="#1a1a1a" stroke="#333" stroke-width="1"/>
        
        <!-- Panel Title -->
        <text x="${width/2}" y="25" font-family="monospace" font-size="14" 
              fill="#00ff41" text-anchor="middle" font-weight="bold">
          ${title}
        </text>
        
        <!-- Metrics Content -->
        ${Object.entries(metrics).map(([ key, value ], index) => `
          <g transform="translate(15, ${45 + index * 25})">
            <text x="0" y="0" font-family="monospace" font-size="11" fill="#ccc">
              ${key.replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase())}:
            </text>
            <text x="${width - 30}" y="0" font-family="monospace" font-size="11" 
                  fill="${this.getMetricColor(key, value)}" text-anchor="end" font-weight="bold">
              ${value}${this.getMetricUnit(key)}
            </text>
          </g>
        `).join('')}
      </g>`;
  }

  generateServiceStatus() {
    return `
      <g transform="translate(20, 350)">
        <text x="0" y="20" font-family="monospace" font-size="16" fill="#00ff41" font-weight="bold">
          🔧 Service Health Monitor
        </text>
        
        ${this.services.map((service, index) => `
          <g transform="translate(0, ${50 + index * 40})">
            <!-- Service Card -->
            <rect x="0" y="0" width="460" height="30" rx="4" 
                  fill="#1e1e1e" stroke="${this.getStatusColor(service.status)}" stroke-width="1"/>
            
            <!-- Status Indicator -->
            <circle cx="15" cy="15" r="5" fill="${this.getStatusColor(service.status)}">
              <animate attributeName="opacity" values="1; 0.5; 1" dur="2s" repeatCount="indefinite"/>
            </circle>
            
            <!-- Service Name -->
            <text x="30" y="19" font-family="monospace" font-size="12" fill="#e0e0e0" font-weight="bold">
              ${service.name}
            </text>
            
            <!-- Instances -->
            <text x="180" y="19" font-family="monospace" font-size="11" fill="#888">
              ${service.instances} instances
            </text>
            
            <!-- Response Time -->
            <text x="300" y="19" font-family="monospace" font-size="11" fill="#4CAF50">
              ${service.response}
            </text>
            
            <!-- Status Badge -->
            <rect x="380" y="5" width="70" height="20" rx="10" 
                  fill="${this.getStatusColor(service.status)}" opacity="0.8"/>
            <text x="415" y="17" font-family="monospace" font-size="10" 
                  fill="white" text-anchor="middle" font-weight="bold">
              ${service.status.toUpperCase()}
            </text>
          </g>
        `).join('')}
      </g>`;
  }

  generatePerformanceCharts() {
    // Generate CPU usage chart
    const cpuPoints = Array.from({length: 20}, (_, i) => {
      const x = i * 20;
      const y = 80 - (Math.random() * 30 + this.metrics.performance.cpuUsage - 15);
      return `${x},${Math.max(10, Math.min(80, y))}`;
    }).join(' ');

    // Generate Memory usage chart  
    const memPoints = Array.from({length: 20}, (_, i) => {
      const x = i * 20;
      const y = 80 - (Math.random() * 20 + this.metrics.performance.memoryUsage - 10);
      return `${x},${Math.max(10, Math.min(80, y))}`;
    }).join(' ');

    return `
      <g transform="translate(520, 350)">
        <text x="0" y="20" font-family="monospace" font-size="16" fill="#00ff41" font-weight="bold">
          📊 Performance Metrics
        </text>
        
        <!-- CPU Usage Chart -->
        <g transform="translate(0, 50)">
          <rect x="0" y="0" width="400" height="100" rx="4" fill="#111" stroke="#333" stroke-width="1"/>
          <text x="10" y="15" font-family="monospace" font-size="12" fill="#e0e0e0">
            CPU Usage: ${this.metrics.performance.cpuUsage}%
          </text>
          
          <!-- Chart Grid -->
          <g stroke="#333" stroke-width="0.5" opacity="0.5">
            <line x1="0" y1="25" x2="400" y2="25"/>
            <line x1="0" y1="50" x2="400" y2="50"/>
            <line x1="0" y1="75" x2="400" y2="75"/>
            <line x1="0" y1="100" x2="400" y2="100"/>
          </g>
          
          <!-- CPU Line Chart -->
          <polyline points="${cpuPoints}" fill="none" stroke="#FF6B6B" stroke-width="2" 
                    transform="translate(20, 20)">
            <animate attributeName="points" 
                     values="${cpuPoints}; ${cpuPoints.split(' ').map(p => {
                       const [x, y] = p.split(',').map(Number);
                       return `${x},${Math.max(10, Math.min(80, y + (Math.random() - 0.5) * 10))}`;
                     }).join(' ')}; ${cpuPoints}"
                     dur="5s" repeatCount="indefinite"/>
          </polyline>
        </g>
        
        <!-- Memory Usage Chart -->
        <g transform="translate(0, 170)">
          <rect x="0" y="0" width="400" height="100" rx="4" fill="#111" stroke="#333" stroke-width="1"/>
          <text x="10" y="15" font-family="monospace" font-size="12" fill="#e0e0e0">
            Memory Usage: ${this.metrics.performance.memoryUsage}%
          </text>
          
          <!-- Chart Grid -->
          <g stroke="#333" stroke-width="0.5" opacity="0.5">
            <line x1="0" y1="25" x2="400" y2="25"/>
            <line x1="0" y1="50" x2="400" y2="50"/>
            <line x1="0" y1="75" x2="400" y2="75"/>
            <line x1="0" y1="100" x2="400" y2="100"/>
          </g>
          
          <!-- Memory Area Chart -->
          <polygon points="20,80 ${memPoints.split(' ').map(p => {
            const [x, y] = p.split(',').map(Number);
            return `${x + 20},${y}`;
          }).join(' ')} 400,80" 
                   fill="#4ECDC4" fill-opacity="0.3" stroke="#4ECDC4" stroke-width="2">
            <animate attributeName="fill-opacity" values="0.3; 0.5; 0.3" dur="3s" repeatCount="indefinite"/>
          </polygon>
        </g>
      </g>`;
  }

  generateAlertSystem() {
    const alerts = [
      { type: 'info', message: 'Deployment #347 completed successfully', time: '2m ago' },
      { type: 'warning', message: 'High memory usage in Data Pipeline service', time: '5m ago' },
      { type: 'success', message: 'Security scan completed - 0 critical issues', time: '15m ago' }
    ];

    return `
      <g transform="translate(20, 600)">
        <text x="0" y="20" font-family="monospace" font-size="16" fill="#00ff41" font-weight="bold">
          🚨 System Alerts
        </text>
        
        ${alerts.map((alert, index) => `
          <g transform="translate(0, ${40 + index * 25})">
            <rect x="0" y="0" width="950" height="20" rx="4" 
                  fill="${this.getAlertBg(alert.type)}" opacity="0.8"/>
            
            <circle cx="10" cy="10" r="3" fill="${this.getAlertColor(alert.type)}">
              <animate attributeName="opacity" values="1; 0.5; 1" dur="2s" repeatCount="indefinite"/>
            </circle>
            
            <text x="25" y="14" font-family="monospace" font-size="11" fill="#e0e0e0">
              ${alert.message}
            </text>
            
            <text x="930" y="14" font-family="monospace" font-size="10" fill="#888" text-anchor="end">
              ${alert.time}
            </text>
          </g>
        `).join('')}
      </g>`;
  }

  getMetricColor(key, value) {
    if (key.includes('Rate') || key.includes('uptime') || key.includes('compliance')) {
      return value > 95 ? '#4CAF50' : value > 90 ? '#FF9800' : '#F44336';
    }
    if (key.includes('Time') || key.includes('Latency')) {
      return value < 50 ? '#4CAF50' : value < 100 ? '#FF9800' : '#F44336';
    }
    if (key.includes('Usage')) {
      return value < 50 ? '#4CAF50' : value < 80 ? '#FF9800' : '#F44336';
    }
    return '#00ff41';
  }

  getMetricUnit(key) {
    if (key.includes('Rate')) return '%';
    if (key.includes('Time')) return '';
    if (key.includes('Usage')) return '%';
    return '';
  }

  getStatusColor(status) {
    const colors = {
      healthy: '#4CAF50',
      warning: '#FF9800',
      critical: '#F44336',
      unknown: '#888'
    };
    return colors[status] || colors.unknown;
  }

  getAlertColor(type) {
    const colors = {
      info: '#2196F3',
      warning: '#FF9800',
      success: '#4CAF50',
      error: '#F44336'
    };
    return colors[type] || colors.info;
  }

  getAlertBg(type) {
    const colors = {
      info: '#1565C0',
      warning: '#E65100',
      success: '#2E7D32',
      error: '#C62828'
    };
    return colors[type] || colors.info;
  }

  generateDashboard() {
    return `<?xml version="1.0" encoding="UTF-8"?>
<svg width="${this.width}" height="${this.height}" viewBox="0 0 ${this.width} ${this.height}" 
     xmlns="http://www.w3.org/2000/svg">
  
  <defs>
    <linearGradient id="dashBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0a0a0a"/>
      <stop offset="100%" stop-color="#1a1a1a"/>
    </linearGradient>
    
    <filter id="dashGlow">
      <feGaussianBlur stdDeviation="2" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#dashBg)"/>
  
  <!-- Header -->
  <g transform="translate(20, 20)">
    <text x="0" y="25" font-family="monospace" font-size="24" fill="#00ff41" font-weight="bold">
      ⚡ DevOps Performance Dashboard
    </text>
    <text x="0" y="45" font-family="monospace" font-size="14" fill="#888">
      Real-time monitoring • Last updated: ${new Date().toLocaleTimeString()}
    </text>
    
    <!-- Live indicator -->
    <circle cx="950" cy="25" r="8" fill="#4CAF50">
      <animate attributeName="opacity" values="1; 0.3; 1" dur="2s" repeatCount="indefinite"/>
    </circle>
    <text x="935" y="30" font-family="monospace" font-size="12" fill="#4CAF50" text-anchor="end">
      LIVE
    </text>
  </g>
  
  <!-- Metrics Panels -->
  ${this.generateMetricsPanel('🚀 Deployment', this.metrics.deployment, 20, 80, 230, 150)}
  ${this.generateMetricsPanel('🏗️ Infrastructure', this.metrics.infrastructure, 270, 80, 230, 150)}
  ${this.generateMetricsPanel('🔒 Security', this.metrics.security, 520, 80, 230, 150)}
  ${this.generateMetricsPanel('⚡ Performance', this.metrics.performance, 770, 80, 210, 150)}
  
  <!-- Service Status -->
  ${this.generateServiceStatus()}
  
  <!-- Performance Charts -->
  ${this.generatePerformanceCharts()}
  
  <!-- Alert System -->
  ${this.generateAlertSystem()}
  
  <!-- Border Animation -->
  <rect x="2" y="2" width="${this.width - 4}" height="${this.height - 4}" 
        fill="none" stroke="#00ff41" stroke-width="1" rx="8" opacity="0.3">
    <animate attributeName="opacity" values="0.3; 0.7; 0.3" dur="4s" repeatCount="indefinite"/>
  </rect>
  
</svg>`;
  }
}

// Generate DevOps Dashboard
const dashboard = new DevOpsDashboard();
const svg = dashboard.generateDashboard();

// Ensure dist directory exists
if (!fs.existsSync('dist')) {
  fs.mkdirSync('dist', { recursive: true });
}

fs.writeFileSync('dist/devops-dashboard.svg', svg);
console.log('✅ DevOps Performance Dashboard generated');