open Vitest

describe("Expect", () => {
  describe("List", () => {
    Todo.test("toContainEqual")

    test(
      "toContain",
      _t => {
        let value = list{1, 2, 3}
        expect(value)->Expect.List.toContain(1)
        expect(value)->Expect.List.toContain(2)
        expect(value)->Expect.List.toContain(3)
        expect(value)->Expect.not->Expect.List.toContain(4)
      },
    )

    test(
      "toHaveLength",
      _t => {
        let value = list{1, 2, 3}
        expect(value)->Expect.List.toHaveLength(3)
        expect(value)->Expect.not->Expect.List.toHaveLength(5)
      },
    )

    test(
      "toMatch",
      _t => {
        let value = list{1, 2, 3}
        expect(value)->Expect.List.toMatch(list{1, 2, 3})
        expect(value)->Expect.not->Expect.List.toMatch(list{1, 2})
      },
    )
  })
})