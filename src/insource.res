if Vitest.inSource {
  open Vitest.InSource

  test("In-source testing", t => {
    t->expect(1 + 2)->Expect.toBe(3)
  })
}
