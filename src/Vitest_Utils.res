type t

%%private(@module("vitest") @val external vi_obj: t = "vi")

@send external advanceTimersByTime: (t, int) => t = "advanceTimersByTime"
@inline let advanceTimersByTime = ms => vi_obj->advanceTimersByTime(ms)

@send external advanceTimersByTimeAsync: (t, int) => promise<t> = "advanceTimersByTimeAsync"
let advanceTimersByTimeAsync = time => vi_obj->advanceTimersByTimeAsync(time)

@send external advanceTimersToNextTimer: t => t = "advanceTimersToNextTimer"
@inline let advanceTimersToNextTimer = () => vi_obj->advanceTimersToNextTimer

@send external advanceTimersToNextTimerAsync: t => promise<t> = "advanceTimersToNextTimerAsync"
let advanceTimersToNextTimerAsync = () => vi_obj->advanceTimersToNextTimerAsync

@send external getTimerCount: t => int = "getTimerCount"
let getTimerCount = () => vi_obj->getTimerCount

@send external clearAllTimers: t => t = "clearAllTimers"
let clearAllTimers = () => vi_obj->clearAllTimers

@send external runAllTicks: t => t = "runAllTicks"
let runAllTicks = () => vi_obj->runAllTicks

@send external runAllTimers: t => t = "runAllTimers"
@inline let runAllTimers = () => vi_obj->runAllTimers

@send external runAllTimersAsync: t => promise<t> = "runAllTimersAsync"
let runAllTimersAsync = () => vi_obj->runAllTimersAsync

@send external runOnlyPendingTimers: t => t = "runOnlyPendingTimers"
@inline let runOnlyPendingTimers = () => vi_obj->runOnlyPendingTimers

@send external runOnlyPendingTimersAsync: t => promise<t> = "runOnlyPendingTimersAsync"
let runOnlyPendingTimersAsync = () => vi_obj->runOnlyPendingTimersAsync

@send
external setSystemTime: (t, @unwrap [#Date(Js.Date.t) | #String(string) | #Int(int)]) => t =
  "setSystemTime"
let setSystemTime = time => vi_obj->setSystemTime(time)

/**
  @see https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/types/sinonjs__fake-timers/index.d.ts
*/
type fakeTimersConfig = {
  now?: Js.Date.t, // or int
  toFake?: array<string>,
  loopLimit?: int,
  shouldAdvanceTime?: bool,
  advanceTimeDelta?: int,
  shouldClearNativeTimers?: bool,
}

@send external useFakeTimers: (t, ~config: fakeTimersConfig=?, unit) => t = "useFakeTimers"
@inline let useFakeTimers = (~config=?, ()) => vi_obj->useFakeTimers(~config?, ())

@send external useRealTimers: t => t = "useRealTimers"
@inline let useRealTimers = () => vi_obj->useRealTimers

@send external isFakeTimers: t => bool = "isFakeTimers"
let isFakeTimers = () => vi_obj->isFakeTimers

@send @return(nullable)
external getMockedSystemTime: t => option<Js.Date.t> = "getMockedSystemTime"
let getMockedSystemTime = () => vi_obj->getMockedSystemTime

@send external getRealSystemTime: t => float = "getRealSystemTime"
let getRealSystemTime = () => vi_obj->getRealSystemTime

type waitForOptions = {
  timeout?: int,
  interval?: int,
}

@send external waitFor: (t, @uncurry unit => 'a, waitForOptions) => promise<'a> = "waitFor"

/**
  @since(vitest >= 0.34.5)
*/
let waitFor = (callback, ~timeout=?, ~interval=?, ()) => {
  waitFor(vi_obj, callback, {?timeout, ?interval})
}

@send
external waitForAsync: (t, @uncurry unit => promise<'a>, waitForOptions) => promise<'a> = "waitFor"

/**
  @since(vitest >= 0.34.5)
*/
let waitForAsync = (callback, ~timeout=?, ~interval=?, ()) => {
  waitForAsync(vi_obj, callback, {?timeout, ?interval})
}

type waitUntilOptions = {
  timeout?: int,
  interval?: int,
}

@send
external waitUntil: (t, @uncurry unit => 'a, waitUntilOptions) => promise<'a> = "waitUntil"

/**
  @since(vitest >= 0.34.5)
*/
let waitUntil = (callback, ~timeout=?, ~interval=?, ()) => {
  waitUntil(vi_obj, callback, {?timeout, ?interval})
}

@send
external waitUntilAsync: (t, @uncurry unit => promise<'a>, waitUntilOptions) => promise<'a> =
  "waitUntil"

/**
  @since(vitest >= 0.34.5)
*/
let waitUntilAsync = (callback, ~timeout=?, ~interval=?, ()) => {
  waitUntilAsync(vi_obj, callback, {?timeout, ?interval})
}

// binding this using vi_obj causes a runtime error. this is because vitest sees this inside this file, then tries to evaluate the hoisted function, but the hoisted function is not provided yet, it's just a parameter to the function
@send external hoisted: (t, @uncurry unit => 'a) => 'a = "hoisted"
