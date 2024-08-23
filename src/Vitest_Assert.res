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

@send external deepEqual: (t, 'a, 'a, Js.undefined<string>) => unit = "deepEqual"

@inline
let deepEqual = (~message=?, a, b) => assert_obj->deepEqual(a, b, message->Js.Undefined.fromOption)
