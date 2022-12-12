let echoAsync = async msg => msg

exception TestError

let throwAsync = async () => {
  raise(TestError)
}

open Vitest

testAsync("async/await test 1", async _ => {
  let result = await echoAsync("Hey")
  expect(result)->Expect.toEqual("Hey")
})

testAsync("async/await test 2", async _ => {
  await expect(echoAsync("Hey"))->Expect.Promise.resolves->Expect.Promise.toEqual("Hey")
})

testAsync("exception test for async functions", async _ => {
  await expect(throwAsync())->Expect.Promise.rejects->Expect.Promise.toThrow
})
