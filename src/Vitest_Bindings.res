open Vitest_Types

module InSource = {
  @scope("import.meta.vitest") @val
  external describe: (string, @uncurry unit => unit) => unit = "describe"

  @scope("import.meta.vitest") @val
  external test: (string, @uncurry testCtx => unit) => unit = "test"

  @scope("import.meta.vitest") @val
  external testAsync: (string, @uncurry unit => promise<unit>) => unit = "test"

  @scope("import.meta.vitest") @val
  external it: (string, @uncurry unit => unit) => unit = "it"

  @scope("import.meta.vitest") @val
  external itAsync: (string, @uncurry unit => promise<unit>) => unit = "it"

  @send
  external expect: (testCtx, 'a) => expected<'a> = "expect"

  module Expect = Vitest_Matchers
}
