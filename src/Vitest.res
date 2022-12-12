type vitest

type suite

@module("vitest") @val
external suite: suite = "expect"

@send external assertions: (suite, int) => unit = "assertions"

@send external hasAssertions: suite => unit = "hasAssertions"

type expected<'a>

@module("vitest") external expect: 'a => expected<'a> = "expect"

%%private(
  external cast_expeceted: expected<'a> => expected<'b> = "%identity"
  external unwrap: expected<'a> => 'a = "%identity"
  external wrap: 'a => expected<'a> = "%identity"
)

module type Runner = {
  let describe: (string, unit => Js.undefined<unit>, Js.undefined<int>) => unit
  let test: (string, unit => Js.undefined<unit>, Js.undefined<int>) => unit
  let testPromise: (string, unit => Js.Promise2.t<unit>, Js.undefined<int>) => unit
  let it: (string, unit => Js.undefined<unit>, Js.undefined<int>) => unit
  let itPromise: (string, unit => Js.Promise2.t<unit>, Js.undefined<int>) => unit
}

module type ConcurrentRunner = {
  let describe: (string, unit => Js.undefined<unit>, Js.undefined<int>) => unit
  let test: (string, unit => Js.Promise2.t<unit>, Js.undefined<int>) => unit
  let it: (string, unit => Js.Promise2.t<unit>, Js.undefined<int>) => unit
}

module MakeRunner = (Runner: Runner) => {
  @inline
  let describe = (name, ~timeout=?, callback) =>
    Runner.describe(
      name,
      () => {
        callback()
        Js.undefined
      },
      timeout->Js.Undefined.fromOption,
    )

  @inline
  let test = (name, ~timeout=?, callback) =>
    Runner.test(
      name,
      () => {
        callback(suite)
        Js.undefined
      },
      timeout->Js.Undefined.fromOption,
    )

  @inline
  let testPromise = (name, ~timeout=?, callback) =>
    Runner.testPromise(name, () => callback(suite), timeout->Js.Undefined.fromOption)

  @inline
  let it = (name, ~timeout=?, callback) =>
    Runner.it(
      name,
      () => {
        callback(suite)
        Js.undefined
      },
      timeout->Js.Undefined.fromOption,
    )

  @inline
  let itPromise = (name, ~timeout=?, callback) =>
    Runner.itPromise(name, () => callback(suite), timeout->Js.Undefined.fromOption)
}

module MakeConcurrentRunner = (Runner: ConcurrentRunner) => {
  @inline
  let describe = (name, ~timeout=?, callback) =>
    Runner.describe(
      name,
      () => {
        callback()
        Js.undefined
      },
      timeout->Js.Undefined.fromOption,
    )

  @inline
  let test = (name, ~timeout=?, callback) =>
    Runner.test(name, () => callback(suite), timeout->Js.Undefined.fromOption)

  @inline
  let it = (name, ~timeout=?, callback) =>
    Runner.it(name, () => callback(suite), timeout->Js.Undefined.fromOption)
}

include MakeRunner({
  @module("vitest") @val
  external describe: (string, @uncurry (unit => Js.undefined<unit>), Js.undefined<int>) => unit =
    "describe"

  @module("vitest") @val
  external test: (string, @uncurry (unit => Js.undefined<unit>), Js.undefined<int>) => unit = "test"

  @module("vitest") @val
  external testPromise: (
    string,
    @uncurry (unit => Js.Promise2.t<unit>),
    Js.undefined<int>,
  ) => unit = "test"

  @module("vitest") @val
  external it: (string, @uncurry (unit => Js.undefined<unit>), Js.undefined<int>) => unit = "it"

  @module("vitest") @val
  external itPromise: (string, @uncurry (unit => Js.Promise2.t<unit>), Js.undefined<int>) => unit =
    "it"
})

module Concurrent = {
  type concurrent_describe
  type concurrent_test
  type concurrent_it

  %%private(
    @module("vitest") @val
    external concurrent_describe: concurrent_describe = "describe"

    @module("vitest") @val
    external concurrent_test: concurrent_test = "test"

    @module("vitest") @val
    external concurrent_it: concurrent_it = "it"
  )

  @send
  external describe: (
    concurrent_describe,
    string,
    @uncurry (unit => Js.undefined<unit>),
    Js.undefined<int>,
  ) => unit = "concurrent"

  @send
  external test: (
    concurrent_test,
    string,
    @uncurry (unit => Js.Promise2.t<unit>),
    Js.undefined<int>,
  ) => unit = "concurrent"

  @send
  external it: (
    concurrent_it,
    string,
    @uncurry (unit => Js.Promise2.t<unit>),
    Js.undefined<int>,
  ) => unit = "concurrent"

  include MakeConcurrentRunner({
    let describe = concurrent_describe->describe
    let test = concurrent_test->test
    let it = concurrent_it->it
  })
}

module Only = {
  type only_describe
  type only_test
  type only_it

  %%private(
    @module("vitest") @val
    external only_describe: only_describe = "describe"

    @module("vitest") @val
    external only_test: only_test = "test"

    @module("vitest") @val
    external only_it: only_it = "it"
  )

  @send
  external describe: (
    only_describe,
    string,
    @uncurry (unit => Js.undefined<unit>),
    Js.undefined<int>,
  ) => unit = "only"

  @send
  external test: (
    only_test,
    string,
    @uncurry (unit => Js.undefined<unit>),
    Js.undefined<int>,
  ) => unit = "only"

  @send
  external testPromise: (
    only_test,
    string,
    @uncurry (unit => Js.Promise2.t<unit>),
    Js.undefined<int>,
  ) => unit = "only"

  @send
  external it: (only_it, string, @uncurry (unit => Js.undefined<unit>), Js.undefined<int>) => unit =
    "only"

  @send
  external itPromise: (
    only_it,
    string,
    @uncurry (unit => Js.Promise2.t<unit>),
    Js.undefined<int>,
  ) => unit = "only"

  include MakeRunner({
    let describe = only_describe->describe
    let test = only_test->test
    let testPromise = only_test->testPromise
    let it = only_it->it
    let itPromise = only_it->itPromise
  })

  module Concurrent = {
    type concurrent_describe
    type concurrent_test
    type concurrent_it

    %%private(
      @get
      external concurrent_describe: only_describe => concurrent_describe = "only"

      @get
      external concurrent_test: only_test => concurrent_test = "only"

      @get
      external concurrent_it: only_it => concurrent_it = "only"
    )

    @send
    external describe: (
      concurrent_describe,
      string,
      @uncurry (unit => Js.undefined<unit>),
      Js.undefined<int>,
    ) => unit = "concurrent"

    @send
    external test: (
      concurrent_test,
      string,
      @uncurry (unit => Js.Promise2.t<unit>),
      Js.undefined<int>,
    ) => unit = "concurrent"

    @send
    external it: (
      concurrent_it,
      string,
      @uncurry (unit => Js.Promise2.t<unit>),
      Js.undefined<int>,
    ) => unit = "concurrent"

    include MakeConcurrentRunner({
      let describe = only_describe->concurrent_describe->describe
      let test = only_test->concurrent_test->test
      let it = only_it->concurrent_it->it
    })
  }
}

module Skip = {
  type skip_describe
  type skip_test
  type skip_it

  %%private(
    @module("vitest") @val
    external skip_describe: skip_describe = "describe"

    @module("vitest") @val
    external skip_test: skip_test = "test"

    @module("vitest") @val
    external skip_it: skip_it = "it"
  )

  @send
  external describe: (
    skip_describe,
    string,
    @uncurry (unit => Js.undefined<unit>),
    Js.undefined<int>,
  ) => unit = "skip"

  @send
  external test: (
    skip_test,
    string,
    @uncurry (unit => Js.undefined<unit>),
    Js.undefined<int>,
  ) => unit = "skip"

  @send
  external testPromise: (
    skip_test,
    string,
    @uncurry (unit => Js.Promise2.t<unit>),
    Js.undefined<int>,
  ) => unit = "skip"

  @send
  external it: (skip_it, string, @uncurry (unit => Js.undefined<unit>), Js.undefined<int>) => unit =
    "skip"

  @send
  external itPromise: (
    skip_it,
    string,
    @uncurry (unit => Js.Promise2.t<unit>),
    Js.undefined<int>,
  ) => unit = "skip"

  include MakeRunner({
    let describe = skip_describe->describe
    let test = skip_test->test
    let testPromise = skip_test->testPromise
    let it = skip_it->it
    let itPromise = skip_it->itPromise
  })

  module Concurrent = {
    type concurrent_describe
    type concurrent_test
    type concurrent_it

    %%private(
      @get
      external concurrent_describe: skip_describe => concurrent_describe = "skip"

      @get
      external concurrent_test: skip_test => concurrent_test = "skip"

      @get
      external concurrent_it: skip_it => concurrent_it = "skip"
    )

    @send
    external describe: (
      concurrent_describe,
      string,
      @uncurry (unit => Js.undefined<unit>),
      Js.undefined<int>,
    ) => unit = "concurrent"

    @send
    external test: (
      concurrent_test,
      string,
      @uncurry (unit => Js.Promise2.t<unit>),
      Js.undefined<int>,
    ) => unit = "concurrent"

    @send
    external it: (
      concurrent_it,
      string,
      @uncurry (unit => Js.Promise2.t<unit>),
      Js.undefined<int>,
    ) => unit = "concurrent"

    include MakeConcurrentRunner({
      let describe = skip_describe->concurrent_describe->describe
      let test = skip_test->concurrent_test->test
      let it = skip_it->concurrent_it->it
    })
  }
}

module Todo = {
  type todo_describe
  type todo_test
  type todo_it

  %%private(
    @module("vitest") @val
    external todo_describe: todo_describe = "describe"

    @module("vitest") @val
    external todo_test: todo_test = "test"

    @module("vitest") @val
    external todo_it: todo_it = "it"
  )

  @send external describe: (todo_describe, string) => unit = "todo"
  @inline let describe = name => todo_describe->describe(name)

  @send external test: (todo_test, string) => unit = "todo"
  @inline let test = name => todo_test->test(name)

  @send external it: (todo_it, string) => unit = "todo"
  @inline let it = name => todo_it->it(name)
}

@module("vitest") @val external beforeEach: (@uncurry (unit => unit)) => unit = "beforeEach"

@module("vitest") @val
external beforeEachPromise: (@uncurry (unit => Js.Promise2.t<'a>), Js.Undefined.t<int>) => unit =
  "beforeEach"

@inline
let beforeEachPromise = (~timeout=?, callback) =>
  beforeEachPromise(callback, timeout->Js.Undefined.fromOption)

@module("vitest") external beforeAll: (@uncurry (unit => unit)) => unit = "beforeAll"

@module("vitest")
external beforeAllPromise: (@uncurry (unit => Js.Promise2.t<'a>), Js.Undefined.t<int>) => unit =
  "beforeAll"

@inline
let beforeAllPromise = (~timeout=?, callback) =>
  beforeAllPromise(callback, timeout->Js.Undefined.fromOption)

@module("vitest") external afterEach: (@uncurry (unit => unit)) => unit = "afterEach"

@module("vitest")
external afterEachPromise: (@uncurry (unit => Js.Promise2.t<'a>), Js.Undefined.t<int>) => unit =
  "afterEach"

@inline
let afterEachPromise = (~timeout=?, callback) =>
  afterEachPromise(callback, timeout->Js.Undefined.fromOption)

@module("vitest")
external afterAllPromise: (@uncurry (unit => Js.Promise2.t<'a>), Js.Undefined.t<int>) => unit =
  "afterAll"

@inline
let afterAllPromise = (~timeout=?, callback) =>
  afterAllPromise(callback, timeout->Js.Undefined.fromOption)

module Matchers = (
  Config: {
    type return<'a>
    let emptyReturn: return<'a>
  },
) => {
  @get external not: expected<'a> => expected<'a> = "not"

  @send external toBe: (expected<'a>, 'a) => Config.return<'a> = "toBe"

  @send external eq: (expected<'a>, 'a) => Config.return<'a> = "eq"

  @send external toBeDefined: expected<Js.undefined<'a>> => Config.return<'a> = "toBeDefined"

  @send external toBeUndefined: expected<Js.undefined<'a>> => Config.return<'a> = "toBeUndefined"

  @send external toBeTruthy: expected<'a> => Config.return<'a> = "toBeTruthy"

  @send external toBeFalsy: expected<'a> => Config.return<'a> = "toBeFalsy"

  @send external toBeNull: expected<Js.null<'a>> => Config.return<'a> = "toBeNull"

  // @send external toBeInstanceOf: (expected<'a>, ?) => Config.return<'a> = "toBeInstanceOf"

  @send external toEqual: (expected<'a>, 'a) => Config.return<'a> = "toEqual"

  @inline
  let toBeSome = (~some=?, expected: expected<option<'a>>) => {
    expected->cast_expeceted->not->toBeUndefined->ignore
    switch some {
    | Some(id) => expected->toEqual(id)
    | None => Config.emptyReturn
    }
  }

  @inline
  let toBeNone = (expected: expected<option<'a>>) => {
    expected->cast_expeceted->toBeUndefined
  }

  @send external toStrictEqual: (expected<'a>, 'a) => Config.return<'a> = "toStrictEqual"

  @send external toContain: (expected<array<'a>>, 'a) => Config.return<'a> = "toContain"

  @send external toContainEqual: (expected<array<'a>>, 'a) => Config.return<'a> = "toContainEqual"

  @send external toMatchSnapshot: expected<'a> => Config.return<'a> = "toMatchSnapshot"

  @send
  external toThrow: (expected<unit => 'a>, Js.undefined<string>) => Config.return<'a> = "toThrow"
  @inline
  let toThrow = (~message=?, expected) => expected->toThrow(message->Js.Undefined.fromOption)

  @send
  external toThrowError: (expected<unit => 'a>, Js.undefined<string>) => Config.return<'a> =
    "toThrowError"
  @inline
  let toThrowError = (~message=?, expected) =>
    expected->toThrowError(message->Js.Undefined.fromOption)

  module Int = {
    type t = int
    type expected = expected<t>

    @send external toBeGreaterThan: (expected, t) => Config.return<'a> = "toBeGreaterThan"

    @send
    external toBeGreaterThanOrEqual: (expected, t) => Config.return<'a> = "toBeGreaterThanOrEqual"

    @send external toBeLessThan: (expected, t) => Config.return<'a> = "toBeLessThan"

    @send external toBeLessThanOrEqual: (expected, t) => Config.return<'a> = "toBeLessThanOrEqual"
  }

  module Float = {
    type t = float
    type expected = expected<t>

    @send external toBeNaN: expected => Config.return<'a> = "toBeNaN"

    @send
    external toBeClosedTo: (expected, t, int) => Config.return<'a> = "toBeClosedTo"

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
    type expected = expected<t>

    @send external toContain: (expected, t) => Config.return<'a> = "toContain"

    @send external toHaveLength: (expected, int) => Config.return<'a> = "toHaveLength"

    @send external toMatch: (expected, Js.Re.t) => Config.return<'a> = "toMatch"
  }

  module Array = {
    @send external toContain: (expected<array<'a>>, 'a) => Config.return<'a> = "toContain"

    @send external toHaveLength: (expected<array<'a>>, int) => Config.return<'a> = "toHaveLength"

    @send external toMatch: (expected<array<'a>>, array<'a>) => Config.return<'a> = "toMatchObject"
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
    @send
    external toHaveProperty: (expected<Js.Dict.t<'a>>, string, 'a) => Config.return<'a> =
      "toHaveProperty"

    @send
    external toHaveKey: (expected<Js.Dict.t<'a>>, string) => Config.return<'a> = "toHaveProperty"

    @send
    external toMatch: (expected<Js.Dict.t<'a>>, Js.Dict.t<'a>) => Config.return<'a> =
      "toMatchObject"
  }
}

module Expect = {
  include Matchers({
    type return<'a> = unit
    let emptyReturn = ()
  })

  module Promise = {
    @get external rejects: expected<Js.Promise2.t<'a>> => expected<'a> = "rejects"
    @get external resolves: expected<Js.Promise2.t<'a>> => expected<'a> = "resolves"

    include Matchers({
      type return<'a> = Js.Promise2.t<unit>
      let emptyReturn = Js.Promise2.resolve()
    })
  }
}

module Assert = {
  type t

  %%private(@module("vitest") @val external assert_obj: t = "assert")

  @send external equal: (t, 'a, 'a, Js.undefined<string>) => unit = "equal"

  @inline
  let equal = (~message=?, a, b) => assert_obj->equal(a, b, message->Js.Undefined.fromOption)

  @send external deepEqual: (t, 'a, 'a, Js.undefined<string>) => unit = "deepEqual"

  @inline
  let deepEqual = (~message=?, a, b) =>
    assert_obj->deepEqual(a, b, message->Js.Undefined.fromOption)
}

module Vi = {
  type t

  %%private(@module("vitest") @val external vi_obj: t = "vi")

  @send external advanceTimersByTime: (t, int) => t = "advanceTimersByTime"
  @inline let advanceTimersByTime = ms => vi_obj->advanceTimersByTime(ms)

  @send external advanceTimersToNextTimer: t => t = "advanceTimersToNextTimer"
  @inline let advanceTimersToNextTimer = () => vi_obj->advanceTimersToNextTimer

  @send external runAllTimers: t => t = "runAllTimers"
  @inline let runAllTimers = () => vi_obj->runAllTimers

  @send external runOnlyPendingTimers: t => t = "runOnlyPendingTimers"
  @inline let runOnlyPendingTimers = () => vi_obj->runOnlyPendingTimers

  @send external useFakeTimers: t => t = "useFakeTimers"
  @inline let useFakeTimers = () => vi_obj->useFakeTimers

  @send external useRealTimers: t => t = "useRealTimers"
  @inline let useRealTimers = () => vi_obj->useRealTimers

  @send external mockCurrentDate: (t, Js.Date.t) => t = "mockCurrentDate"
  @inline let mockCurrentDate = date => vi_obj->mockCurrentDate(date)

  @send external restoreCurrentDate: (t, Js.Date.t) => t = "restoreCurrentDate"
  @inline let restoreCurrentDate = date => vi_obj->restoreCurrentDate(date)

  @send external getMockedDate: t => Js.null<Js.Date.t> = "getMockedDate"
  @inline let getMockedDate = () => vi_obj->getMockedDate->Js.Null.toOption
}
