const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..');
const README_FILE = path.join(REPO_ROOT, 'README.md');

const AUTHOR = "ɬɧɛ ɠıɬƈɧ";
const GITHUB_USERNAME = "Thugger069";
const CURRENT_TIME = new Date().toUTCString().replace(/GMT/, 'UTC');

// ———————–
// Enhanced Matrix Rain with Multiple Character Sets
// ———————–
function generateMatrixRain() {
  const columns = 45;
  const characterSets = {
    binary: "01",
    japanese: "アイウエオカキクケコサシスセソタチツテト",
    symbols: "⟁⦻⨀⨁⨂⨄⨆⨅⨊⨍⨎⨏⨐⨑⨒⨓⨔⨕⨖⨗⨘⨙⨚⨛⨜⨝",
    math: "∂∇∏∑√∞∫≈≠≤≥"
  };

  let rain = '';
  const colors = ["#00F3FF", "#FF00FF", "#00FF41", "#B967FF", "#FFF000"];

  for (let i = 0; i < columns; i++) {
    const x = (i * 2.2).toFixed(2);
    const delay = (Math.random() * 4).toFixed(2);
    const duration = (Math.random() * 3 + 2).toFixed(2);
    const charSet = Object.values(characterSets)[Math.floor(Math.random() * Object.keys(characterSets).length)];
    const color = colors[Math.floor(Math.random() * colors.length)];
    const charCount = Math.floor(Math.random() * 4) + 1;

    let chars = '';
    for (let j = 0; j < charCount; j++) {
      const char = charSet[Math.floor(Math.random() * charSet.length)];
      const charDelay = (j * 0.3).toFixed(2);
      const opacity = (0.3 + (j * 0.2)).toFixed(2);
      chars += `<tspan x="${x}%" dy="1.2em" opacity="0">
        ${char}
        <animate attributeName="opacity" values="0;${opacity};0" dur="${duration}s" begin="${charDelay}s" repeatCount="indefinite"/>
      </tspan>`;
    }

    rain += `<text x="${x}%" y="-10%" fill="${color}" font-family="monospace" font-size="0.65rem" font-weight="bold">
      ${chars}
      <animate attributeName="y" values="-10%;110%" dur="${duration}s" repeatCount="indefinite" begin="${delay}s"/>
    </text>`;
  }

  return `<svg width="100%" height="100%" style="position:absolute;top:0;left:0;z-index:0;opacity:0.4;">${rain}</svg>`;
}

// ———————–
// 3D Holographic Grid with Depth
// ———————–
function generateHolographicGrid() {
  let grid = '';
  const size = 12;

  for (let i = 0; i <= 100; i += size) {
    const depthOpacity = 0.05 + (i / 100) * 0.15;
    grid += `<line x1="${i}%" y1="0%" x2="${i}%" y2="100%" stroke="#00f3ff" stroke-opacity="${depthOpacity}">
      <animate attributeName="stroke-opacity" values="${depthOpacity};${depthOpacity * 3};${depthOpacity}" dur="4s" repeatCount="indefinite"/>
    </line>`;
    grid += `<line x1="0%" y1="${i}%" x2="100%" y2="${i}%" stroke="#ff00ff" stroke-opacity="${depthOpacity}">
      <animate attributeName="stroke-opacity" values="${depthOpacity};${depthOpacity * 3};${depthOpacity}" dur="3s" repeatCount="indefinite"/>
    </line>`;
  }

  for (let i = 1; i <= 3; i++) {
    const radius = i * 15;
    grid += `<circle cx="50%" cy="50%" r="${radius}%" fill="none" stroke="#b967ff" stroke-opacity="0.1" stroke-width="0.5">
      <animate attributeName="r" values="${radius - 2}%;${radius + 2}%;${radius - 2}%" dur="${4 + i}s" repeatCount="indefinite"/>
    </circle>`;
  }

  return `<svg width="100%" height="100%" style="position:absolute;top:0;left:0;z-index:1;opacity:0.8;">${grid}</svg>`;
}

// ———————–
// Quantum Circuit Animation
// ———————–
function generateQuantumCircuit() {
  const gates = ["H", "X", "Y", "Z", "CNOT", "SWAP", "T", "S"];
  let circuit = '';

  gates.forEach((gate, index) => {
    const x = Math.random() * 80 + 10;
    const y = Math.random() * 60 + 20;
    const delay = index * 0.5;

    circuit += `
    <g transform="translate(${x}, ${y})">
      <rect x="-15" y="-10" width="30" height="20" rx="3" fill="#0a0a0f" stroke="#00f3ff" stroke-width="1" opacity="0.8">
        <animate attributeName="stroke" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="${delay}s"/>
      </rect>
      <text text-anchor="middle" dominant-baseline="middle" fill="#00f3ff" font-family="monospace" font-size="10" font-weight="bold">
        ${gate}
        <animate attributeName="fill" values="#00f3ff;#ff00ff;#00f3ff" dur="3s" repeatCount="indefinite" begin="${delay}s"/>
      </text>
    </g>`;
  });

  return `<svg width="100%" height="100%" style="position:absolute;top:0;left:0;z-index:1;opacity:0.6;">${circuit}</svg>`;
}

// ———————–
// Interactive Profile Cards
// ———————–
function generateProfileCards() {
  return `
  <div style="position:absolute;top:2rem;left:2rem;z-index:3;display:flex;flex-direction:column;gap:1rem;">
    <div class="profile-card" style="background:rgba(10,10,15,0.8);padding:1rem;border-radius:10px;border:1px solid #00f3ff;backdrop-filter:blur(10px);min-width:200px;">
      <div style="display:flex;align-items:center;gap:0.5rem;margin-bottom:0.5rem;">
        <div style="width:8px;height:8px;background:#00ff41;border-radius:50%;"></div>
        <span style="font-family:'Ubuntu Mono',monospace;color:#00f3ff;font-size:0.8rem;">GITHUB STATS</span>
      </div>
      <div style="color:#ff00ff;font-family:'Ubuntu Mono',monospace;font-size:0.7rem;">
        <div>📊 Followers: <span style="color:#00ff41;">growing</span></div>
        <div>⭐ Stars: <span style="color:#00ff41;">rising</span></div>
        <div>📚 Repos: <span style="color:#00ff41;">active</span></div>
      </div>
    </div>
    <div class="profile-card" style="background:rgba(10,10,15,0.8);padding:1rem;border-radius:10px;border:1px solid #ff00ff;backdrop-filter:blur(10px);min-width:200px;">
      <div style="display:flex;align-items:center;gap:0.5rem;margin-bottom:0.5rem;">
        <div style="width:8px;height:8px;background:#b967ff;border-radius:50%;"></div>
        <span style="font-family:'Ubuntu Mono',monospace;color:#ff00ff;font-size:0.8rem;">CODING ACTIVITY</span>
      </div>
      <div style="color:#00f3ff;font-family:'Ubuntu Mono',monospace;font-size:0.7rem;">
        <div>🔄 Current: Quantum Scripts</div>
        <div>📈 Focus: DevOps & Automation</div>
        <div>🎯 Learning: Advanced K8s</div>
      </div>
    </div>
  </div>`;
}

// ———————–
// Enhanced Typing Animation Container
// ———————–
function generateTypingAnimation() {
  return `
  <div style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);z-index:3;text-align:center;">
    <div style="background:rgba(10,10,15,0.9);padding:2rem;border-radius:15px;border:1px solid #00f3ff;box-shadow:0 0 30px rgba(0,243,255,0.3);backdrop-filter:blur(10px);">
      <a href="https://git.io/typing-svg" style="text-decoration:none;">
        <img 
          src="https://readme-typing-svg.herokuapp.com?font=Ubuntu+Mono&weight=600&size=22&duration=2000&pause=500&color=00F3FF&background=0a0a0f00&center=true&vCenter=true&width=550&height=80&lines=ℌ𝔢𝔩𝔩𝔬+𝔗𝔥𝔢𝔯𝔢;ℑ'𝔪+ɬɧɛ+ɠıɬƈɧ;𝔚𝔢𝔩𝔠𝔬𝔪𝔢+𝔱𝔬+𝔪𝔶+𝔮𝔲𝔞𝔫𝔱𝔲𝔪+𝔯𝔢𝔞𝔩𝔪;𝔖𝔥𝔢𝔩𝔩+𝔖𝔠𝔯𝔦𝔭𝔱+𝔈𝔫𝔱𝔥𝔲𝔰𝔦𝔞𝔰𝔱;𝔏𝔦𝔫𝔲𝔵+%26+𝔇𝔢𝔳𝔒𝔭𝔰+𝔈𝔵𝔭𝔩𝔬𝔯𝔢𝔯;𝔒𝔭𝔢𝔫+𝔖𝔬𝔲𝔯𝔠𝔢+ℭ𝔬𝔫𝔱𝔯𝔦𝔟𝔲𝔱𝔬𝔯;𝔄𝔩𝔴𝔞𝔶𝔰+𝔏𝔢𝔞𝔯𝔫𝔦𝔫𝔤+%F0%9F%92%A1" 
          alt="Cyberpunk Typing Animation"
          style="filter: drop-shadow(0 0 15px rgba(0,243,255,0.7)) drop-shadow(0 0 25px rgba(0,243,255,0.4));"
        />
      </a>
      <div style="margin-top:1rem;font-family:'Ubuntu Mono',monospace;font-size:0.8rem;color:#ff00ff;">
        <span style="color:#00f3ff;">//</span> Quantum Developer | Cyberpunk Architect
      </div>
    </div>
  </div>`;
}

// ———————–
// Social Links with Awesome Style
// ———————–
function generateSocialLinks() {
  return `
  <div style="position:absolute;bottom:2rem;right:2rem;z-index:3;display:flex;gap:1rem;">
    <a href="https://github.com/${GITHUB_USERNAME}" style="text-decoration:none;">
      <div class="social-btn" style="background:rgba(0,243,255,0.1);padding:0.5rem 1rem;border-radius:25px;border:1px solid #00f3ff;color:#00f3ff;font-family:'Ubuntu Mono',monospace;font-size:0.8rem;transition:all 0.3s ease;display:flex;align-items:center;gap:0.5rem;">
        <span>🐙</span> GitHub
      </div>
    </a>
    <a href="https://twitter.com/yourhandle" style="text-decoration:none;">
      <div class="social-btn" style="background:rgba(255,0,255,0.1);padding:0.5rem 1rem;border-radius:25px;border:1px solid #ff00ff;color:#ff00ff;font-family:'Ubuntu Mono',monospace;font-size:0.8rem;transition:all 0.3s ease;display:flex;align-items:center;gap:0.5rem;">
        <span>🐦</span> Twitter
      </div>
    </a>
    <a href="https://linkedin.com/in/yourprofile" style="text-decoration:none;">
      <div class="social-btn" style="background:rgba(185,103,255,0.1);padding:0.5rem 1rem;border-radius:25px;border:1px solid #b967ff;color:#b967ff;font-family:'Ubuntu Mono',monospace;font-size:0.8rem;transition:all 0.3s ease;display:flex;align-items:center;gap:0.5rem;">
        <span>💼</span> LinkedIn
      </div>
    </a>
  </div>`;
}

// ———————–
// Generate Complete Header
// ———————–
function generateHeader() {
  const matrix = generateMatrixRain();
  const grid = generateHolographicGrid();
  const circuit = generateQuantumCircuit();
  const cards = generateProfileCards();
  const typing = generateTypingAnimation();
  const social = generateSocialLinks();

  return `
<div class="cyber-container" style="position:relative;width:100%;height:600px;background:linear-gradient(135deg,#0a0a0f 0%,#1a1b26 50%,#0a0a0f 100%);overflow:hidden;border-radius:20px;margin:2rem 0;border:2px solid transparent;background-clip:padding-box;box-shadow:0 0 50px rgba(0,243,255,0.2);">
  <div style="position:absolute;top:0;left:0;width:100%;height:100%;border-radius:20px;padding:2px;background:linear-gradient(45deg,#00f3ff,#ff00ff,#b967ff,#00f3ff);background-size:400% 400%;animation:borderFlow 6s ease infinite;z-index:4;pointer-events:none;"></div>
  ${matrix}
  ${grid}
  ${circuit}
  ${cards}
  ${typing}
  ${social}
  <div style="position:absolute;bottom:1rem;left:2rem;z-index:3;font-family:'Ubuntu Mono',monospace;font-size:0.7rem;color:#00ff41;">
    <span style="color:#ff00ff;">▶</span> SYSTEM: <span style="color:#00f3ff;">QUANTUM_READY</span> | UPDATED: ${CURRENT_TIME}
  </div>
  <div style="position:absolute;top:0;left:0;width:100%;height:100%;background:repeating-linear-gradient(0deg, rgba(0,0,0,0) 0px, rgba(0,0,0,0) 1px, rgba(0,243,255,0.03) 2px, rgba(0,0,0,0) 3px);z-index:2;pointer-events:none;"></div>
</div>

<style>
  @keyframes borderFlow {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
  }
  .cyber-container:hover {
    box-shadow: 0 0 60px rgba(0,243,255,0.4), inset 0 0 40px rgba(0,243,255,0.2);
    transform: translateY(-3px);
    transition: all 0.3s ease;
  }
  .profile-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 0 20px rgba(0,243,255,0.3);
    transition: all 0.3s ease;
  }
  .social-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 0 15px currentColor;
    background: rgba(255,255,255,0.1) !important;
    transition: all 0.3s ease;
  }
</style>`;
}

// ———————–
// Write to README
// ———————–
try {
  let content = '';
  if (fs.existsSync(README_FILE)) {
    content = fs.readFileSync(README_FILE, 'utf8');
    content = content.replace(/[\s\S]*/g, '').trim();
  }

  const header = generateHeader();
  fs.writeFileSync(README_FILE, `${header}\n\n${content}`);

  console.log('🚀 ULTIMATE CYBERPUNK HEADER GENERATED!');
  console.log('✨ Inspired by awesome-github-profile-readme with:');
  console.log('   🌌 Advanced Matrix Rain with multiple character sets');
  console.log('   🔮 3D Holographic Grid with quantum circuits');
  console.log('   📊 Interactive Profile Cards (GitHub stats style)');
  console.log('   ⌨️ Enhanced Typing Animation with cyberpunk styling');
  console.log('   🔗 Social Links with hover effects');
  console.log('   📱 Responsive design for all devices');
  console.log('   🎮 Interactive hover animations throughout');
  console.log(`👤 Profile: ${AUTHOR} (${GITHUB_USERNAME})`);
} catch (err) {
  console.error('❌ Error generating header:', err);
  process.exit(1);
}
