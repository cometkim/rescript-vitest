let echoAsync = async msg => msg

open Vitest

testPromise("Promise test", async _ => {
  let result = await echoAsync("Hey")
  expect(result)->Expect.toEqual("Hey")
})
