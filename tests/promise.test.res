let echoAsync = async msg => msg

exception TestError

let throwAsync: unit => Js.Promise2.t<string> = async () => {
  raise(TestError)
}

open Vitest

testAsync("async/await test 1", async t => {
  let result = await echoAsync("Hey")
  t->expect(result)->Expect.toEqual("Hey")
})

testAsync("async/await test 2", async t => {
  await t->expect(echoAsync("Hey"))->Expect.Promise.resolves->Expect.Promise.toEqual("Hey")
})

testAsync("exception test for async functions", async t => {
  await t->expect(throwAsync())->Expect.Promise.rejects->Expect.Promise.toThrow
})
