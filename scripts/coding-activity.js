// scripts/coding-activity.js - Interactive Coding Activity & Productivity Tracker
const fs = require('fs');

class CodingActivityTracker {
  constructor() {
    this.width = 800;
    this.height = 400;
    
    // Simulate coding activity data
    this.todaysActivity = this.generateTodaysActivity();
    this.weeklyStats = this.generateWeeklyStats();
    this.languages = this.generateLanguageBreakdown();
    this.productivity = this.calculateProductivityMetrics();
  }

  generateTodaysActivity() {
    // Generate 24 hours of coding activity (0-23)
    const hours = Array.from({ length: 24 }, (_, hour) => {
      const isWorkingHour = hour >= 9 && hour <= 18;
      const isEveningCode = hour >= 19 && hour <= 23;
      
      let intensity = 0;
      if (isWorkingHour) {
        intensity = Math.random() * 0.8 + 0.2; // 20-100%
      } else if (isEveningCode) {
        intensity = Math.random() * 0.6; // 0-60%
      } else {
        intensity = Math.random() * 0.1; // 0-10%
      }
      
      return {
        hour,
        intensity: Math.round(intensity * 100),
        commits: Math.floor(intensity * 5),
        linesChanged: Math.floor(intensity * 150)
      };
    });
    
    return hours;
  }

  generateWeeklyStats() {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days.map(day => ({
      day,
      commits: Math.floor(Math.random() * 15) + 5,
      hours: Math.floor(Math.random() * 8) + 2,
      productivity: Math.floor(Math.random() * 30) + 70
    }));
  }

  generateLanguageBreakdown() {
    return [
      { lang: 'JavaScript', percentage: 35, color: '#f7df1e' },
      { lang: 'TypeScript', percentage: 25, color: '#3178c6' },
      { lang: 'Python', percentage: 20, color: '#3776ab' },
      { lang: 'Rust', percentage: 12, color: '#ce422b' },
      { lang: 'Go', percentage: 8, color: '#00add8' }
    ];
  }

  calculateProductivityMetrics() {
    const totalCommits = this.weeklyStats.reduce((sum, day) => sum + day.commits, 0);
    const avgHours = this.weeklyStats.reduce((sum, day) => sum + day.hours, 0) / 7;
    const avgProductivity = this.weeklyStats.reduce((sum, day) => sum + day.productivity, 0) / 7;
    
    return {
      totalCommits,
      avgHours: avgHours.toFixed(1),
      avgProductivity: avgProductivity.toFixed(1),
      streak: Math.floor(Math.random() * 30) + 15,
      focusTime: '4h 23m'
    };
  }

  generateActivityHeatmap() {
    const cellSize = 25;
    const startX = 100;
    const startY = 80;
    
    return this.todaysActivity.map((activity, index) => {
      const x = startX + (index % 12) * cellSize;
      const y = startY + Math.floor(index / 12) * cellSize;
      const opacity = activity.intensity / 100;
      const color = activity.intensity > 70 ? '#ff6b6b' : 
                   activity.intensity > 40 ? '#4ecdc4' : 
                   activity.intensity > 20 ? '#45b7d1' : '#95a5a6';
      
      return `
        <g transform="translate(${x}, ${y})">
          <rect width="20" height="20" rx="3" fill="${color}" opacity="${Math.max(0.1, opacity)}">
            <animate attributeName="opacity" 
                     values="${Math.max(0.1, opacity)}; ${Math.min(1, opacity + 0.3)}; ${Math.max(0.1, opacity)}" 
                     dur="3s" begin="${index * 0.1}s" repeatCount="indefinite"/>
          </rect>
          <text x="10" y="14" font-family="monospace" font-size="8" fill="white" text-anchor="middle">
            ${activity.hour.toString().padStart(2, '0')}
          </text>
        </g>`;
    }).join('');
  }

  generateWeeklyChart() {
    const barWidth = 40;
    const maxHeight = 80;
    const startX = 100;
    const startY = 250;
    
    return this.weeklyStats.map((day, index) => {
      const barHeight = (day.commits / 20) * maxHeight;
      const x = startX + index * (barWidth + 10);
      const y = startY - barHeight;
      
      return `
        <g transform="translate(${x}, ${startY})">
          <!-- Bar -->
          <rect x="0" y="0" width="${barWidth}" height="0" fill="#00ff41" opacity="0.8">
            <animate attributeName="height" from="0" to="${barHeight}" 
                     dur="2s" begin="${index * 0.2}s" fill="freeze"/>
            <animate attributeName="y" from="0" to="${-barHeight}" 
                     dur="2s" begin="${index * 0.2}s" fill="freeze"/>
          </rect>
          
          <!-- Day label -->
          <text x="${barWidth/2}" y="20" font-family="monospace" font-size="12" 
                fill="#e0e0e0" text-anchor="middle">
            ${day.day}
          </text>
          
          <!-- Commit count -->
          <text x="${barWidth/2}" y="${-barHeight - 5}" font-family="monospace" font-size="10" 
                fill="#00ff41" text-anchor="middle" font-weight="bold">
            ${day.commits}
          </text>
        </g>`;
    }).join('');
  }

  generateLanguageChart() {
    const centerX = 600;
    const centerY = 180;
    const radius = 60;
    let currentAngle = 0;
    
    return this.languages.map((lang, index) => {
      const angle = (lang.percentage / 100) * 360;
      const startAngle = currentAngle;
      const endAngle = currentAngle + angle;
      
      const x1 = centerX + radius * Math.cos((startAngle * Math.PI) / 180);
      const y1 = centerY + radius * Math.sin((startAngle * Math.PI) / 180);
      const x2 = centerX + radius * Math.cos((endAngle * Math.PI) / 180);
      const y2 = centerY + radius * Math.sin((endAngle * Math.PI) / 180);
      
      const largeArcFlag = angle > 180 ? 1 : 0;
      
      const pathData = `M ${centerX} ${centerY} L ${x1} ${y1} A ${radius} ${radius} 0 ${largeArcFlag} 1 ${x2} ${y2} Z`;
      
      currentAngle += angle;
      
      return `
        <path d="${pathData}" fill="${lang.color}" opacity="0.8">
          <animate attributeName="opacity" values="0.8; 1; 0.8" 
                   dur="3s" begin="${index * 0.3}s" repeatCount="indefinite"/>
        </path>`;
    }).join('');
  }

  generateActivityTracker() {
    return `<?xml version="1.0" encoding="UTF-8"?>
<svg width="${this.width}" height="${this.height}" viewBox="0 0 ${this.width} ${this.height}" 
     xmlns="http://www.w3.org/2000/svg">
  
  <defs>
    <linearGradient id="activityBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0f0f23"/>
      <stop offset="100%" stop-color="#1a1a2e"/>
    </linearGradient>
    
    <filter id="activityGlow">
      <feGaussianBlur stdDeviation="2" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#activityBg)"/>
  
  <!-- Title -->
  <text x="400" y="30" font-family="monospace" font-size="20" fill="#00ff41" 
        text-anchor="middle" font-weight="bold">
    📊 Coding Activity & Productivity Dashboard
  </text>
  
  <!-- Today's Activity Heatmap -->
  <text x="20" y="65" font-family="monospace" font-size="14" fill="#e0e0e0" font-weight="bold">
    Today's Activity (24h)
  </text>
  
  <g filter="url(#activityGlow)">
    ${this.generateActivityHeatmap()}
  </g>
  
  <!-- Weekly Commits Chart -->
  <text x="20" y="200" font-family="monospace" font-size="14" fill="#e0e0e0" font-weight="bold">
    Weekly Commits
  </text>
  
  <g>
    ${this.generateWeeklyChart()}
  </g>
  
  <!-- Language Breakdown -->
  <text x="500" y="65" font-family="monospace" font-size="14" fill="#e0e0e0" font-weight="bold">
    Language Breakdown
  </text>
  
  <g filter="url(#activityGlow)">
    ${this.generateLanguageChart()}
  </g>
  
  <!-- Language Legend -->
  <g transform="translate(650, 100)">
    ${this.languages.map((lang, index) => `
      <g transform="translate(0, ${index * 20})">
        <rect x="0" y="0" width="15" height="15" rx="3" fill="${lang.color}"/>
        <text x="25" y="12" font-family="monospace" font-size="12" fill="#e0e0e0">
          ${lang.lang} (${lang.percentage}%)
        </text>
      </g>
    `).join('')}
  </g>
  
  <!-- Productivity Metrics -->
  <g transform="translate(450, 250)">
    <rect x="0" y="0" width="330" height="120" rx="8" fill="#111" stroke="#333" stroke-width="1"/>
    
    <text x="165" y="20" font-family="monospace" font-size="14" fill="#00ff41" 
          text-anchor="middle" font-weight="bold">
      📈 Productivity Metrics
    </text>
    
    <text x="15" y="40" font-family="monospace" font-size="12" fill="#e0e0e0">
      Total Commits: ${this.productivity.totalCommits}
    </text>
    <text x="15" y="55" font-family="monospace" font-size="12" fill="#e0e0e0">
      Avg Hours/Day: ${this.productivity.avgHours}h
    </text>
    <text x="15" y="70" font-family="monospace" font-size="12" fill="#e0e0e0">
      Productivity: ${this.productivity.avgProductivity}%
    </text>
    <text x="15" y="85" font-family="monospace" font-size="12" fill="#e0e0e0">
      Current Streak: ${this.productivity.streak} days
    </text>
    <text x="15" y="100" font-family="monospace" font-size="12" fill="#4CAF50">
      Deep Focus: ${this.productivity.focusTime}
    </text>
    
    <!-- Live indicator -->
    <circle cx="300" cy="100" r="5" fill="#4CAF50">
      <animate attributeName="opacity" values="1; 0.3; 1" dur="2s" repeatCount="indefinite"/>
    </circle>
    <text x="285" y="105" font-family="monospace" font-size="10" fill="#4CAF50" text-anchor="end">
      LIVE
    </text>
  </g>
  
  <!-- Animated border -->
  <rect x="2" y="2" width="${this.width - 4}" height="${this.height - 4}" 
        fill="none" stroke="#00ff41" stroke-width="1" rx="8" opacity="0.3">
    <animate attributeName="opacity" values="0.3; 0.7; 0.3" dur="4s" repeatCount="indefinite"/>
  </rect>
  
</svg>`;
  }
}

// Generate the coding activity tracker
const tracker = new CodingActivityTracker();
const svg = tracker.generateActivityTracker();

// Ensure dist directory exists
if (!fs.existsSync('dist')) {
  fs.mkdirSync('dist', { recursive: true });
}

fs.writeFileSync('dist/coding-activity.svg', svg);
console.log('✅ Interactive coding activity tracker generated');