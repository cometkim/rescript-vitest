open Js
open Vitest

describe("suite name", () => {
  it("foo", () => {
    Assert.equal(Math.sqrt(4.0), 2.0)
  })

  open Vitest.Expect

  it("bar", () => {
    expect(1 + 1)->eq(2)
  })

  it("snapshot", () => {
    expect({"foo": "bar"})->toMatchSnapshot
  })

  ()
})

Todo.test("vi.fn()")
