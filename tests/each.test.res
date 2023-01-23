open Vitest

let echoAsync = async msg => msg

let sumObj = [{"a": 3, "b": 5, "sum": 8}, {"a": 6, "b": 2, "sum": 8}]
let sum2 = [(1, "1"), (6, "6")]
let sum3 = [(1, 3, "4"), (6, 3, "9")]
let sum4 = [(1, 3, 8, "12"), (6, 3, 2, "11"), (5, 9, 2, "16")]
let sum5 = [(1, 3, 8, 6, "18"), (6, 3, 2, 4, "15"), (5, 9, 2, 3, "19")]

Each.test(sumObj, "test: sum $a+$b=$sum", i => {
  expect(i["a"] + i["b"])->Expect.toBe(i["sum"])
  expect(i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
})

Each.describe(sumObj, "describe: sum $a+$b=$sum", i => {
  test("correct", _ => expect(i["a"] + i["b"])->Expect.toBe(i["sum"]))
  test("incorrect", _ => expect(i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"]))
})

Each.testAsync(sumObj, "testAsync: sum $a+$b=$sum", i =>
  {
    expect(i["a"] + i["b"])->Expect.toBe(i["sum"])
    expect(i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"])
  }->echoAsync
)

Each.describeAsync(sumObj, "describeAsync: sum $a+$b=$sum", i =>
  {
    test("correct", _ => expect(i["a"] + i["b"])->Expect.toBe(i["sum"]))
    test("incorrect", _ => expect(i["a"] + i["b"] + 1)->Expect.not->Expect.toBe(i["sum"]))
  }->echoAsync
)

Each.test2(sum2, "test2: %i=%s", (a, b) => {
  expect(a->Js.Int.toString)->Expect.toBe(b)
  expect((a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
})

Each.describe2(sum2, "describe2: %i=%s", (a, b) => {
  test("correct", _ => expect(a->Js.Int.toString)->Expect.toBe(b))
  test("incorrect", _ => expect((a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b))
})

Each.test2Async(sum2, "test2Async: %i=%s", (a, b) =>
  {
    expect(a->Js.Int.toString)->Expect.toBe(b)
    expect((a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b)
  }->echoAsync
)

Each.describe2Async(sum2, "describe2Async: %i=%s", (a, b) =>
  {
    test("correct", _ => expect(a->Js.Int.toString)->Expect.toBe(b))
    test("incorrect", _ => expect((a + 1)->Js.Int.toString)->Expect.not->Expect.toBe(b))
  }->echoAsync
)

Each.test3(sum3, "test3: sum %i+%i=%s", (a, b, sum) => {
  expect((a + b)->Js.Int.toString)->Expect.toBe(sum)
  expect((a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

Each.describe3(sum3, "describe3: sum %i+%i=%s", (a, b, sum) => {
  test("correct", _ => expect((a + b)->Js.Int.toString)->Expect.toBe(sum))
  test("incorrect", _ => expect((a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum))
})

Each.test3Async(sum3, "test3Async: sum %i+%i=%s", (a, b, sum) =>
  {
    expect((a + b)->Js.Int.toString)->Expect.toBe(sum)
    expect((a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
  }->echoAsync
)

Each.describe3Async(sum3, "describe3Async: sum %i+%i=%s", (a, b, sum) =>
  {
    test("correct", _ => expect((a + b)->Js.Int.toString)->Expect.toBe(sum))
    test("incorrect", _ => expect((a + b + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum))
  }->echoAsync
)

Each.test4(sum4, "test4: sum %i+%i+%i=%s", (a, b, c, sum) => {
  expect((a + b + c)->Js.Int.toString)->Expect.toBe(sum)
  expect((a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

Each.describe4(sum4, "describe4: sum %i+%i+%i=%s", (a, b, c, sum) => {
  test("correct", _ => expect((a + b + c)->Js.Int.toString)->Expect.toBe(sum))
  test("incorrect", _ => expect((a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum))
})

Each.test4Async(sum4, "test4Async: sum %i+%i+%i=%s", (a, b, c, sum) =>
  {
    expect((a + b + c)->Js.Int.toString)->Expect.toBe(sum)
    expect((a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
  }->echoAsync
)

Each.describe4Async(sum4, "describe4Async: sum %i+%i+%i=%s", (a, b, c, sum) =>
  {
    test("correct", _ => expect((a + b + c)->Js.Int.toString)->Expect.toBe(sum))
    test("incorrect", _ => expect((a + b + c + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum))
  }->echoAsync
)

Each.test5(sum5, "test5: sum %i+%i+%i+%i=%s", (a, b, c, d, sum) => {
  expect((a + b + c + d)->Js.Int.toString)->Expect.toBe(sum)
  expect((a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
})

Each.describe5(sum5, "describe5: sum %i+%i+%i+%i=%s", (a, b, c, d, sum) => {
  test("correct", _ => expect((a + b + c + d)->Js.Int.toString)->Expect.toBe(sum))
  test("incorrect", _ => expect((a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum))
})

Each.test5Async(sum5, "test5Async: sum %i+%i+%i+%i=%s", (a, b, c, d, sum) =>
  {
    expect((a + b + c + d)->Js.Int.toString)->Expect.toBe(sum)
    expect((a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
  }->echoAsync
)

Each.describe5Async(sum5, "describe5Async: sum %i+%i+%i+%i=%s", (a, b, c, d, sum) =>
  {
    test("correct", _ => expect((a + b + c + d)->Js.Int.toString)->Expect.toBe(sum))
    test("incorrect", _ =>
      expect((a + b + c + d + 1)->Js.Int.toString)->Expect.not->Expect.toBe(sum)
    )
  }->echoAsync
)
