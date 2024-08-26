// TODO: import rescript-tinybench

type bench

type suiteOptions = {
  skip?: bool,
  only?: bool,
  todo?: bool,
}

type benchOptions = {
  time?: int,
  iterations?: int,
  throws?: bool,
  warmupTime?: int,
  warmupIterations?: int,
}

type suiteDef = (string, suiteOptions, unit => unit) => unit
type benchDef = (string, bench => unit, benchOptions) => unit
type benchAsyncDef = (string, bench => promise<unit>, benchOptions) => unit

module type Runner = {
  let describe: suiteDef
  let bench: benchDef
  let benchAsync: benchAsyncDef
}

module MakeRunner = (Runner: Runner) => {
  @inline
  let describe = (name, ~skip=?, ~only=?, ~todo=?, callback) =>
    Runner.describe(
      name,
      {
        ?skip,
        ?only,
        ?todo,
      },
      callback,
    )

  @inline
  let bench = (
    name,
    ~time=?,
    ~iterations=?,
    ~throws=?,
    ~warmupTime=?,
    ~warmupIterations=?,
    callback,
  ) => Runner.bench(name, callback, {?time, ?iterations, ?throws, ?warmupTime, ?warmupIterations})

  @inline
  let benchAsync = (
    name,
    ~time=?,
    ~iterations=?,
    ~throws=?,
    ~warmupTime=?,
    ~warmupIterations=?,
    callback,
  ) =>
    Runner.benchAsync(name, callback, {?time, ?iterations, ?throws, ?warmupTime, ?warmupIterations})
}

include MakeRunner({
  @module("vitest") @val
  external describe: suiteDef = "describe"

  @module("vitest") @val
  external bench: benchDef = "bench"

  @module("vitest") @val
  external benchAsync: benchAsyncDef = "bench"
})

module Only = {
  type only_describe
  type only_bench

  %%private(
    @module("vitest") @val
    external only_describe: only_describe = "describe"

    @module("vitest") @val
    external only_bench: only_bench = "bench"
  )

  @get
  external describe: only_describe => suiteDef = "only"

  @get
  external bench: only_bench => benchDef = "only"

  @get
  external benchAsync: only_bench => benchAsyncDef = "only"

  include MakeRunner({
    let describe = only_describe->describe
    let bench = only_bench->bench
    let benchAsync = only_bench->benchAsync
  })
}

module Skip = {
  type skip_describe
  type skip_bench

  %%private(
    @module("vitest") @val
    external skip_describe: skip_describe = "describe"

    @module("vitest") @val
    external skip_bench: skip_bench = "bench"
  )

  @get
  external describe: skip_describe => suiteDef = "skip"

  @get
  external bench: skip_bench => benchDef = "skip"

  @get
  external benchAsync: skip_bench => benchAsyncDef = "skip"

  include MakeRunner({
    let describe = skip_describe->describe
    let bench = skip_bench->bench
    let benchAsync = skip_bench->benchAsync
  })
}

module Todo = {
  type todo_describe
  type todo_bench

  %%private(
    @module("vitest") @val
    external todo_describe: todo_describe = "describe"

    @module("vitest") @val
    external todo_bench: todo_bench = "bench"
  )

  @send
  external describe: (todo_describe, string) => unit = "todo"
  @inline
  let describe = name => todo_describe->describe(name)

  @send
  external bench: (todo_bench, string) => unit = "todo"
  @inline
  let bench = name => todo_bench->bench(name)

  @send
  external benchAsync: (todo_bench, string) => promise<unit> = "todo"
  @inline
  let benchAsync = name => todo_bench->benchAsync(name)
}
