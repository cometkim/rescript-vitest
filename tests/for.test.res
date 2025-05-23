open Vitest

let sumObj = [{"a": 3, "b": 5, "sum": 8}, {"a": 6, "b": 2, "sum": 8}]
let sum2 = [(1, "1"), (6, "6")]
let sum3 = [(1, 3, "4"), (6, 3, "9")]
let sum4 = [(1, 2, 8, "11"), (6, 3, 8, "17"), (5, 9, 2, "16")]
let sum5 = [(1, 3, 8, 6, "18"), (6, 3, 2, 4, "15"), (5, 9, 2, 3, "19")]

For.test(sumObj, "test: sum $a+$b=$sum", (i, t) => {
  expect(t, i["a"] + i["b"])->Expect.toBe(i["sum"])
  expect(t, i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
})

For.test(sum2, "test: %i=%s", ((a, b), t) => {
  expect(t, a->Js.Int.toString)->Expect.toBe(b)
  expect(t, (a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
})

For.test(sum3, "test: sum %i+%i=%s", ((a, b, sum), t) => {
  expect(t, (a + b)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.test(sum4, "test: sum %i+%i+%i=%s", ((a, b, c, sum), t) => {
  expect(t, (a + b + c)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.test(sum5, "test: sum %i+%i+%i+%i=%s", ((a, b, c, d, sum), t) => {
  expect(t, (a + b + c + d)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.testAsync(sumObj, "testAsync: sum $a+$b=$sum", async (i, t) => {
  expect(t, i["a"] + i["b"])->Expect.toBe(i["sum"])
  expect(t, i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
})

For.testAsync(sum2, "testAsync: %i=%s", async ((a, b), t) => {
  expect(t, a->Js.Int.toString)->Expect.toBe(b)
  expect(t, (a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
})

For.testAsync(sum3, "testAsync: sum %i+%i=%s", async ((a, b, sum), t) => {
  expect(t, (a + b)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.testAsync(sum4, "testAsync: sum %i+%i+%i=%s", async ((a, b, c, sum), t) => {
  expect(t, (a + b + c)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.testAsync(sum5, "testAsync: sum %i+%i+%i+%i=%s", async ((a, b, c, d, sum), t) => {
  expect(t, (a + b + c + d)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.it(sumObj, "it: sum $a+$b=$sum", (i, t) => {
  expect(t, i["a"] + i["b"])->Expect.toBe(i["sum"])
  expect(t, i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
})

For.it(sum2, "it: %i=%s", ((a, b), t) => {
  expect(t, a->Js.Int.toString)->Expect.toBe(b)
  expect(t, (a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
})

For.it(sum3, "it: sum %i+%i=%s", ((a, b, sum), t) => {
  expect(t, (a + b)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.it(sum4, "it: sum %i+%i+%i=%s", ((a, b, c, sum), t) => {
  expect(t, (a + b + c)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.it(sum5, "it: sum %i+%i+%i+%i=%s", ((a, b, c, d, sum), t) => {
  expect(t, (a + b + c + d)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.itAsync(sumObj, "itAsync: sum $a+$b=$sum", async (i, t) => {
  expect(t, i["a"] + i["b"])->Expect.toBe(i["sum"])
  expect(t, i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
})

For.itAsync(sum2, "itAsync: %i=%s", async ((a, b), t) => {
  expect(t, a->Js.Int.toString)->Expect.toBe(b)
  expect(t, (a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
})

For.itAsync(sum3, "itAsync: sum %i+%i=%s", async ((a, b, sum), t) => {
  expect(t, (a + b)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.itAsync(sum4, "itAsync: sum %i+%i+%i=%s", async ((a, b, c, sum), t) => {
  expect(t, (a + b + c)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

For.itAsync(sum5, "itAsync: sum %i+%i+%i+%i=%s", async ((a, b, c, d, sum), t) => {
  expect(t, (a + b + c + d)->Js.Int.toString)->Expect.toBe(sum)
  expect(t, (a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})
