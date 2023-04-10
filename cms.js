var express = require('express')
var app = express()

app.set('port', (process.env.PORT || 7000))
app.use(express.static(__dirname + '/public'))

app.get('/', function(request, response) {
  response.send('Hello Nagendra it is master 12345678901234567890  qwetyuiufdfghigfdxdfghio eiewyuefjkncmsnciewuwejlefifwrifuefiufisdf')
})

app.listen(app.get('port'), function() {
  console.log("Node app is running at localhost:" + app.get('port'))
})
