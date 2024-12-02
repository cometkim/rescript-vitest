open Vitest_Types

module BuiltIn = {
  @module("vitest") @val
  external testCtx: testCtx = "expect"

  @module("vitest")
  external expect: 'a => expected<'a> = "expect"

  let expect = x => testCtx->expect(x)
  let assertions = x => testCtx->assertions(x)
  let hasAssertion = () => testCtx->hasAssertion
}

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

  @scope("import.meta.vitest") @val
  external bench: (string, @uncurry unit => unit) => unit = "it"

  @scope("import.meta.vitest") @val
  external benchAsync: (string, @uncurry unit => promise<unit>) => unit = "it"

  @send
  external expect: (testCtx, 'a) => expected<'a> = "expect"

  module Expect = Vitest_Matchers
}
