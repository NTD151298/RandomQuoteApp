var express = require('express');
var router = express.Router();

const quotes = [
  "The only way to do great work is to love what you do. - Steve Jobs",
  "Innovation distinguishes between a leader and a follower. - Steve Jobs",
  "The future depends on what you do today. - Mahatma Gandhi",
  "Success is not final, failure is not fatal: It is the courage to continue that counts. - Winston Churchill",
  "Strive not to be a success, but rather to be of value. - Albert Einstein",
  "The only limit to our realization of tomorrow will be our doubts of today. - Franklin D. Roosevelt",
  "The best way to predict the future is to create it. - Peter Drucker"
];

function getRandomQuote() {
  const randomIndex = Math.floor(Math.random() * quotes.length);
  return quotes[randomIndex];
}

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send(getRandomQuote());
});

module.exports = router;
