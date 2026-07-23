@@uncurried

open Vitest

@val external nextTick: (unit => unit) => unit = "process.nextTick"

describe("Vi", () => {
  beforeEach(() => {
    let _ = Vi.useRealTimers()
  })

  afterAll(() => {
    let _ = Vi.useRealTimers()
  })

  let _promise = () => Promise.resolve()

  itAsync("should compile fake timers correctly", async t => {
    let _ = Vi.useFakeTimers()
    t->expect(Vi.isFakeTimers())->Expect.toBe(true)

    let called = ref(false)
    let called2 = ref(false)

    let _ = setTimeout(() => called := true, 100)
    let _ = setTimeout(() => called2 := true, 200)
    let _ = Vi.advanceTimersByTime(10)
    t->expect(called)->Expect.toEqual({contents: false})
    t->expect(called2)->Expect.toEqual({contents: false})

    let _ = Vi.advanceTimersByTime(100)
    t->expect(called)->Expect.toEqual({contents: true})
    t->expect(called2)->Expect.toEqual({contents: false})
    called := false

    let _ = await Vi.advanceTimersByTimeAsync(1000)
    t->expect(called2)->Expect.toEqual({contents: true})
    called2 := false
    t->expect(Vi.getTimerCount())->Expect.toBe(0)

    let _ = setTimeout(() => called := true, 1000)
    let _ = setTimeout(() => called2 := true, 2000)
    t->expect(Vi.getTimerCount())->Expect.toBe(2)
    let _ = Vi.runAllTimers()
    t->expect(called)->Expect.toEqual({contents: true})
    t->expect(called2)->Expect.toEqual({contents: true})
    called := false
    called2 := false

    let _ = setTimeout(() => called := true, 1000)
    let _ = setTimeout(() => called2 := true, 2000)
    t->expect(Vi.getTimerCount())->Expect.toBe(2)
    let _ = await Vi.runAllTimersAsync()
    t->expect(called)->Expect.toEqual({contents: true})
    t->expect(called2)->Expect.toEqual({contents: true})
    called := false
    called2 := false

    let _ = setTimeout(() => called := true, 1000)
    t->expect(Vi.getTimerCount())->Expect.toBe(1)
    let _ = Vi.runOnlyPendingTimers()
    t->expect(called)->Expect.toEqual({contents: true})
    called := false

    let _ = setTimeout(() => called := true, 1000)
    t->expect(Vi.getTimerCount())->Expect.toBe(1)
    let _ = await Vi.runOnlyPendingTimersAsync()
    t->expect(called)->Expect.toEqual({contents: true})
    called := false

    let _ = setTimeout(() => called := true, 1000)
    let _ = setTimeout(() => called2 := true, 2000)
    t->expect(Vi.getTimerCount())->Expect.toBe(2)
    let _ = Vi.advanceTimersToNextTimer()
    t->expect(called)->Expect.toEqual({contents: true})
    t->expect(called2.contents)->Expect.toBe(false)

    let _ = await Vi.advanceTimersToNextTimerAsync()
    t->expect(called2.contents)->Expect.toBe(true)

    let _ = setTimeout(() => called := true, 1000)
    t->expect(Vi.getTimerCount())->Expect.toBe(1)
    let _ = Vi.clearAllTimers()
    t->expect(Vi.getTimerCount())->Expect.toBe(0)

    nextTick(() => called := true)
    let _ = Vi.runAllTicks()
    t->expect(called)->Expect.toEqual({contents: true})
    called := false
  })

  itAsync("should compile waitFor correctly", async t => {
    let called = ref(false)
    let _ = setTimeout(() => called := true, 100)
    await Vi.waitFor(() => Assert.assert_(called.contents == true), ())
    t->expect(called)->Expect.toEqual({contents: true})

    let called = ref(false)
    let _ = setTimeout(() => called := true, 100)
    await Vi.waitFor(() => Assert.assert_(called.contents == true), ~timeout=200, ())
    t->expect(called)->Expect.toEqual({contents: true})

    let called = ref(false)
    let _ = setTimeout(() => called := true, 100)
    await Vi.waitFor(() => Assert.assert_(called.contents == true), ~interval=50, ())
    t->expect(called)->Expect.toEqual({contents: true})

    let called = ref(false)
    let _ = setTimeout(() => called := true, 100)
    await Vi.waitFor(() => Assert.assert_(called.contents == true), ~timeout=200, ~interval=50, ())
    t->expect(called)->Expect.toEqual({contents: true})

    let run = async () => {
      let called = ref(false)
      let _ = setTimeout(() => called := true, 100)
      await Vi.waitFor(() => Assert.assert_(called.contents == true), ~timeout=50, ())
      t->expect(called)->Expect.toEqual({contents: false})
    }

    await t
    ->expect(run())
    ->Expect.Promise.rejects
    ->Expect.Promise.toThrow
  })

  itAsync("should compile waitForAsync correctly", async t => {
    let _ = Vi.useFakeTimers()

    let sleep = ms => {
      Promise.make(
        (resolve, _reject) => {
          let _ = setTimeout(() => resolve(), ms)
        },
      )
    }

    await Vi.waitForAsync(() => sleep(1), ())
    await Vi.waitForAsync(() => sleep(20), ~timeout=100, ())
    await Vi.waitForAsync(() => sleep(50), ~interval=50, ())
    await Vi.waitForAsync(() => sleep(150), ~timeout=200, ~interval=50, ())

    let run = () => Vi.waitForAsync(() => sleep(100), ~timeout=50, ())

    await t
    ->expect(run())
    ->Expect.Promise.rejects
    ->Expect.Promise.toThrow
  })

  it("compile mocking system time correctly", t => {
    t->expect(Vi.getMockedSystemTime())->Expect.toBeNone

    let date = Date.makeWithYMD(~year=2021, ~month=1, ~day=1)
    let _ = Vi.setSystemTime(#Date(date))
    t->expect(Vi.getMockedSystemTime())->Expect.toBeSome(~some=Some(date))
    t->expect(Vi.getRealSystemTime())->Expect.Float.toBeGreaterThan(Date.getTime(date))

    t->expect(Vi.getRealSystemTime())->Expect.Float.toBeGreaterThanOrEqual(0.0)
    let _ = Vi.useRealTimers()
    t->expect(Vi.isFakeTimers())->Expect.toBe(false)
    t->expect(Vi.getMockedSystemTime())->Expect.toBeNone
  })
})
