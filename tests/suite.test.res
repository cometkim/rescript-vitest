open Js
open Vitest

Concurrent.describe("suite name", () => {
  it("foo", _ => {
    Assert.equal(Math.sqrt(4.0), 2.0)
  })

  open Vitest.Expect

  it("bar", _ => {
    expect(1 + 1)->eq(2)
  })

  it("snapshot", _ => {
    expect({"foo": "bar"})->toMatchSnapshot
  })
})

Todo.test("vi.fn()")
