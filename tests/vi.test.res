@@uncurried

open Vitest
open! Vitest.Module

@val external nextTick: (unit => unit) => unit = "process.nextTick"

describe("Vi", () => {
  beforeEach(() => {
    let _ = Vi.useRealTimers()
  })

  afterAll(() => {
    let _ = Vi.useRealTimers()
  })

  let _promise = () => Js.Promise2.resolve()

  itAsync("should compile fake timers correctly", async _t => {
    let _ = Vi.useFakeTimers()
    Vi.isFakeTimers()->expect->Expect.toBe(true)

    let called = ref(false)
    let called2 = ref(false)

    let _ = Js.Global.setTimeout(() => called := true, 100)
    let _ = Js.Global.setTimeout(() => called2 := true, 200)
    let _ = Vi.advanceTimersByTime(10)
    called->expect->Expect.toEqual({contents: false})
    called2->expect->Expect.toEqual({contents: false})

    let _ = Vi.advanceTimersByTime(100)
    called->expect->Expect.toEqual({contents: true})
    called2->expect->Expect.toEqual({contents: false})
    called := false

    let _ = await Vi.advanceTimersByTimeAsync(1000)
    called2->expect->Expect.toEqual({contents: true})
    called2 := false
    Vi.getTimerCount()->expect->Expect.toBe(0)

    let _ = Js.Global.setTimeout(() => called := true, 1000)
    let _ = Js.Global.setTimeout(() => called2 := true, 2000)
    Vi.getTimerCount()->expect->Expect.toBe(2)
    let _ = Vi.runAllTimers()
    called->expect->Expect.toEqual({contents: true})
    called2->expect->Expect.toEqual({contents: true})
    called := false
    called2 := false

    let _ = Js.Global.setTimeout(() => called := true, 1000)
    let _ = Js.Global.setTimeout(() => called2 := true, 2000)
    Vi.getTimerCount()->expect->Expect.toBe(2)
    let _ = await Vi.runAllTimersAsync()
    called->expect->Expect.toEqual({contents: true})
    called2->expect->Expect.toEqual({contents: true})
    called := false
    called2 := false

    let _ = Js.Global.setTimeout(() => called := true, 1000)
    Vi.getTimerCount()->expect->Expect.toBe(1)
    let _ = Vi.runOnlyPendingTimers()
    called->expect->Expect.toEqual({contents: true})
    called := false

    let _ = Js.Global.setTimeout(() => called := true, 1000)
    Vi.getTimerCount()->expect->Expect.toBe(1)
    let _ = await Vi.runOnlyPendingTimersAsync()
    called->expect->Expect.toEqual({contents: true})
    called := false

    let _ = Js.Global.setTimeout(() => called := true, 1000)
    let _ = Js.Global.setTimeout(() => called2 := true, 2000)
    Vi.getTimerCount()->expect->Expect.toBe(2)
    let _ = Vi.advanceTimersToNextTimer()
    called->expect->Expect.toEqual({contents: true})
    called2.contents->expect->Expect.toBe(false)

    let _ = await Vi.advanceTimersToNextTimerAsync()
    called2.contents->expect->Expect.toBe(true)

    let _ = Js.Global.setTimeout(() => called := true, 1000)
    Vi.getTimerCount()->expect->Expect.toBe(1)
    let _ = Vi.clearAllTimers()
    Vi.getTimerCount()->expect->Expect.toBe(0)

    nextTick(() => called := true)
    let _ = Vi.runAllTicks()
    called->expect->Expect.toEqual({contents: true})
    called := false
  })

  itAsync("should compile waitFor correctly", async _t => {
    let called = ref(false)
    let _ = Js.Global.setTimeout(() => called := true, 100)
    await Vi.waitFor(() => Assert.assert_(called.contents == true), ())
    called->expect->Expect.toEqual({contents: true})

    let called = ref(false)
    let _ = Js.Global.setTimeout(() => called := true, 100)
    await Vi.waitFor(() => Assert.assert_(called.contents == true), ~timeout=200, ())
    called->expect->Expect.toEqual({contents: true})

    let called = ref(false)
    let _ = Js.Global.setTimeout(() => called := true, 100)
    await Vi.waitFor(() => Assert.assert_(called.contents == true), ~interval=50, ())
    called->expect->Expect.toEqual({contents: true})

    let called = ref(false)
    let _ = Js.Global.setTimeout(() => called := true, 100)
    await Vi.waitFor(() => Assert.assert_(called.contents == true), ~timeout=200, ~interval=50, ())
    called->expect->Expect.toEqual({contents: true})

    let run = async () => {
      let called = ref(false)
      let _ = Js.Global.setTimeout(() => called := true, 100)
      await Vi.waitFor(() => Assert.assert_(called.contents == true), ~timeout=50, ())
      called->expect->Expect.toEqual({contents: false})
    }

    await run()
    ->expect
    ->Expect.Promise.rejects
    ->Expect.Promise.toThrow
  })

  itAsync("should compile waitForAsync correctly", async _t => {
    let _ = Vi.useFakeTimers()

    let sleep = ms => {
      Js.Promise2.make(
        (~resolve, ~reject as _) => {
          let _ = Js.Global.setTimeout(() => resolve(. ()), ms)
        },
      )
    }

    await Vi.waitForAsync(() => sleep(1), ())
    await Vi.waitForAsync(() => sleep(20), ~timeout=100, ())
    await Vi.waitForAsync(() => sleep(50), ~interval=50, ())
    await Vi.waitForAsync(() => sleep(150), ~timeout=200, ~interval=50, ())

    let run = () => Vi.waitForAsync(() => sleep(100), ~timeout=50, ())

    await run()
    ->expect
    ->Expect.Promise.rejects
    ->Expect.Promise.toThrow
  })

  it("compile mocking system time correctly", _t => {
    Vi.getMockedSystemTime()->expect->Expect.toBeNone

    let date = Js.Date.makeWithYMD(~year=2021., ~month=1., ~date=1., ())
    let _ = Vi.setSystemTime(#Date(date))
    Vi.getMockedSystemTime()->expect->Expect.toBeSome(~some=Some(date))
    Vi.getRealSystemTime()->expect->Expect.Float.toBeGreaterThan(Js.Date.getTime(date))

    Vi.getRealSystemTime()->expect->Expect.Float.toBeGreaterThanOrEqual(0.0)
    let _ = Vi.useRealTimers()
    Vi.isFakeTimers()->expect->Expect.toBe(false)
    Vi.getMockedSystemTime()->expect->Expect.toBeNone
  })
})
