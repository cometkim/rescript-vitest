# rescript-vitest

[![npm](https://img.shields.io/npm/v/rescript-vitest)](https://www.npmjs.com/package/rescript-vitest)
[![npm downloads](https://img.shields.io/npm/dm/rescript-vitest)](https://www.npmjs.com/package/rescript-vitest)
[![license](https://img.shields.io/github/license/cometkim/rescript-vitest)](#LICENSE)

[ReScript](https://rescript-lang.org) bindings to [Vitest](https://vitest.dev)

## Prerequisite

ReScript v10.1+ is required since v1.0.0. To use `Js.Promise2` and `async`/`await` for tests.

ReScript v11.x with the [uncurried mode](https://rescript-lang.org/blog/uncurried-mode) is supported since v2.x.

## Config

Configure with plain `vite.config.js`.

You can use [vite-plugin-rescript](https://github.com/jihchi/vite-plugin-rescript) to build ReScript automatically before the test.

## Usage

You can find examples on [tests](./tests)

### Basic

```res
open Vitest

describe("Hello, Vitest", () => {
  test("This is a test case", t => {
    // t is `expect` object for suite-wide assertions
    t->assertions(3)

    // Test using the `Expect` module
    t->expect(1 + 2)->Expect.toBe(3)

    // There are some nested modules for specific type
    t->expect([1, 2, 3])
    ->Expect.Array.toContain(2)

    t->expect("Hello, ReScript-Vitest!")
    ->Expect.String.toContain("ReScript")

  // You can specify timeout for a test suite
  }, ~timeout=2000)
})
```

### In-source testing (experimental)

Vitest support [in-source testing](https://vitest.dev/guide/in-source)

```res
// This if block can be removed from production code.
// You need to define `import.meta.vitest` to `undefined`
if Vitest.inSource {
  open Vitest.InSource

  test("In-source testing", t => {
    t->expect(1 + 2)->Expect.toBe(3)
  })
}
```

### Migration from 1.x

You need to bind test context `t` explicitly.

```diff
open Vitest

describe("Hello, Vitest", t => {
  test("This is a test case", t => {
-    assertions(3)
+    t->assertions(3)

-    expect(1 + 2)->Expect.toBe(3)
+    t->expect(1 + 2)->Expect.toBe(3)
  })
})
```

You can use simple flags for `skip`, `concurrent`, and `only`.

```res
Skip.test("This will be skipped", t => {
  // ...
})

// Use simple flags instead.
test(~skip=true, "This will be skipped", t => {
  // ...
})
```

Module bindings will be deprecated and removed in next major (v3)

## LICENCE

MIT
