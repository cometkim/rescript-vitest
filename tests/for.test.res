open Vitest

let sumObj = [{"a": 3, "b": 5, "sum": 8}, {"a": 6, "b": 2, "sum": 8}]
let sum2 = [(1, "1"), (6, "6")]
let sum3 = [(1, 3, "4"), (6, 3, "9")]
let sum4 = [(1, 2, 8, "11"), (6, 3, 8, "17"), (5, 9, 2, "16")]
let sum5 = [(1, 3, 8, 6, "18"), (6, 3, 2, 4, "15"), (5, 9, 2, 3, "19")]

sumObj->For.test("test: sum $a+$b=$sum", (i, t) => {
  t->expect(i["a"] + i["b"])->Expect.toBe(i["sum"])
  t->expect(i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
})

sum2->For.test("test: %i=%s", ((a, b), t) => {
  t->expect(a->Js.Int.toString)->Expect.toBe(b)
  t->expect((a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
})

sum3->For.test("test: sum %i+%i=%s", ((a, b, sum), t) => {
  t->expect((a + b)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sum4->For.test("test: sum %i+%i+%i=%s", ((a, b, c, sum), t) => {
  t->expect((a + b + c)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sum5->For.test("test: sum %i+%i+%i+%i=%s", ((a, b, c, d, sum), t) => {
  t->expect((a + b + c + d)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sumObj->For.testAsync("testAsync: sum $a+$b=$sum", async (i, t) => {
  t->expect(i["a"] + i["b"])->Expect.toBe(i["sum"])
  t->expect(i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
})

sum2->For.testAsync("testAsync: %i=%s", async ((a, b), t) => {
  t->expect(a->Js.Int.toString)->Expect.toBe(b)
  t->expect((a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
})

sum3->For.testAsync("testAsync: sum %i+%i=%s", async ((a, b, sum), t) => {
  t->expect((a + b)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sum4->For.testAsync("testAsync: sum %i+%i+%i=%s", async ((a, b, c, sum), t) => {
  t->expect((a + b + c)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sum5->For.testAsync("testAsync: sum %i+%i+%i+%i=%s", async ((a, b, c, d, sum), t) => {
  t->expect((a + b + c + d)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sumObj->For.it("it: sum $a+$b=$sum", (i, t) => {
  t->expect(i["a"] + i["b"])->Expect.toBe(i["sum"])
  t->expect(i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
})

sum2->For.it("it: %i=%s", ((a, b), t) => {
  t->expect(a->Js.Int.toString)->Expect.toBe(b)
  t->expect((a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
})

sum3->For.it("it: sum %i+%i=%s", ((a, b, sum), t) => {
  t->expect((a + b)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sum4->For.it("it: sum %i+%i+%i=%s", ((a, b, c, sum), t) => {
  t->expect((a + b + c)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sum5->For.it("it: sum %i+%i+%i+%i=%s", ((a, b, c, d, sum), t) => {
  t->expect((a + b + c + d)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sumObj->For.itAsync("itAsync: sum $a+$b=$sum", async (i, t) => {
  t->expect(i["a"] + i["b"])->Expect.toBe(i["sum"])
  t->expect(i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
})

sum2->For.itAsync("itAsync: %i=%s", async ((a, b), t) => {
  t->expect(a->Js.Int.toString)->Expect.toBe(b)
  t->expect((a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
})

sum3->For.itAsync("itAsync: sum %i+%i=%s", async ((a, b, sum), t) => {
  t->expect((a + b)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sum4->For.itAsync("itAsync: sum %i+%i+%i=%s", async ((a, b, c, sum), t) => {
  t->expect((a + b + c)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

sum5->For.itAsync("itAsync: sum %i+%i+%i+%i=%s", async ((a, b, c, d, sum), t) => {
  t->expect((a + b + c + d)->Js.Int.toString)->Expect.toBe(sum)
  t->expect((a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})
