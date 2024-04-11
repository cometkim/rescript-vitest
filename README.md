# rescript-vitest

[![npm](https://img.shields.io/npm/v/rescript-vitest)](https://www.npmjs.com/package/rescript-vitest)
[![npm downloads](https://img.shields.io/npm/dm/rescript-vitest)](https://www.npmjs.com/package/rescript-vitest)
[![license](https://img.shields.io/github/license/cometkim/rescript-vitest)](#LICENSE)

[ReScript](https://rescript-lang.org) bidnings to [Vitest](https://vitest.dev)

## Prerequisite

ReScript v10.1+ is required since v1.0.0. To use `Js.Promise2` and `async`/`await` for tests.

ReScript v11 can be used with `"uncurried": false`

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
    expect(1 + 2)->Expect.toBe(3)

    // There are some nested modules for specific type
    expect([1, 2, 3])
    ->Expect.Array.toContain(2)

    expect("Hello, ReScript-Vitest!")
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
  open Vitest
  open Vitest.InSource

  test("In-source testing", _ => {
    expect(1 + 2)->Expect.toBe(3)
  })
}
```

## LICENCE

MIT
