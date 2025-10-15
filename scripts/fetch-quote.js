// scripts/fetch-quote.js
// Dynamic quote generator for terminal SVG

const quotes = [
  "The only way to do great work is to love what you do. - Steve Jobs",
  "Code is like humor. When you have to explain it, it's bad. - Cory House",
  "First, solve the problem. Then, write the code. - John Johnson",
  "Experience is the name everyone gives to their mistakes. - Oscar Wilde",
  "In order to be irreplaceable, one must always be different. - Coco Chanel",
  "Knowledge is power. - Francis Bacon",
  "Simplicity is the soul of efficiency. - Austin Freeman",
  "Make it work, make it right, make it fast. - Kent Beck",
  "The best error message is the one that never shows up. - Thomas Fuchs",
  "Debugging is twice as hard as writing the code in the first place. - Brian Kernighan",
  "Talk is cheap. Show me the code. - Linus Torvalds",
  "Any fool can write code that a computer can understand. Good programmers write code that humans can understand. - Martin Fowler",
  "The function of good software is to make the complex appear to be simple. - Grady Booch",
  "Programming isn’t about what you know; it’s about what you can figure out. - Chris Pine",
  "The most disastrous thing that you can ever learn is your first programming language. - Alan Kay",
  "It’s not a bug – it’s an undocumented feature. - Anonymous",
  "Software is a great combination between artistry and engineering. - Bill Gates",
  "Before software can be reusable it first has to be usable. - Ralph Johnson",
  "Perfection is achieved not when there is nothing more to add, but rather when there is nothing more to take away. - Antoine de Saint-Exupery",
  "Don’t worry if it doesn’t work right. If everything did, you’d be out of a job. - Mosher’s Law of Software Engineering",
  "The computer was born to solve problems that did not exist before. - Bill Gates",
  "Innovation distinguishes between a leader and a follower. - Steve Jobs",
  "Quality is not an act, it is a habit. - Aristotle",
  "The only limit to our realization of tomorrow is our doubts of today. - Franklin D. Roosevelt",
  "Strive not to be a success, but rather to be of value. - Albert Einstein"
];

/**
 * Returns a deterministic quote for the current day.
 * Ensures the quote stays consistent daily.
 */
function getQuote() {
  const today = new Date();
  const startOfYear = new Date(today.getFullYear(), 0, 0);
  const dayOfYear = Math.floor((today - startOfYear) / 86400000);
  const index = dayOfYear % quotes.length;
  return quotes[index];
}

/**
 * Returns a random quote from the list.
 */
function getRandomQuote() {
  return quotes[Math.floor(Math.random() * quotes.length)];
}

module.exports = { getQuote, getRandomQuote, quotes };
