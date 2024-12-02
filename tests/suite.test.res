open Js
open Vitest

describe("suite name", () => {
  it("foo", _ => {
    Assert.equal(Math.sqrt(4.0), 2.0)
  })

  open Expect

  it("bar", t => {
    t->expect(1 + 1)->eq(2)
  })

  it("not", t => {
    t->expect(1 + 2)->not->eq(4)
  })

  it("snapshot", t => {
    t->expect({"foo": "bar"})->toMatchSnapshot
  })
})

Todo.test("vi.fn()")
