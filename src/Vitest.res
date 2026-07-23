open Vitest_Types

type suiteOptions = {
  timeout?: int,
  retry?: int,
  repeats?: int,
  shuffle?: bool,
  concurrent?: bool,
  sequential?: bool,
  skip?: bool,
  only?: bool,
  todo?: bool,
  fails?: bool,
}

type testOptions = {
  timeout?: int,
  retry?: int,
  repeats?: int,
  concurrent?: bool,
  sequential?: bool,
  skip?: bool,
  only?: bool,
  todo?: bool,
  fails?: bool,
}

type testCollectorOptions = {
  timeout?: int,
  retry?: int,
  repeats?: int,
  concurrent?: bool,
  sequential?: bool,
  skip?: bool,
  only?: bool,
  todo?: bool,
  fails?: bool,
}

type suiteDef = (string, suiteOptions, unit => unit) => unit
type testDef = (string, testOptions, testCtx => unit) => unit
type testAsyncDef = (string, testOptions, testCtx => promise<unit>) => unit

module type Runner = {
  let describe: suiteDef
  let test: testDef
  let testAsync: testAsyncDef
  let it: testDef
  let itAsync: testAsyncDef
}

module type ConcurrentRunner = {
  let describe: suiteDef
  let testAsync: testAsyncDef
  let itAsync: testAsyncDef
}

module MakeRunner = (Runner: Runner) => {
  @inline
  let describe = (
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~shuffle=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    callback,
  ) =>
    Runner.describe(
      name,
      {
        ?timeout,
        ?retry,
        ?repeats,
        ?shuffle,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      callback,
    )

  @inline
  let test = (
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    callback,
  ) =>
    Runner.test(
      name,
      {
        ?timeout,
        ?retry,
        ?repeats,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      callback,
    )

  @inline
  let testAsync = (
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    callback,
  ) =>
    Runner.testAsync(
      name,
      {
        ?timeout,
        ?retry,
        ?repeats,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      callback,
    )

  @inline
  let it = (
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    callback,
  ) =>
    Runner.it(
      name,
      {
        ?timeout,
        ?retry,
        ?repeats,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      callback,
    )

  @inline
  let itAsync = (
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    callback,
  ) =>
    Runner.itAsync(
      name,
      {
        ?timeout,
        ?retry,
        ?repeats,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      callback,
    )
}

module MakeConcurrentRunner = (Runner: ConcurrentRunner) => {
  @inline
  let describe = (
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~shuffle=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    callback,
  ) =>
    Runner.describe(
      name,
      {
        ?timeout,
        ?retry,
        ?repeats,
        ?shuffle,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      callback,
    )

  @inline
  let testAsync = (
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    callback,
  ) =>
    Runner.testAsync(
      name,
      {
        ?timeout,
        ?retry,
        ?repeats,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      callback,
    )

  @inline
  let itAsync = (
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    callback,
  ) =>
    Runner.itAsync(
      name,
      {
        ?timeout,
        ?retry,
        ?repeats,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      callback,
    )
}

include MakeRunner({
  @module("vitest") @val
  external describe: suiteDef = "describe"

  @module("vitest") @val
  external test: testDef = "test"

  @module("vitest") @val
  external testAsync: testAsyncDef = "test"

  @module("vitest") @val
  external it: testDef = "it"

  @module("vitest") @val
  external itAsync: testAsyncDef = "it"
})

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

module type ForType = {
  let describe: (
    array<'a>,
    string,
    ~timeout: int=?,
    ~retry: int=?,
    ~repeats: int=?,
    ~concurrent: bool=?,
    ~sequential: bool=?,
    ~skip: bool=?,
    ~only: bool=?,
    ~todo: bool=?,
    ~fails: bool=?,
    'a => unit,
  ) => unit
  let describeAsync: (
    array<'a>,
    string,
    ~timeout: int=?,
    ~retry: int=?,
    ~repeats: int=?,
    ~concurrent: bool=?,
    ~sequential: bool=?,
    ~skip: bool=?,
    ~only: bool=?,
    ~todo: bool=?,
    ~fails: bool=?,
    'a => promise<unit>,
  ) => unit

  let test: (
    array<'a>,
    string,
    ~timeout: int=?,
    ~retry: int=?,
    ~repeats: int=?,
    ~concurrent: bool=?,
    ~sequential: bool=?,
    ~skip: bool=?,
    ~only: bool=?,
    ~todo: bool=?,
    ~fails: bool=?,
    ('a, testCtx) => unit,
  ) => unit
  let testAsync: (
    array<'a>,
    string,
    ~timeout: int=?,
    ~retry: int=?,
    ~repeats: int=?,
    ~concurrent: bool=?,
    ~sequential: bool=?,
    ~skip: bool=?,
    ~only: bool=?,
    ~todo: bool=?,
    ~fails: bool=?,
    ('a, testCtx) => promise<unit>,
  ) => unit

  let it: (
    array<'a>,
    string,
    ~timeout: int=?,
    ~retry: int=?,
    ~repeats: int=?,
    ~concurrent: bool=?,
    ~sequential: bool=?,
    ~skip: bool=?,
    ~only: bool=?,
    ~todo: bool=?,
    ~fails: bool=?,
    ('a, testCtx) => unit,
  ) => unit
  let itAsync: (
    array<'a>,
    string,
    ~timeout: int=?,
    ~retry: int=?,
    ~repeats: int=?,
    ~concurrent: bool=?,
    ~sequential: bool=?,
    ~skip: bool=?,
    ~only: bool=?,
    ~todo: bool=?,
    ~fails: bool=?,
    ('a, testCtx) => promise<unit>,
  ) => unit
}

module For: ForType = {
  module Ext = {
    type describe
    type test
    type it

    @module("vitest") @val
    external describe: describe = "describe"

    @module("vitest") @val
    external test: test = "test"

    @module("vitest") @val
    external it: it = "it"

    @send
    external describeObj: (
      ~describe: describe,
      ~cases: array<'a>,
    ) => (~name: string, ~options: testCollectorOptions, ~f: @uncurry ('a => unit)) => unit = "for"

    @send
    external describeObjAsync: (
      ~describe: describe,
      ~cases: array<'a>,
    ) => (
      ~name: string,
      ~options: testCollectorOptions,
      ~f: @uncurry ('a => promise<unit>),
    ) => unit = "for"

    @send
    external testObj: (
      ~test: test,
      ~cases: array<'a>,
    ) => (
      ~name: string,
      ~options: testCollectorOptions,
      ~f: @uncurry ('a, testCtx) => unit,
    ) => unit = "for"

    @send
    external testObjAsync: (
      ~test: test,
      ~cases: array<'a>,
    ) => (
      ~name: string,
      ~options: testCollectorOptions,
      ~f: @uncurry ('a, testCtx) => promise<unit>,
    ) => unit = "for"

    @send
    external itObj: (
      ~it: it,
      ~cases: array<'a>,
    ) => (
      ~name: string,
      ~options: testCollectorOptions,
      ~f: @uncurry ('a, testCtx) => unit,
    ) => unit = "for"

    @send
    external itObjAsync: (
      ~it: it,
      ~cases: array<'a>,
    ) => (
      ~name: string,
      ~options: testCollectorOptions,
      ~f: @uncurry ('a, testCtx) => promise<unit>,
    ) => unit = "for"
  }

  @inline
  let describe = (
    cases,
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    f,
  ) =>
    Ext.describeObj(~describe=Ext.describe, ~cases)(
      ~name,
      ~options={
        ?timeout,
        ?retry,
        ?repeats,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      ~f,
    )

  @inline
  let describeAsync = (
    cases,
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    f,
  ) =>
    Ext.describeObjAsync(~describe=Ext.describe, ~cases)(
      ~name,
      ~options={
        ?timeout,
        ?retry,
        ?repeats,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      ~f,
    )

  @inline
  let test = (
    cases,
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    f,
  ) =>
    Ext.testObj(~test=Ext.test, ~cases)(
      ~name,
      ~options={
        ?timeout,
        ?retry,
        ?repeats,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      ~f,
    )

  @inline
  let testAsync = (
    cases,
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    f,
  ) =>
    Ext.testObjAsync(~test=Ext.test, ~cases)(
      ~name,
      ~options={
        ?timeout,
        ?retry,
        ?repeats,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      ~f,
    )

  @inline
  let it = (
    cases,
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    f,
  ) =>
    Ext.itObj(~it=Ext.it, ~cases)(
      ~name,
      ~options={
        ?timeout,
        ?retry,
        ?repeats,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      ~f,
    )

  @inline
  let itAsync = (
    cases,
    name,
    ~timeout=?,
    ~retry=?,
    ~repeats=?,
    ~concurrent=?,
    ~sequential=?,
    ~skip=?,
    ~only=?,
    ~todo=?,
    ~fails=?,
    f,
  ) =>
    Ext.itObjAsync(~it=Ext.it, ~cases)(
      ~name,
      ~options={
        ?timeout,
        ?retry,
        ?repeats,
        ?concurrent,
        ?sequential,
        ?skip,
        ?only,
        ?todo,
        ?fails,
      },
      ~f,
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

@module("vitest") @val external beforeEach: (unit => unit) => unit = "beforeEach"

@module("vitest") @val
external beforeEachAsync: (unit => promise<unit>, Js.Undefined.t<int>) => unit = "beforeEach"

@inline
let beforeEachAsync = (~timeout=?, callback) =>
  beforeEachAsync(callback, timeout->Js.Undefined.fromOption)

@module("vitest") external beforeAll: (unit => unit) => unit = "beforeAll"

@module("vitest")
external beforeAllAsync: (unit => promise<unit>, Js.Undefined.t<int>) => unit = "beforeAll"

@inline
let beforeAllAsync = (~timeout=?, callback) =>
  beforeAllAsync(callback, timeout->Js.Undefined.fromOption)

@module("vitest") external afterEach: (unit => unit) => unit = "afterEach"

@module("vitest")
external afterEachAsync: (unit => promise<unit>, Js.Undefined.t<int>) => unit = "afterEach"

@inline
let afterEachAsync = (~timeout=?, callback) =>
  afterEachAsync(callback, timeout->Js.Undefined.fromOption)

@module("vitest")
external afterAll: (unit => unit) => unit = "afterAll"

@module("vitest")
external afterAllAsync: (unit => promise<unit>, Js.Undefined.t<int>) => unit = "afterAll"

@inline
let afterAllAsync = (~timeout=?, callback) =>
  afterAllAsync(callback, timeout->Js.Undefined.fromOption)

module Expect = Vitest_Matchers

module Assert = Vitest_Assert

module Vi = Vitest_Helpers

module Bindings = Vitest_Bindings

@send
external expect: (testCtx, 'a) => expected<'a> = "expect"

@get
external inner: testCtx => testCtxExpect = "expect"

@send
external assertions: (testCtxExpect, int) => unit = "assertions"
@inline
let assertions = (testCtx, n) => testCtx->inner->assertions(n)

@send
external hasAssertion: testCtxExpect => unit = "hasAssertion"
@inline
let hasAssertion = testCtx => testCtx->inner->hasAssertion

@send external skip: (testCtx, ~note: string=?) => unit = "skip"

@send external skipIf: (testCtx, bool, ~note: string=?) => unit = "skip"
@inline
let skipIf = (testCtx, ~note=?, condition) => testCtx->skipIf(condition, ~note?)

@scope("import.meta") @val
external inSource: bool = "vitest"

module InSource = Vitest_Bindings.InSource

module Benchmark = Vitest_Benchmark
