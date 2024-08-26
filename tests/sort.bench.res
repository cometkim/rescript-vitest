open Js
open Vitest.Benchmark

describe("sort", () => {
  bench("normal", _ => {
    let x = [1, 5, 4, 2, 3]
    x
    ->Array2.sortInPlaceWith(
      (a, b) => {
        a - b
      },
    )
    ->ignore
  })

  bench("reverse", _ => {
    let x = [1, 5, 4, 2, 3]
    x
    ->Array2.reverseInPlace
    ->Array2.sortInPlaceWith(
      (a, b) => {
        a - b
      },
    )
    ->ignore
  })

  Todo.bench("todo")
})
