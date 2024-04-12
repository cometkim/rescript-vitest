open Vitest

describe("Expect", () => {
  describe("Array", () => {
    test(
      "toContain",
      _t => {
        expect([1, 2, 3])->Expect.Array.toContain(2)
        expect(["hello", "world"])->Expect.Array.toContain("world")
        expect([true, false])->Expect.Array.toContain(false)
        expect([1, 2, 3])->Expect.not->Expect.Array.toContain(4)
      },
    )

    test(
      "toContainEqual",
      _t => {
        expect([1, 2, 3])->Expect.Array.toContainEqual(2)
        expect(["hello", "world"])->Expect.Array.toContainEqual("world")
        expect([true, false])->Expect.Array.toContainEqual(false)
        expect([1, 2, 3])->Expect.not->Expect.Array.toContainEqual(4)
      },
    )

    test(
      "toHaveLength",
      _t => {
        expect([1, 2, 3])->Expect.Array.toHaveLength(3)
        expect([])->Expect.Array.toHaveLength(0)
        expect([1, 2, 3])->Expect.not->Expect.Array.toHaveLength(5)
      },
    )

    test(
      "toMatch",
      _t => {
        expect([1, 2, 3])->Expect.Array.toMatch([1, 2, 3])
        expect(["hello", "world"])->Expect.Array.toMatch(["hello", "world"])
        expect([true, false])->Expect.Array.toMatch([true, false])
        expect([1, 2, 3])->Expect.not->Expect.Array.toMatch([1, 2])
      },
    )
  })

  describe("List", () => {
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
      "toContainEqual",
      _t => {
        let value = list{{"property": 1}, {"property": 2}, {"property": 3}}
        expect(value)->Expect.List.toContainEqual({"property": 1})
        expect(value)->Expect.List.toContainEqual({"property": 2})
        expect(value)->Expect.List.toContainEqual({"property": 3})
        expect(value)->Expect.not->Expect.List.toContainEqual({"property": 4})
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
