// scripts/generate-badges.js

const badges = [
  // Web / JS Stack
  { name: "Web3.js", color: "F16822", logo: "web3.js" },
  { name: "JavaScript", color: "323330", logo: "javascript" },
  { name: "TypeScript", color: "007ACC", logo: "typescript" },
  { name: "NodeJS", color: "6DA55F", logo: "node.js" },
  { name: "React", color: "20232a", logo: "react" },
  { name: "React Native", color: "20232a", logo: "react" },
  { name: "React Query", color: "FF4154", logo: "react query" },
  { name: "React Router", color: "CA4245", logo: "react-router" },
  { name: "React Hook Form", color: "EC5990", logo: "reacthookform" },
  { name: "Redux", color: "593d88", logo: "redux" },
  { name: "Remix", color: "000000", logo: "remix" },
  { name: "Semantic UI React", color: "35BDB2", logo: "SemanticUIReact" },
  { name: "Ant-Design", color: "0170FE", logo: "ant-design" },
  { name: "Chakra", color: "4ED1C5", logo: "chakraui" },
  { name: "Next-js", color: "000000", logo: "next.js" },
  { name: "Angular", color: "DD0031", logo: "angular" },
  { name: "Svelte", color: "f1413d", logo: "svelte" },
  { name: "Azure", color: "0072C6", logo: "azure-devops" },
  { name: "Webpack", color: "8DD6F9", logo: "webpack" },
  { name: "Firebase", color: "039BE5", logo: "firebase" },
  { name: "Cloudflare", color: "F38020", logo: "Cloudflare" },
  { name: "Docker", color: "46a2f1", logo: "docker" },
  { name: "HTML5", color: "E34F26", logo: "html5" },
  { name: "CSS3", color: "1572B6", logo: "css3" },
  { name: "MicrosoftSQLServer", color: "CC2927", logo: "microsoft sql server" },
  { name: "Git", color: "F05032", logo: "git" },
  { name: "Github Actions", color: "2088FF", logo: "github-actions" },
  { name: "GitHub", color: "121011", logo: "github" },
  { name: "Visual Studio Code", color: "0078d7", logo: "visual-studio-code" },
  { name: "AdonisJS", color: "220052", logo: "adonisjs" },
  { name: "Chart.js", color: "F5788D", logo: "chart.js" },
  { name: "Express.js", color: "404d59", logo: "express" },
  { name: "Expo", color: "1C1E24", logo: "expo" },
  { name: "Fastify", color: "000000", logo: "fastify" },
  { name: "MUI", color: "0081CB", logo: "mui" },
  { name: "NestJS", color: "E0234E", logo: "nestjs" },
  { name: "Vue.js", color: "35495e", logo: "vuedotjs" },
  { name: "Nuxtjs", color: "002E3B", logo: "nuxtdotjs" },
  { name: "SASS", color: "hotpink", logo: "SASS" },
  { name: "Styled Components", color: "DB7093", logo: "styled-components" },
  { name: "TailwindCSS", color: "38B2AC", logo: "tailwind-css" },
  { name: "Vite", color: "646CFF", logo: "vite" },
  // Mobile / Dart / Java
  { name: "Java", color: "ED8B00", logo: "java" },
  { name: "Dart", color: "0175C2", logo: "dart" },
  { name: "Flutter", color: "02569B", logo: "Flutter" },
  { name: "Clojure", color: "Clojure", logo: "Clojure" },
  { name: "GraphQL", color: "E10098", logo: "graphql" },
  { name: "Apollo-GraphQL", color: "311C87", logo: "apollo-graphql" },
  { name: "Python", color: "3670A0", logo: "python" },
  { name: "jQuery", color: "0769AD", logo: "jquery" },
  // Cloud / DevOps
  { name: "AWS", color: "FF9900", logo: "amazon-aws" },
  { name: "DigitalOcean", color: "0167ff", logo: "digitalOcean" },
  { name: "IntelliJ IDEA", color: "000000", logo: "intellij-idea" },
  { name: "Deno JS", color: "000000", logo: "deno" },
  { name: "Electron.js", color: "191970", logo: "Electron" },
  { name: "Ember", color: "1C1E24", logo: "ember.js" },
  { name: "Ionic", color: "3880FF", logo: "Ionic" },
  { name: "Strapi", color: "2E7EEA", logo: "strapi" },
  { name: "Linux", color: "FCC624", logo: "linux" },
  { name: "NPM", color: "CB3837", logo: "npm" }
];

// Print badges in Markdown format
function printBadges() {
  badges.forEach(b => {
    console.log(`![${b.name}](https://img.shields.io/badge/${encodeURIComponent(b.name)}-${b.color}?style=for-the-badge&logo=${encodeURIComponent(b.logo)}&logoColor=white)`);
  });
}

module.exports = { printBadges };

// Allow direct execution
if (require.main === module) printBadges();