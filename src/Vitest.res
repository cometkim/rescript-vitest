type vitest

type suite

@module("vitest") @val
external suite: suite = "expect"

@send external assertions: (suite, int) => unit = "assertions"

@send external hasAssertions: suite => unit = "hasAssertions"

/** Chai Assertion object */
type assertion<'a>

type expected<'a> = assertion<'a>

@module("vitest") external expect: 'a => assertion<'a> = "expect"

type reinforcement<'a, 'b> = (assertion<'a>, 'a => 'b) => assertion<'b>

%%private(
  external coerce_assertion: assertion<'a> => assertion<'b> = "%identity"

  let dangerously_reinforce_assertion: reinforcement<'a, 'b> = %raw(`
    function(assertion, cast) {
      let inner = assertion.__flags;
      inner.object = cast(inner.object);
      return assertion;
    }
  `)
)

type benchOptions = {
  time: option<int>,
  iterations: option<int>,
  warmupTime: option<int>,
  warmupIterations: option<int>,
}

module type Runner = {
  let describe: (string, unit => Js.undefined<unit>, Js.undefined<int>) => unit

  let test: (string, unit => Js.undefined<unit>, Js.undefined<int>) => unit
  let testAsync: (string, unit => promise<unit>, Js.undefined<int>) => unit

  let it: (string, unit => Js.undefined<unit>, Js.undefined<int>) => unit
  let itAsync: (string, unit => promise<unit>, Js.undefined<int>) => unit

  let bench: (string, unit => Js.undefined<unit>, Js.undefined<benchOptions>) => unit
  let benchAsync: (string, unit => promise<unit>, Js.undefined<benchOptions>) => unit
}

module type ConcurrentRunner = {
  let describe: (string, unit => Js.undefined<unit>, Js.undefined<int>) => unit

  let testAsync: (string, unit => promise<unit>, Js.undefined<int>) => unit

  let itAsync: (string, unit => promise<unit>, Js.undefined<int>) => unit
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
  let testAsync = (name, ~timeout=?, callback) =>
    Runner.testAsync(name, () => callback(suite), timeout->Js.Undefined.fromOption)

  @deprecated("use testAsync instead")
  let testPromise = testAsync

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
  let itAsync = (name, ~timeout=?, callback) =>
    Runner.itAsync(name, () => callback(suite), timeout->Js.Undefined.fromOption)

  @deprecated("use itAsync instead")
  let itPromise = itAsync

  @inline
  let bench = (name, ~time=?, ~iterations=?, ~warmupTime=?, ~warmupIterations=?, callback) =>
    Runner.bench(
      name,
      () => {
        callback(suite)
        Js.undefined
      },
      Some({time, iterations, warmupTime, warmupIterations})->Js.Undefined.fromOption,
    )

  @inline
  let benchAsync = (name, ~time=?, ~iterations=?, ~warmupTime=?, ~warmupIterations=?, callback) =>
    Runner.benchAsync(
      name,
      () => callback(suite),
      Some({time, iterations, warmupTime, warmupIterations})->Js.Undefined.fromOption,
    )

  @deprecated("use benchAsync instead")
  let benchPromise = benchAsync
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
  let testAsync = (name, ~timeout=?, callback) =>
    Runner.testAsync(name, () => callback(suite), timeout->Js.Undefined.fromOption)

  @deprecated("use testAsync instead")
  let test = testAsync

  @inline
  let itAsync = (name, ~timeout=?, callback) =>
    Runner.itAsync(name, () => callback(suite), timeout->Js.Undefined.fromOption)

  @deprecated("use itAsync instead")
  let it = itAsync
}

include MakeRunner({
  @module("vitest") @val
  external describe: (string, @uncurry (unit => Js.undefined<unit>), Js.undefined<int>) => unit =
    "describe"

  @module("vitest") @val
  external test: (string, @uncurry (unit => Js.undefined<unit>), Js.undefined<int>) => unit = "test"

  @module("vitest") @val
  external testAsync: (string, @uncurry (unit => promise<unit>), Js.undefined<int>) => unit = "test"

  @module("vitest") @val
  external it: (string, @uncurry (unit => Js.undefined<unit>), Js.undefined<int>) => unit = "it"

  @module("vitest") @val
  external itAsync: (string, @uncurry (unit => promise<unit>), Js.undefined<int>) => unit = "it"

  @module("vitest") @val
  external bench: (
    string,
    @uncurry (unit => Js.undefined<unit>),
    Js.undefined<benchOptions>,
  ) => unit = "bench"

  @module("vitest") @val
  external benchAsync: (
    string,
    @uncurry (unit => promise<unit>),
    Js.undefined<benchOptions>,
  ) => unit = "bench"
})

module Concurrent = {
  type concurrent_describe
  type concurrent_test
  type concurrent_it
  type concurrent_bench

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
  external testAsync: (
    concurrent_test,
    string,
    @uncurry (unit => promise<unit>),
    Js.undefined<int>,
  ) => unit = "concurrent"

  @send
  external itAsync: (
    concurrent_it,
    string,
    @uncurry (unit => promise<unit>),
    Js.undefined<int>,
  ) => unit = "concurrent"

  include MakeConcurrentRunner({
    let describe = describe(concurrent_describe)
    let testAsync = testAsync(concurrent_test)
    let itAsync = itAsync(concurrent_it)
  })
}

module Only = {
  type only_describe
  type only_test
  type only_it
  type only_bench

  %%private(
    @module("vitest") @val
    external only_describe: only_describe = "describe"

    @module("vitest") @val
    external only_test: only_test = "test"

    @module("vitest") @val
    external only_it: only_it = "it"

    @module("vitest") @val
    external only_bench: only_bench = "bench"
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
  external testAsync: (
    only_test,
    string,
    @uncurry (unit => promise<unit>),
    Js.undefined<int>,
  ) => unit = "only"

  @send
  external it: (only_it, string, @uncurry (unit => Js.undefined<unit>), Js.undefined<int>) => unit =
    "only"

  @send
  external itAsync: (only_it, string, @uncurry (unit => promise<unit>), Js.undefined<int>) => unit =
    "only"

  @send
  external bench: (
    only_bench,
    string,
    @uncurry (unit => Js.undefined<unit>),
    Js.undefined<benchOptions>,
  ) => unit = "only"

  @send
  external benchAsync: (
    only_bench,
    string,
    @uncurry (unit => promise<unit>),
    Js.undefined<benchOptions>,
  ) => unit = "only"

  include MakeRunner({
    let describe = describe(only_describe)

    let test = test(only_test)
    let testAsync = testAsync(only_test)

    let it = it(only_it)
    let itAsync = itAsync(only_it)

    let bench = bench(only_bench)
    let benchAsync = benchAsync(only_bench)
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
    external testAsync: (
      concurrent_test,
      string,
      @uncurry (unit => promise<unit>),
      Js.undefined<int>,
    ) => unit = "concurrent"

    @send
    external itAsync: (
      concurrent_it,
      string,
      @uncurry (unit => promise<unit>),
      Js.undefined<int>,
    ) => unit = "concurrent"

    include MakeConcurrentRunner({
      let describe = describe(only_describe->concurrent_describe)
      let testAsync = testAsync(only_test->concurrent_test)
      let itAsync = itAsync(only_it->concurrent_it)
    })
  }
}

module Skip = {
  type skip_describe
  type skip_test
  type skip_it
  type skip_bench

  %%private(
    @module("vitest") @val
    external skip_describe: skip_describe = "describe"

    @module("vitest") @val
    external skip_test: skip_test = "test"

    @module("vitest") @val
    external skip_it: skip_it = "it"

    @module("vitest") @val
    external skip_bench: skip_bench = "bench"
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
  external testAsync: (
    skip_test,
    string,
    @uncurry (unit => promise<unit>),
    Js.undefined<int>,
  ) => unit = "skip"

  @send
  external it: (skip_it, string, @uncurry (unit => Js.undefined<unit>), Js.undefined<int>) => unit =
    "skip"

  @send
  external itAsync: (skip_it, string, @uncurry (unit => promise<unit>), Js.undefined<int>) => unit =
    "skip"

  @send
  external bench: (
    skip_bench,
    string,
    @uncurry (unit => Js.undefined<unit>),
    Js.undefined<benchOptions>,
  ) => unit = "skip"

  @send
  external benchAsync: (
    skip_bench,
    string,
    @uncurry (unit => promise<unit>),
    Js.undefined<benchOptions>,
  ) => unit = "skip"

  include MakeRunner({
    let describe = describe(skip_describe)

    let test = test(skip_test)
    let testAsync = testAsync(skip_test)

    let it = it(skip_it)
    let itAsync = itAsync(skip_it)

    let bench = bench(skip_bench)
    let benchAsync = benchAsync(skip_bench)
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
    external testAsync: (
      concurrent_test,
      string,
      @uncurry (unit => promise<unit>),
      Js.undefined<int>,
    ) => unit = "concurrent"

    @send
    external itAsync: (
      concurrent_it,
      string,
      @uncurry (unit => promise<unit>),
      Js.undefined<int>,
    ) => unit = "concurrent"

    include MakeConcurrentRunner({
      let describe = describe(skip_describe->concurrent_describe)
      let testAsync = testAsync(skip_test->concurrent_test)
      let itAsync = itAsync(skip_it->concurrent_it)
    })
  }
}

module type EachType = {
  let test: (array<'a>, string, ~timeout: int=?, 'a => unit) => unit
  let test2: (array<('a, 'b)>, string, ~timeout: int=?, ('a, 'b) => unit) => unit
  let test3: (array<('a, 'b, 'c)>, string, ~timeout: int=?, ('a, 'b, 'c) => unit) => unit
  let test4: (array<('a, 'b, 'c, 'd)>, string, ~timeout: int=?, ('a, 'b, 'c, 'd) => unit) => unit
  let test5: (
    array<('a, 'b, 'c, 'd, 'e)>,
    string,
    ~timeout: int=?,
    ('a, 'b, 'c, 'd, 'e) => unit,
  ) => unit

  let testAsync: (array<'a>, string, ~timeout: int=?, 'a => promise<unit>) => unit
  let test2Async: (array<('a, 'b)>, string, ~timeout: int=?, ('a, 'b) => promise<unit>) => unit
  let test3Async: (
    array<('a, 'b, 'c)>,
    string,
    ~timeout: int=?,
    ('a, 'b, 'c) => promise<unit>,
  ) => unit
  let test4Async: (
    array<('a, 'b, 'c, 'd)>,
    string,
    ~timeout: int=?,
    ('a, 'b, 'c, 'd) => promise<unit>,
  ) => unit
  let test5Async: (
    array<('a, 'b, 'c, 'd, 'e)>,
    string,
    ~timeout: int=?,
    ('a, 'b, 'c, 'd, 'e) => promise<unit>,
  ) => unit

  let describe: (array<'a>, string, ~timeout: int=?, 'a => unit) => unit
  let describe2: (array<('a, 'b)>, string, ~timeout: int=?, ('a, 'b) => unit) => unit
  let describe3: (array<('a, 'b, 'c)>, string, ~timeout: int=?, ('a, 'b, 'c) => unit) => unit
  let describe4: (
    array<('a, 'b, 'c, 'd)>,
    string,
    ~timeout: int=?,
    ('a, 'b, 'c, 'd) => unit,
  ) => unit
  let describe5: (
    array<('a, 'b, 'c, 'd, 'e)>,
    string,
    ~timeout: int=?,
    ('a, 'b, 'c, 'd, 'e) => unit,
  ) => unit

  let describeAsync: (array<'a>, string, ~timeout: int=?, 'a => promise<unit>) => unit
  let describe2Async: (array<('a, 'b)>, string, ~timeout: int=?, ('a, 'b) => promise<unit>) => unit
  let describe3Async: (
    array<('a, 'b, 'c)>,
    string,
    ~timeout: int=?,
    ('a, 'b, 'c) => promise<unit>,
  ) => unit
  let describe4Async: (
    array<('a, 'b, 'c, 'd)>,
    string,
    ~timeout: int=?,
    ('a, 'b, 'c, 'd) => promise<unit>,
  ) => unit
  let describe5Async: (
    array<('a, 'b, 'c, 'd, 'e)>,
    string,
    ~timeout: int=?,
    ('a, 'b, 'c, 'd, 'e) => promise<unit>,
  ) => unit
}

module Each: EachType = {
  module Ext = {
    type test
    type describe

    @module("vitest") @val
    external test: test = "test"

    @module("vitest") @val
    external describe: describe = "describe"

    @send
    external testObj: (
      ~test: test,
      ~cases: array<'a>,
    ) => (. ~name: string, ~f: @uncurry 'a => unit, ~timeout: Js.undefined<int>) => unit = "each"

    @send
    external test2: (
      ~test: test,
      ~cases: array<('a, 'b)>,
    ) => (. ~name: string, ~f: @uncurry ('a, 'b) => unit, ~timeout: Js.undefined<int>) => unit =
      "each"

    @send
    external test3: (
      ~test: test,
      ~cases: array<('a, 'b, 'c)>,
    ) => (. ~name: string, ~f: @uncurry ('a, 'b, 'c) => unit, ~timeout: Js.undefined<int>) => unit =
      "each"

    @send
    external test4: (
      ~test: test,
      ~cases: array<('a, 'b, 'c, 'd)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b, 'c, 'd) => unit,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external test5: (
      ~test: test,
      ~cases: array<('a, 'b, 'c, 'd, 'e)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b, 'c, 'd, 'e) => unit,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external testObjAsync: (
      ~test: test,
      ~cases: array<'a>,
    ) => (. ~name: string, ~f: @uncurry 'a => promise<unit>, ~timeout: Js.undefined<int>) => unit =
      "each"

    @send
    external test2Async: (
      ~test: test,
      ~cases: array<('a, 'b)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b) => promise<unit>,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external test3Async: (
      ~test: test,
      ~cases: array<('a, 'b, 'c)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b, 'c) => promise<unit>,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external test4Async: (
      ~test: test,
      ~cases: array<('a, 'b, 'c, 'd)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b, 'c, 'd) => promise<unit>,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external test5Async: (
      ~test: test,
      ~cases: array<('a, 'b, 'c, 'd, 'e)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b, 'c, 'd, 'e) => promise<unit>,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external describeObj: (
      ~describe: describe,
      ~cases: array<'a>,
    ) => (. ~name: string, ~f: @uncurry 'a => unit, ~timeout: Js.undefined<int>) => unit = "each"

    @send
    external describe2: (
      ~describe: describe,
      ~cases: array<('a, 'b)>,
    ) => (. ~name: string, ~f: @uncurry ('a, 'b) => unit, ~timeout: Js.undefined<int>) => unit =
      "each"

    @send
    external describe3: (
      ~describe: describe,
      ~cases: array<('a, 'b, 'c)>,
    ) => (. ~name: string, ~f: @uncurry ('a, 'b, 'c) => unit, ~timeout: Js.undefined<int>) => unit =
      "each"

    @send
    external describe4: (
      ~describe: describe,
      ~cases: array<('a, 'b, 'c, 'd)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b, 'c, 'd) => unit,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external describe5: (
      ~describe: describe,
      ~cases: array<('a, 'b, 'c, 'd, 'e)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b, 'c, 'd, 'e) => unit,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external describeObjAsync: (
      ~describe: describe,
      ~cases: array<'a>,
    ) => (. ~name: string, ~f: @uncurry 'a => promise<unit>, ~timeout: Js.undefined<int>) => unit =
      "each"

    @send
    external describe2Async: (
      ~describe: describe,
      ~cases: array<('a, 'b)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b) => promise<unit>,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external describe3Async: (
      ~describe: describe,
      ~cases: array<('a, 'b, 'c)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b, 'c) => promise<unit>,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external describe4Async: (
      ~describe: describe,
      ~cases: array<('a, 'b, 'c, 'd)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b, 'c, 'd) => promise<unit>,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"

    @send
    external describe5Async: (
      ~describe: describe,
      ~cases: array<('a, 'b, 'c, 'd, 'e)>,
    ) => (
      . ~name: string,
      ~f: @uncurry ('a, 'b, 'c, 'd, 'e) => promise<unit>,
      ~timeout: Js.undefined<int>,
    ) => unit = "each"
  }

  @inline
  let test = (cases, name, ~timeout=?, f) =>
    Ext.testObj(~test=Ext.test, ~cases)(. ~name, ~f, ~timeout=timeout->Js.Undefined.fromOption)

  @inline
  let test2 = (cases, name, ~timeout=?, f) =>
    Ext.test2(~test=Ext.test, ~cases)(. ~name, ~f, ~timeout=timeout->Js.Undefined.fromOption)

  @inline
  let test3 = (cases, name, ~timeout=?, f) =>
    Ext.test3(~test=Ext.test, ~cases)(. ~name, ~f, ~timeout=timeout->Js.Undefined.fromOption)

  @inline
  let test4 = (cases, name, ~timeout=?, f) =>
    Ext.test4(~test=Ext.test, ~cases)(. ~name, ~f, ~timeout=timeout->Js.Undefined.fromOption)

  @inline
  let test5 = (cases, name, ~timeout=?, f) =>
    Ext.test5(~test=Ext.test, ~cases)(. ~name, ~f, ~timeout=timeout->Js.Undefined.fromOption)

  @inline
  let testAsync = (cases, name, ~timeout=?, f) =>
    Ext.testObjAsync(~test=Ext.test, ~cases)(. ~name, ~f, ~timeout=timeout->Js.Undefined.fromOption)

  @inline
  let test2Async = (cases, name, ~timeout=?, f) =>
    Ext.test2Async(~test=Ext.test, ~cases)(. ~name, ~f, ~timeout=timeout->Js.Undefined.fromOption)

  @inline
  let test3Async = (cases, name, ~timeout=?, f) =>
    Ext.test3Async(~test=Ext.test, ~cases)(. ~name, ~f, ~timeout=timeout->Js.Undefined.fromOption)

  @inline
  let test4Async = (cases, name, ~timeout=?, f) =>
    Ext.test4Async(~test=Ext.test, ~cases)(. ~name, ~f, ~timeout=timeout->Js.Undefined.fromOption)

  @inline
  let test5Async = (cases, name, ~timeout=?, f) =>
    Ext.test5Async(~test=Ext.test, ~cases)(. ~name, ~f, ~timeout=timeout->Js.Undefined.fromOption)

  @inline
  let describe = (cases, name, ~timeout=?, f) =>
    Ext.describeObj(~describe=Ext.describe, ~cases)(.
      ~name,
      ~f,
      ~timeout=timeout->Js.Undefined.fromOption,
    )

  @inline
  let describe2 = (cases, name, ~timeout=?, f) =>
    Ext.describe2(~describe=Ext.describe, ~cases)(.
      ~name,
      ~f,
      ~timeout=timeout->Js.Undefined.fromOption,
    )

  @inline
  let describe3 = (cases, name, ~timeout=?, f) =>
    Ext.describe3(~describe=Ext.describe, ~cases)(.
      ~name,
      ~f,
      ~timeout=timeout->Js.Undefined.fromOption,
    )

  @inline
  let describe4 = (cases, name, ~timeout=?, f) =>
    Ext.describe4(~describe=Ext.describe, ~cases)(.
      ~name,
      ~f,
      ~timeout=timeout->Js.Undefined.fromOption,
    )

  @inline
  let describe5 = (cases, name, ~timeout=?, f) =>
    Ext.describe5(~describe=Ext.describe, ~cases)(.
      ~name,
      ~f,
      ~timeout=timeout->Js.Undefined.fromOption,
    )

  @inline
  let describeAsync = (cases, name, ~timeout=?, f) =>
    Ext.describeObjAsync(~describe=Ext.describe, ~cases)(.
      ~name,
      ~f,
      ~timeout=timeout->Js.Undefined.fromOption,
    )

  @inline
  let describe2Async = (cases, name, ~timeout=?, f) =>
    Ext.describe2Async(~describe=Ext.describe, ~cases)(.
      ~name,
      ~f,
      ~timeout=timeout->Js.Undefined.fromOption,
    )

  @inline
  let describe3Async = (cases, name, ~timeout=?, f) =>
    Ext.describe3Async(~describe=Ext.describe, ~cases)(.
      ~name,
      ~f,
      ~timeout=timeout->Js.Undefined.fromOption,
    )

  @inline
  let describe4Async = (cases, name, ~timeout=?, f) =>
    Ext.describe4Async(~describe=Ext.describe, ~cases)(.
      ~name,
      ~f,
      ~timeout=timeout->Js.Undefined.fromOption,
    )

  @inline
  let describe5Async = (cases, name, ~timeout=?, f) =>
    Ext.describe5Async(~describe=Ext.describe, ~cases)(.
      ~name,
      ~f,
      ~timeout=timeout->Js.Undefined.fromOption,
    )
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
external beforeEachPromise: (@uncurry (unit => promise<'a>), Js.Undefined.t<int>) => unit =
  "beforeEach"

@inline
let beforeEachPromise = (~timeout=?, callback) =>
  beforeEachPromise(callback, timeout->Js.Undefined.fromOption)

@module("vitest") external beforeAll: (@uncurry (unit => unit)) => unit = "beforeAll"

@module("vitest")
external beforeAllPromise: (@uncurry (unit => promise<'a>), Js.Undefined.t<int>) => unit =
  "beforeAll"

@inline
let beforeAllPromise = (~timeout=?, callback) =>
  beforeAllPromise(callback, timeout->Js.Undefined.fromOption)

@module("vitest") external afterEach: (@uncurry (unit => unit)) => unit = "afterEach"

@module("vitest")
external afterEachPromise: (@uncurry (unit => promise<'a>), Js.Undefined.t<int>) => unit =
  "afterEach"

@inline
let afterEachPromise = (~timeout=?, callback) =>
  afterEachPromise(callback, timeout->Js.Undefined.fromOption)

@module("vitest")
external afterAll: (@uncurry (unit => 'a), Js.Undefined.t<int>) => unit = "afterAll"

let afterAll = (~timeout=?, callback) => afterAll(callback, timeout->Js.Undefined.fromOption)

@module("vitest")
external afterAllPromise: (@uncurry (unit => promise<'a>), Js.Undefined.t<int>) => unit = "afterAll"

@inline
let afterAllPromise = (~timeout=?, callback) =>
  afterAllPromise(callback, timeout->Js.Undefined.fromOption)

module Matchers = (
  Config: {
    type return<'a>
    let emptyReturn: return<'a>
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
  let toBeSome = (~some=?, expected: expected<option<'a>>) => {
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
    @send external toContain: (expected<array<'a>>, 'a) => Config.return<'a> = "toContain"

    @send external toContainEqual: (expected<array<'a>>, 'a) => Config.return<'a> = "toContainEqual"

    @send external toHaveLength: (expected<array<'a>>, int) => Config.return<'a> = "toHaveLength"

    @send external toMatch: (expected<array<'a>>, array<'a>) => Config.return<'a> = "toMatchObject"
  }

  module List = {
    @inline
    let toContain = (expected, item) => {
      expected->dangerously_reinforce_assertion(Belt.List.toArray)->Array.toContain(item)
    }

    @inline
    let toContainEqual = (expected, item) => {
      expected->dangerously_reinforce_assertion(Belt.List.toArray)->Array.toContainEqual(item)
    }

    @inline
    let toHaveLength = (expected, length) => {
      expected->dangerously_reinforce_assertion(Belt.List.toArray)->Array.toHaveLength(length)
    }

    @inline
    let toMatch = (expected, list) => {
      expected
      ->dangerously_reinforce_assertion(Belt.List.toArray)
      ->Array.toMatch(list->Belt.List.toArray)
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
    @get external rejects: expected<promise<'a>> => expected<'a> = "rejects"
    @get external resolves: expected<promise<'a>> => expected<'a> = "resolves"

    include Matchers({
      type return<'a> = promise<unit>
      let emptyReturn = Js.Promise2.resolve()
    })

    @send
    external toThrow: (expected<'a>, Js.undefined<string>) => promise<unit> = "toThrow"
    @inline
    let toThrow = (~message=?, expected) => expected->toThrow(message->Js.Undefined.fromOption)

    @send
    external toThrowError: (expected<'a>, Js.undefined<string>) => promise<unit> = "toThrowError"
    @inline
    let toThrowError = (~message=?, expected) =>
      expected->toThrowError(message->Js.Undefined.fromOption)
  }
}

module Assert = {
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
  let deepEqual = (~message=?, a, b) =>
    assert_obj->deepEqual(a, b, message->Js.Undefined.fromOption)
}

module Vi = {
  type t

  %%private(@module("vitest") @val external vi_obj: t = "vi")

  @send external advanceTimersByTime: (t, int) => t = "advanceTimersByTime"
  @inline let advanceTimersByTime = ms => vi_obj->advanceTimersByTime(ms)

  @send external advanceTimersByTimeAsync: (t, int) => promise<t> = "advanceTimersByTimeAsync"
  let advanceTimersByTimeAsync = time => vi_obj->advanceTimersByTimeAsync(time)

  @send external advanceTimersToNextTimer: t => t = "advanceTimersToNextTimer"
  @inline let advanceTimersToNextTimer = () => vi_obj->advanceTimersToNextTimer

  @send external advanceTimersToNextTimerAsync: t => promise<t> = "advanceTimersToNextTimerAsync"
  let advanceTimersToNextTimerAsync = () => vi_obj->advanceTimersToNextTimerAsync

  @send external getTimerCount: t => int = "getTimerCount"
  let getTimerCount = () => vi_obj->getTimerCount

  @send external clearAllTimers: t => t = "clearAllTimers"
  let clearAllTimers = () => vi_obj->clearAllTimers

  @send external runAllTicks: t => t = "runAllTicks"
  let runAllTicks = () => vi_obj->runAllTicks

  @send external runAllTimers: t => t = "runAllTimers"
  @inline let runAllTimers = () => vi_obj->runAllTimers

  @send external runAllTimersAsync: t => promise<t> = "runAllTimersAsync"
  let runAllTimersAsync = () => vi_obj->runAllTimersAsync

  @send external runOnlyPendingTimers: t => t = "runOnlyPendingTimers"
  @inline let runOnlyPendingTimers = () => vi_obj->runOnlyPendingTimers

  @send external runOnlyPendingTimersAsync: t => promise<t> = "runOnlyPendingTimersAsync"
  let runOnlyPendingTimersAsync = () => vi_obj->runOnlyPendingTimersAsync

  @send
  external setSystemTime: (t, @unwrap [#Date(Js.Date.t) | #String(string) | #Int(int)]) => t =
    "setSystemTime"
  let setSystemTime = time => vi_obj->setSystemTime(time)

  /**
   https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/types/sinonjs__fake-timers/index.d.ts
   */
  type fakeTimersConfig = {
    now?: Js.Date.t, // or int
    toFake?: array<string>,
    loopLimit?: int,
    shouldAdvanceTime?: bool,
    advanceTimeDelta?: int,
    shouldClearNativeTimers?: bool,
  }

  @send external useFakeTimers: (t, ~config: fakeTimersConfig=?, unit) => t = "useFakeTimers"
  @inline let useFakeTimers = (~config=?, ()) => vi_obj->useFakeTimers(~config?, ())

  @send external useRealTimers: t => t = "useRealTimers"
  @inline let useRealTimers = () => vi_obj->useRealTimers

  @send external isFakeTimers: t => bool = "isFakeTimers"
  let isFakeTimers = () => vi_obj->isFakeTimers

  @send @return(nullable)
  external getMockedSystemTime: t => option<Js.Date.t> = "getMockedSystemTime"
  let getMockedSystemTime = () => vi_obj->getMockedSystemTime

  @send external getRealSystemTime: t => float = "getRealSystemTime"
  let getRealSystemTime = () => vi_obj->getRealSystemTime

  type waitForOptions = {
    timeout?: int,
    interval?: int,
  }

  @send external waitFor: (t, @uncurry unit => 'a, waitForOptions) => promise<'a> = "waitFor"

  /**
  @since(vitest >= 0.34.5)
   */
  let waitFor = (callback, ~timeout=?, ~interval=?, ()) => {
    waitFor(vi_obj, callback, {?timeout, ?interval})
  }

  @send
  external waitForAsync: (t, @uncurry unit => promise<'a>, waitForOptions) => promise<'a> = "waitFor"

  /**
  @since(vitest >= 0.34.5)
   */
  let waitForAsync = (callback, ~timeout=?, ~interval=?, ()) => {
    waitForAsync(vi_obj, callback, {?timeout, ?interval})
  }

  type waitUntilOptions = {
    timeout?: int,
    interval?: int,
  }

  @send
  external waitUntil: (t, @uncurry unit => 'a, waitUntilOptions) => promise<'a> = "waitUntil"

  /**
  @since(vitest >= 0.34.5)
   */
  let waitUntil = (callback, ~timeout=?, ~interval=?, ()) => {
    waitUntil(vi_obj, callback, {?timeout, ?interval})
  }

  @send
  external waitUntilAsync: (t, @uncurry unit => promise<'a>, waitUntilOptions) => promise<'a> =
    "waitUntil"

  /**
  @since(vitest >= 0.34.5)
   */
  let waitUntilAsync = (callback, ~timeout=?, ~interval=?, ()) => {
    waitUntilAsync(vi_obj, callback, {?timeout, ?interval})
  }

  // binding this using vi_obj causes a runtime error. this is because vitest sees this inside this file, then tries to evaluate the hoisted function, but the hoisted function is not provided yet, it's just a parameter to the function
  @send external hoisted: (t, @uncurry unit => 'a) => 'a = "hoisted"
}

@scope("import.meta") @val
external inSource: bool = "vitest"

module InSource = {
  // Note:
  // If it goes out of module scope, `import.meta.vitest` will not be bound.
  // Therefore, `MakeRunner` cannot be reused here.

  @scope("import.meta.vitest") @val
  external describe: (string, @uncurry (unit => unit)) => unit = "describe"

  @scope("import.meta.vitest") @val
  external test: (string, @uncurry (unit => unit)) => unit = "test"

  @scope("import.meta.vitest") @val
  external testAsync: (string, @uncurry (unit => promise<unit>)) => unit = "test"

  @scope("import.meta.vitest") @val
  external it: (string, @uncurry (unit => unit)) => unit = "it"

  @scope("import.meta.vitest") @val
  external itAsync: (string, @uncurry (unit => promise<unit>)) => unit = "it"

  @scope("import.meta.vitest") @val
  external bench: (string, @uncurry (unit => unit)) => unit = "it"

  @scope("import.meta.vitest") @val
  external benchAsync: (string, @uncurry (unit => promise<unit>)) => unit = "it"
}
