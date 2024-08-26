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

module type Runner = {
  let describe: (
    string,
    ~skip: bool=?,
    ~only: bool=?,
    ~todo: bool=?,
    unit => unit,
  ) => unit
  let bench: (
    string,
    ~time: int=?,
    ~iterations: int=?,
    ~throws: bool=?,
    ~warmupTime: int=?,
    ~warmupIterations: int=?,
    bench => unit,
  ) => unit
  let benchAsync: (
    string,
    ~time: int=?,
    ~iterations: int=?,
    ~throws: bool=?,
    ~warmupTime: int=?,
    ~warmupIterations: int=?,
    bench => promise<unit>,
  ) => unit
}

include Runner
module Only: Runner
module Skip: Runner

module Todo: {
  let describe: string => unit
  let bench: string => unit
  let benchAsync: string => unit
}
