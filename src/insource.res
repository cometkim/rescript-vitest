if Vitest.inSource {
  open Vitest
  open! Vitest.InSource

  test("In-source testing", _ => {
    expect(1 + 2)->Expect.toBe(3)
  })
}
