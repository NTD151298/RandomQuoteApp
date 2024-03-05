const fs = require('fs');
const { Client } = require('pg')

var express = require('express');
var router = express.Router();

const VOLUME = "/tmp"
const client = new Client({
  user: process.env.DB_USER || 'postgres',
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_NAME || 'postgres',
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT || 5432,
})

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/env', function(req, res, next) {
  var environmentVariables = `USER: ${process.env.USER || 'sample-app'} - PORT: ${process.env.PORT}`
  res.send(`${environmentVariables}`);
});

router.get('/file', function(req, res, next) {
  var fileContent = 'Simple content to write.'
  var fileName = 'simple.txt'
  var filePath = `${VOLUME}/${fileName}`

  fs.writeFile(filePath, fileContent, err => {
    if (err) {
      console.error(err);
    }
    res.send('Write file successfully!');
  });
  return
});

router.get('/now', function(req, res, next) {
  client.connect()
  client.query('SELECT NOW()', (err, result) => {
    console.log(err, result)
    client.end()
    res.send(result)
  })
  return
});

module.exports = router;
