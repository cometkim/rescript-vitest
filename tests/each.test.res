open Vitest

Each.testObject([{"a": 3, "b": 5, "sum": 8}, {"a": 6, "b": 2, "sum": 8}], "sum $a+$b=$sum", i => {
  expect(i["a"] + i["b"])->Expect.toBe(i["sum"])
  expect(i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
})
