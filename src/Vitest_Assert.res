type t

%%private(@module("vitest") @val external assert_obj: t = "assert")

@module("vitest")
external assert_: (bool, Js.undefined<string>) => unit = "assert"
let assert_ = (~message=?, value) => assert_(value, message->Js.Undefined.fromOption)

@module("vitest") @scope("expect")
external unreachable: (~message: string=?, unit) => unit = "unreachable"

@send external equal: (t, 'a, 'a, Js.undefined<string>) => unit = "equal"

@inline
let equal = (~message=?, a, b) => assert_obj->equal(a, b, message->Js.Undefined.fromOption)

@send external notEqual: (t, 'a, 'a, Js.undefined<string>) => unit = "notEqual"

@inline
let notEqual = (~message=?, a, b) => assert_obj->notEqual(a, b, message->Js.Undefined.fromOption)

@send external deepEqual: (t, 'a, 'a, Js.undefined<string>) => unit = "deepEqual"

@inline
let deepEqual = (~message=?, a, b) => assert_obj->deepEqual(a, b, message->Js.Undefined.fromOption)

@send external notDeepEqual: (t, 'a, 'a, Js.undefined<string>) => unit = "notDeepEqual"

@inline
let notDeepEqual = (~message=?, a, b) =>
  assert_obj->notDeepEqual(a, b, message->Js.Undefined.fromOption)

@send external strictEqual: (t, 'a, 'a, Js.undefined<string>) => unit = "strictEqual"

@inline
let strictEqual = (~message=?, a, b) =>
  assert_obj->strictEqual(a, b, message->Js.Undefined.fromOption)

@send external notStrictEqual: (t, 'a, 'a, Js.undefined<string>) => unit = "notStrictEqual"

@inline
let notStrictEqual = (~message=?, a, b) =>
  assert_obj->notStrictEqual(a, b, message->Js.Undefined.fromOption)

@send external deepStrictEqual: (t, 'a, 'a, Js.undefined<string>) => unit = "deepStrictEqual"

@inline
let deepStrictEqual = (~message=?, a, b) =>
  assert_obj->deepStrictEqual(a, b, message->Js.Undefined.fromOption)

@send external fail: (t, Js.undefined<'a>, Js.undefined<'a>, Js.undefined<string>) => unit = "fail"

@inline
let fail = (~actual=?, ~expected=?, ~message=?) =>
  assert_obj->fail(
    actual->Js.Undefined.fromOption,
    expected->Js.Undefined.fromOption,
    message->Js.Undefined.fromOption,
  )
