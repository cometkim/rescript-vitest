open Js
open Vitest

test("Math.sqrt()", t => {
  open Expect

  t->assertions(3)

  expect(Math.sqrt(4.0))->toBe(2.0)
  expect(Math.sqrt(144.0))->toBe(12.0)
  expect(Math.sqrt(2.0))->toBe(Math._SQRT2)
})

@scope("JSON") @val external parse: string => 'a = "parse"
@scope("JSON") @val external stringify: 'a => string = "stringify"

test("JSON", _ => {
  let input = {
    "foo": "hello",
    "bar": "world",
  }

  let output = stringify(input)

  expect(output)->Expect.eq(`{"foo":"hello","bar":"world"}`)
  Assert.deepEqual(parse(output), input, ~message="matches original")
})
