open Vitest

Each.testObject(
  [{"a": 3, "b": 5, "sum": 8}, {"a": 6, "b": 2, "sum": 8}],
  "obj: sum $a+$b=$sum",
  i => {
    expect(i["a"] + i["b"])->Expect.toBe(i["sum"])
    expect(i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
  },
)

Each.test2([(1, "1"), (6, "6")], "test2: %i=%s", (a, b) => {
  expect(a->Js.Int.toString)->Expect.toBe(b)
  expect((a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
})

Each.test3([(1, 3, "4"), (6, 3, "9")], "test3: sum %i+%i=%s", (a, b, sum) => {
  expect((a + b)->Js.Int.toString)->Expect.toBe(sum)
  expect((a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})
