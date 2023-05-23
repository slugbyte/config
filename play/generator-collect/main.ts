import prettyBytes from 'pretty-bytes'
// const prettyBytes = require("pretty-bytes")

async function *createGarbage(){
  var remaining_call_count = 100;
  while (0 < remaining_call_count) {
    yield new Array(1000).fill(1).reduce((result) => {
      return {
        ...result,
        [Math.random()]: Math.random(),
      }
    })
  }
}

async function main () {
  var count = 0
  for await (const wat of createGarbage()) {
    console.log(count)
    if (count % 5 === 0) {
      console.log({memory: prettyBytes( process.memoryUsage().heapUsed)})
    }
    count++
  }
}

main()
  .then(() => console.log("success"))
  .catch(() => console.error("error"))

export default main
