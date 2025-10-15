// scripts/fetch-quote.js

const quotes = [
  "Stay hungry, stay foolish.",
  "Code is like humor. When you have to explain it, it’s bad.",
  "Talk is cheap. Show me the code.",
  "Simplicity is the soul of efficiency.",
  "Debugging is like being the detective in a crime movie where you are also the murderer."
];

function getQuote() {
  const index = Math.floor(Math.random() * quotes.length);
  return quotes[index];
}

// ✅ Export properly for require()
module.exports = { getQuote };
