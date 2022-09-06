type vitest

type suite

@module("vitest") @val
external suite: suite = "expect"

@send external assertions: (suite, int) => unit = "assertions"

@send external hasAssertions: suite => unit = "hasAssertions"

type expected<'a>

@module("vitest") external expect: 'a => expected<'a> = "expect"
external unwrap: expected<'a> => 'a = "%identity"

external wrap: 'a => expected<'a> = "%identity"

@module("vitest") @val
external describe: (string, @uncurry (unit => unit)) => unit = "describe"

@module("vitest") @val
external test: (string, @uncurry (unit => unit)) => unit = "test"

@module("vitest") @val
external testWithTimeout: (string, @uncurry (unit => unit), int) => unit = "test"

@module("vitest") @val
external testPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "test"

@module("vitest") @val
external testPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit = "test"

@module("vitest") @val
external it: (string, @uncurry (unit => unit)) => unit = "it"

@module("vitest") @val
external itWithTimeout: (string, @uncurry (unit => unit), int) => unit = "it"

@module("vitest") @val
external itPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "it"

@module("vitest") @val
external itPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit = "it"

module Concurrent = {
  @module("vitest") @scope("describe") @val
  external describe: (string, @uncurry (unit => unit)) => unit = "concurrent"

  @module("vitest") @scope("test") @val
  external test: (string, @uncurry (unit => unit)) => unit = "concurrent"

  @module("vitest") @scope("test") @val
  external testWithTimeout: (string, @uncurry (unit => unit), int) => unit = "concurrent"

  @module("vitest") @scope("test") @val
  external testPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "concurrent"

  @module("vitest") @scope("test") @val
  external testPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit =
    "concurrent"

  @module("vitest") @scope("it") @val
  external it: (string, @uncurry (unit => unit)) => unit = "concurrent"

  @module("vitest") @scope("it") @val
  external itWithTimeout: (string, @uncurry (unit => unit), int) => unit = "concurrent"

  @module("vitest") @scope("it") @val
  external itPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "concurrent"

  @module("vitest") @scope("it") @val
  external itPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit =
    "concurrent"
}

module Only = {
  @module("vitest") @scope("describe") @val
  external describe: (string, @uncurry (unit => unit)) => unit = "only"

  @module("vitest") @scope("test") @val
  external test: (string, @uncurry (unit => unit)) => unit = "only"

  @module("vitest") @scope("test") @val
  external testWithTimeout: (string, @uncurry (unit => unit), int) => unit = "only"

  @module("vitest") @scope("test") @val
  external testPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "only"

  @module("vitest") @scope("test") @val
  external testPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit =
    "only"

  @module("vitest") @scope("it") @val
  external it: (string, @uncurry (unit => unit)) => unit = "only"

  @module("vitest") @scope("it") @val
  external itWithTimeout: (string, @uncurry (unit => unit), int) => unit = "only"

  @module("vitest") @scope("it") @val
  external itPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "only"

  @module("vitest") @scope("it") @val
  external itPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit = "only"

  module Concurrent = {
    @module("vitest") @scope("describe.only") @val
    external describe: (string, @uncurry (unit => unit)) => unit = "concurrent"

    @module("vitest") @scope("test.only") @val
    external test: (string, @uncurry (unit => unit)) => unit = "concurrent"

    @module("vitest") @scope("test.only") @val
    external testWithTimeout: (string, @uncurry (unit => unit), int) => unit = "concurrent"

    @module("vitest") @scope("test.only") @val
    external testPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "concurrent"

    @module("vitest") @scope("test.only") @val
    external testPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit =
      "concurrent"

    @module("vitest") @scope("it.only") @val
    external it: (string, @uncurry (unit => unit)) => unit = "concurrent"

    @module("vitest") @scope("it.only") @val
    external itWithTimeout: (string, @uncurry (unit => unit), int) => unit = "concurrent"

    @module("vitest") @scope("it.only") @val
    external itPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "concurrent"

    @module("vitest") @scope("it.only") @val
    external itPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit =
      "concurrent"
  }
}

module Skip = {
  @module("vitest") @scope("describe") @val
  external describe: (string, @uncurry (unit => unit)) => unit = "skip"

  @module("vitest") @scope("test") @val
  external test: (string, @uncurry (unit => unit)) => unit = "skip"

  @module("vitest") @scope("test") @val
  external testWithTimeout: (string, @uncurry (unit => unit), int) => unit = "skip"

  @module("vitest") @scope("test") @val
  external testPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "skip"

  @module("vitest") @scope("test") @val
  external testPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit =
    "skip"

  @module("vitest") @scope("it") @val
  external it: (string, @uncurry (unit => unit)) => unit = "skip"

  @module("vitest") @scope("it") @val
  external itWithTimeout: (string, @uncurry (unit => unit), int) => unit = "skip"

  @module("vitest") @scope("it") @val
  external itPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "skip"

  @module("vitest") @scope("it") @val
  external itPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit = "skip"

  module Concurrent = {
    @module("vitest") @scope("describe.skip") @val
    external describe: (string, @uncurry (unit => unit)) => unit = "concurrent"

    @module("vitest") @scope("test.skip") @val
    external test: (string, @uncurry (unit => unit)) => unit = "concurrent"

    @module("vitest") @scope("test.skip") @val
    external testWithTimeout: (string, @uncurry (unit => unit), int) => unit = "concurrent"

    @module("vitest") @scope("test.skip") @val
    external testPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "concurrent"

    @module("vitest") @scope("test.skip") @val
    external testPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit =
      "concurrent"

    @module("vitest") @scope("it.skip") @val
    external it: (string, @uncurry (unit => unit)) => unit = "concurrent"

    @module("vitest") @scope("it.skip") @val
    external itWithTimeout: (string, @uncurry (unit => unit), int) => unit = "concurrent"

    @module("vitest") @scope("it.skip") @val
    external itPromise: (string, @uncurry (unit => Promise.t<unit>)) => unit = "concurrent"

    @module("vitest") @scope("it.skip") @val
    external itPromiseWithTimeout: (string, @uncurry (unit => Promise.t<unit>), int) => unit =
      "concurrent"
  }
}

module Todo = {
  @module("vitest") @scope("describe") @val
  external describe: string => unit = "todo"

  @module("vitest") @scope("test") @val
  external test: string => unit = "todo"

  @module("vitest") @scope("it") @val
  external it: string => unit = "it"
}

@module("vitest") @val external beforeEach: (@uncurry (unit => unit)) => unit = "beforeEach"

@module("vitest") @val
external beforeEachPromise: (@uncurry (unit => Promise.t<'a>)) => unit = "beforeEach"

@module("vitest") @val
external beforeEachPromiseWithTimeout: (@uncurry (unit => Promise.t<'a>), int) => unit =
  "beforeEach"

@module("vitest") external beforeAll: (@uncurry (unit => unit)) => unit = "beforeAll"

@module("vitest")
external beforeAllPromise: (@uncurry (unit => Promise.t<'a>)) => unit = "beforeAll"

@module("vitest")
external beforeAllPromiseWithTimeout: (@uncurry (unit => Promise.t<'a>), int) => unit = "beforeAll"

@module("vitest") external afterEach: (@uncurry (unit => unit)) => unit = "afterEach"

@module("vitest")
external afterEachPromise: (@uncurry (unit => Promise.t<'a>)) => unit = "afterEach"

@module("vitest")
external afterEachPromiseWithTimeout: (@uncurry (unit => Promise.t<'a>), int) => unit = "afterEach"

@module("vitest")
external afterAllPromise: (@uncurry (unit => Promise.t<'a>)) => unit = "afterAll"

@module("vitest")
external afterAllPromiseWithTimeout: (@uncurry (unit => Promise.t<'a>), int) => unit = "afterAll"

module Expect = {
  @send external not: expected<'a> => expected<'a> = "not"

  @send external toBe: (expected<'a>, 'a) => unit = "toBe"

  @send external eq: (expected<'a>, 'a) => unit = "eq"

  @send external toBeDefined: expected<Js.undefined<'a>> => unit = "toBeDefined"

  @send external toBeUndefined: expected<Js.undefined<'a>> => unit = "toBeUndefined"

  @send external toBeTruthy: expected<'a> => unit = "toBeTruthy"

  @send external toBeFalsy: expected<'a> => unit = "toBeFalsy"

  @send external toBeNull: expected<Js.null<'a>> => unit = "toBeNull"

  // @send external toBeInstanceOf: (expected<'a>, ?) => unit = "toBeInstanceOf"

  @send external toEqual: (expected<'a>, 'a) => unit = "toEqual"

  @send external toStrictEqual: (expected<'a>, 'a) => unit = "toStrictEqual"

  @send external toContain: (expected<array<'a>>, 'a) => unit = "toContain"

  @send external toContainEqual: (expected<array<'a>>, 'a) => unit = "toContainEqual"

  @send external toMatchSnapshot: expected<'a> => unit = "toMatchSnapshot"

  @send external toThrowError: (expected<unit => 'a>, Js.undefined<string>) => unit = "toThrowError"
  @inline
  let toThrowError = (~message=?, expected) =>
    expected->toThrowError(message->Js.Undefined.fromOption)

  module Int = {
    type t = int
    type expected = expected<t>

    @send external toBeGreaterThan: (expected, t) => unit = "toBeGreaterThan"

    @send external toBeGreaterThanOrEqual: (expected, t) => unit = "toBeGreaterThanOrEqual"

    @send external toBeLessThan: (expected, t) => unit = "toBeLessThan"

    @send external toBeLessThanOrEqual: (expected, t) => unit = "toBeLessThanOrEqual"
  }

  module Float = {
    type t = float
    type expected = expected<t>

    @send external toBeNaN: expected => unit = "toBeNaN"

    @send
    external toBeClosedTo: (expected, t, int) => unit = "toBeClosedTo"

    @send
    external toBeGreaterThan: (expected, t) => unit = "toBeGreaterThan"

    @send
    external toBeGreaterThanOrEqual: (expected, t) => unit = "toBeGreaterThanOrEqual"

    @send
    external toBeLessThan: (expected, t) => unit = "toBeLessThan"

    @send
    external toBeLessThanOrEqual: (expected, t) => unit = "toBeLessThanOrEqual"
  }

  module String = {
    type t = string
    type expected = expected<t>

    @send external toContain: (expected, t) => unit = "toContain"

    @send external toHaveLength: (expected, int) => unit = "toHaveLength"

    @send external toMatch: (expected, Js.Re.t) => unit = "toMatch"
  }

  module Array = {
    @send external toContain: (expected<array<'a>>, 'a) => unit = "toContain"

    @send external toHaveLength: (expected<array<'a>>, int) => unit = "toHaveLength"

    @send external toMatch: (expected<array<'a>>, array<'a>) => unit = "toMatchObject"
  }

  module List = {
    @inline
    let toContain = (expected, item) => {
      expected->unwrap->Belt.List.toArray->wrap->Array.toContain(item)
    }

    @inline
    let toHaveLength = (expected, length) => {
      expected->unwrap->Belt.List.toArray->wrap->Array.toHaveLength(length)
    }

    @inline
    let toMatch = (expected, list) => {
      expected->unwrap->Belt.List.toArray->wrap->Array.toMatch(list->Belt.List.toArray)
    }
  }

  module Dict = {
    @send external toHaveProperty: (expected<Js.Dict.t<'a>>, string, 'a) => unit = "toHaveProperty"

    @send external toHaveKey: (expected<Js.Dict.t<'a>>, string) => unit = "toHaveProperty"

    @send external toMatch: (expected<Js.Dict.t<'a>>, Js.Dict.t<'a>) => unit = "toMatchObject"
  }
}

module Assert = {
  @module("vitest") @scope("assert") @val external equal: ('a, 'a) => unit = "equal"
  @module("vitest") @scope("assert") @val
  external equalWithMessage: ('a, 'a, string) => unit = "equal"

  @module("vitest") @scope("assert") @val external deepEqual: ('a, 'a) => unit = "deepEqual"
  @module("vitest") @scope("assert") @val
  external deepEqualWithMessage: ('a, 'a, string) => unit = "deepEqual"
}

module Vi = {
  @module("vitest") @scope("vi") @val
  external advanceTimersByTime: int => unit = "advanceTimersByTime"

  @module("vitest") @scope("vi") @val
  external advanceTimersToNextTimer: unit => unit = "advanceTimersToNextTimer"

  @module("vitest") @scope("vi") @val external runAllTimers: unit => unit = "runAllTimers"

  @module("vitest") @scope("vi") @val
  external runOnlyPendingTimers: unit => unit = "runOnlyPendingTimers"

  @module("vitest") @scope("vi") @val external useFakeTimers: unit => unit = "useFakeTimers"

  @module("vitest") @scope("vi") @val external useRealTimers: unit => unit = "useRealTimers"

  @module("vitest") @scope("vi") @val
  external mockCurrentDate: Js.Date.t => unit = "mockCurrentDate"

  @module("vitest") @scope("vi") @val
  external restoreCurrentDate: Js.Date.t => unit = "restoreCurrentDate"

  // TODO: This should probably actually be getMockedSystemTime.
  @module("vitest") @scope("vi") @val
  external getMockedDate: unit => Js.null<Js.Date.t> = "getMockedDate"
}
