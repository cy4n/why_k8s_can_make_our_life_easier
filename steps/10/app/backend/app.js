const http = require('http')
const port = 80

const requestHandler = (request, response) => {
  console.log('coming http url: ' + request.url)
  console.log('coming http headers: ', request.headers);
  response.writeHeader(200, {"Content-Type": "application/json"}); 
  response.end(JSON.stringify({
      grettings: "Hi Istio workshop from v1"
  }))
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }

  console.log(`server is listening on port ${port}`)
})

process.on('SIGTERM', function() {
  console.log('\ncaught SIGTERM, stopping gracefully');
  process.exit(1);
});
