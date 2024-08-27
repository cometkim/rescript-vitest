open Js
open Vitest

test("Math.sqrt()", t => {
  open Expect

  t->assertions(3)

  t->expect(Math.sqrt(4.0))->toBe(2.0)
  t->expect(Math.sqrt(144.0))->toBe(12.0)
  t->expect(Math.sqrt(2.0))->toBe(Math._SQRT2)
})

@scope("JSON") @val external parse: string => 'a = "parse"
@scope("JSON") @val external stringify: 'a => string = "stringify"

test("JSON", t => {
  let input = {
    "foo": "hello",
    "bar": "world",
  }

  let output = stringify(input)

  t->expect(output)->Expect.eq(`{"foo":"hello","bar":"world"}`)
  Assert.deepEqual(parse(output), input, ~message="matches original")
})

exception TestError

let throwExn = () => {
  raise(TestError)
}

test("Exn", t => {
  t->expect(() => throwExn())->Expect.toThrowError
})
