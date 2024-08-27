open Vitest_Types

type reinforcement<'a, 'b> = (assertion<'a>, 'a => 'b) => assertion<'b>

external coerce_assertion: assertion<'a> => assertion<'b> = "%identity"

let dangerously_reinforce_assertion: reinforcement<'a, 'b> = %raw(`
  function(assertion, cast) {
    let inner = assertion.__flags;
    inner.object = cast(inner.object);
    return assertion;
  }
`)

module MakeMatchers = (
  Config: {
    type return<'a>
  },
) => {
  @get external not: assertion<'a> => assertion<'a> = "not"

  @send external toBe: (assertion<'a>, 'a) => Config.return<'a> = "toBe"

  @send external eq: (assertion<'a>, 'a) => Config.return<'a> = "eq"

  @send external toBeDefined: assertion<Js.undefined<'a>> => Config.return<'a> = "toBeDefined"

  @send external toBeUndefined: assertion<Js.undefined<'a>> => Config.return<'a> = "toBeUndefined"

  @send external toBeTruthy: assertion<'a> => Config.return<'a> = "toBeTruthy"

  @send external toBeFalsy: assertion<'a> => Config.return<'a> = "toBeFalsy"

  @send external toBeNull: assertion<Js.null<'a>> => Config.return<'a> = "toBeNull"

  // @send external toBeInstanceOf: (assertion<'a>, ?) => Config.return<'a> = "toBeInstanceOf"

  @send external toEqual: (assertion<'a>, 'a) => Config.return<'a> = "toEqual"

  @inline
  let toBeSome = (~some=?, expected: assertion<option<'a>>) => {
    switch some {
    | Some(id) => expected->toEqual(id)
    | None => expected->coerce_assertion->not->toBeUndefined
    }
  }

  @inline
  let toBeNone = (expected: assertion<option<'a>>) => {
    expected->coerce_assertion->toBeUndefined
  }

  @send external toStrictEqual: (assertion<'a>, 'a) => Config.return<'a> = "toStrictEqual"

  @send external toContain: (assertion<array<'a>>, 'a) => Config.return<'a> = "toContain"

  @send external toContainEqual: (assertion<array<'a>>, 'a) => Config.return<'a> = "toContainEqual"

  @send external toMatchSnapshot: assertion<'a> => Config.return<'a> = "toMatchSnapshot"

  @send
  external toThrow: (assertion<unit => 'a>, Js.undefined<string>) => Config.return<'a> = "toThrow"
  @inline
  let toThrow = (~message=?, expected) => expected->toThrow(message->Js.Undefined.fromOption)

  @send
  external toThrowError: (assertion<unit => 'a>, Js.undefined<string>) => Config.return<'a> =
    "toThrowError"
  @inline
  let toThrowError = (~message=?, expected) =>
    expected->toThrowError(message->Js.Undefined.fromOption)

  module Int = {
    type t = int
    type expected = assertion<t>

    @send external toBeGreaterThan: (expected, t) => Config.return<'a> = "toBeGreaterThan"

    @send
    external toBeGreaterThanOrEqual: (expected, t) => Config.return<'a> = "toBeGreaterThanOrEqual"

    @send external toBeLessThan: (expected, t) => Config.return<'a> = "toBeLessThan"

    @send external toBeLessThanOrEqual: (expected, t) => Config.return<'a> = "toBeLessThanOrEqual"
  }

  module Float = {
    type t = float
    type expected = assertion<t>

    @send external toBeNaN: expected => Config.return<'a> = "toBeNaN"

    @send
    external toBeCloseTo: (expected, t, int) => Config.return<'a> = "toBeCloseTo"

    @send
    external toBeGreaterThan: (expected, t) => Config.return<'a> = "toBeGreaterThan"

    @send
    external toBeGreaterThanOrEqual: (expected, t) => Config.return<'a> = "toBeGreaterThanOrEqual"

    @send
    external toBeLessThan: (expected, t) => Config.return<'a> = "toBeLessThan"

    @send
    external toBeLessThanOrEqual: (expected, t) => Config.return<'a> = "toBeLessThanOrEqual"
  }

  module String = {
    type t = string
    type expected = assertion<t>

    @send external toContain: (expected, t) => Config.return<'a> = "toContain"

    @send external toHaveLength: (expected, int) => Config.return<'a> = "toHaveLength"

    @send external toMatch: (expected, Js.Re.t) => Config.return<'a> = "toMatch"
  }

  module Array = {
    @send external toContain: (assertion<array<'a>>, 'a) => Config.return<'a> = "toContain"

    @send
    external toContainEqual: (assertion<array<'a>>, 'a) => Config.return<'a> = "toContainEqual"

    @send external toHaveLength: (assertion<array<'a>>, int) => Config.return<'a> = "toHaveLength"

    @send external toMatch: (assertion<array<'a>>, array<'a>) => Config.return<'a> = "toMatchObject"
  }

  module List = {
    @inline
    let toContain = (expected, item) => {
      expected
      ->dangerously_reinforce_assertion(list => list->Belt.List.toArray)
      ->Array.toContain(item)
    }

    @inline
    let toContainEqual = (expected, item) => {
      expected
      ->dangerously_reinforce_assertion(list => list->Belt.List.toArray)
      ->Array.toContainEqual(item)
    }

    @inline
    let toHaveLength = (expected, length) => {
      expected
      ->dangerously_reinforce_assertion(list => list->Belt.List.toArray)
      ->Array.toHaveLength(length)
    }

    @inline
    let toMatch = (expected, list) => {
      expected
      ->dangerously_reinforce_assertion(list => list->Belt.List.toArray)
      ->Array.toMatch(list->Belt.List.toArray)
    }
  }

  module Dict = {
    @send
    external toHaveProperty: (assertion<Js.Dict.t<'a>>, string, 'a) => Config.return<'a> =
      "toHaveProperty"

    @send
    external toHaveKey: (assertion<Js.Dict.t<'a>>, string) => Config.return<'a> = "toHaveProperty"

    @send
    external toMatch: (assertion<Js.Dict.t<'a>>, Js.Dict.t<'a>) => Config.return<'a> =
      "toMatchObject"
  }
}

include MakeMatchers({
  type return<'a> = unit
})

module Promise = {
  @get external rejects: assertion<promise<'a>> => assertion<'a> = "rejects"
  @get external resolves: assertion<promise<'a>> => assertion<'a> = "resolves"

  include MakeMatchers({
    type return<'a> = promise<unit>
  })

  @send
  external toThrow: (assertion<'a>, Js.undefined<string>) => promise<unit> = "toThrow"
  @inline
  let toThrow = (~message=?, expected) => expected->toThrow(message->Js.Undefined.fromOption)

  @send
  external toThrowError: (assertion<'a>, Js.undefined<string>) => promise<unit> = "toThrowError"
  @inline
  let toThrowError = (~message=?, expected) =>
    expected->toThrowError(message->Js.Undefined.fromOption)
}

