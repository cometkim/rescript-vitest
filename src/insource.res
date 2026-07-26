if Vitest.inSource {
  open Vitest.InSource

  test("In-source testing", t => {
    t->expect(1 + 2)->Expect.toBe(3)
  })

  testAsync("Async in-source testing", async t => {
    let result = await Promise.resolve(3)
    t->expect(result)->Expect.toBe(3)
  })

  it("In-source it", t => {
    t->expect(1 + 2)->Expect.toBe(3)
  })

  itAsync("Async in-source it", async t => {
    let result = await Promise.resolve(3)
    t->expect(result)->Expect.toBe(3)
  })
}
