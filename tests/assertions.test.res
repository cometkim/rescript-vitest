open Vitest

describe("Assert", () => {
  test("assert_", _t => {
    Assert.assert_(true)
    Assert.assert_(1 == 1)
    Assert.assert_("one" == "one")
    Assert.assert_(1 == 1)
  })

  test("unreachable", t => {
    try {
      let _ = Js.Exn.raiseError("error")
      Assert.unreachable()
    } catch {
    | _ => Assert.assert_(~message="threw error", true)
    }

    try {
      t->expect(true)->Expect.toBe(true)
    } catch {
    | _ => Assert.unreachable()
    }
  })

  test("equal", _ctx => {
    Assert.equal(1, 1)
    Assert.equal(2., 2.)
    Assert.equal("one", "one")
    Assert.equal(true, true)
  })

  test("notEqual", _ctx => {
    Assert.notEqual(1, 2)
    Assert.notEqual(2., 3.)
    Assert.notEqual("one", "two")
    Assert.notEqual(true, false)
  })

  test("deepEqual", _ctx => {
    Assert.deepEqual({"foo": "bar"}, {"foo": "bar"})
    Assert.deepEqual([1, 2, 3], [1, 2, 3])
    Assert.deepEqual(Some(1), Some(1))
    Assert.deepEqual(None, None)
  })

  test("notDeepEqual", _ctx => {
    Assert.notDeepEqual({"foo": "bar"}, {"foo": "baz"})
    Assert.notDeepEqual([1, 2, 3], [4, 5, 6])
    Assert.notDeepEqual(Some(1), Some(2))
    Assert.notDeepEqual(Some(1), None)
  })

  test("strictEqual", _ctx => {
    Assert.strictEqual(1, 1)
    Assert.strictEqual(2., 2.)
    Assert.strictEqual("one", "one")
    Assert.strictEqual(true, true)
  })

  test("notStrictEqual", _ctx => {
    Assert.notStrictEqual(1, 2)
    Assert.notStrictEqual(2., 3.)
    Assert.notStrictEqual("one", "two")
    Assert.notStrictEqual(true, false)
  })

  test("deepStrictEqual", _ctx => {
    Assert.deepStrictEqual({"foo": "bar"}, {"foo": "bar"})
    Assert.deepStrictEqual([1, 2, 3], [1, 2, 3])
    Assert.deepStrictEqual(Some(1), Some(1))
    Assert.deepStrictEqual(None, None)
  })

  test("fail", _ctx => {
    try {
      Assert.fail(~message="This test should fail")
    } catch {
    | _ => Assert.assert_(~message="threw error", true)
    }
  })
})

describe("Expect", () => {
  test("toBe", t => {
    t->expect(1)->Expect.toBe(1)
    t->expect(2.)->Expect.toBe(2.)
    t->expect("one")->Expect.toBe("one")
    t->expect(true)->Expect.toBe(true)
  })

  test("not", t => {
    t->expect(1)->Expect.not->Expect.toBe(2)
    t->expect(2.)->Expect.not->Expect.toBe(1.)
    t->expect("one")->Expect.not->Expect.toBe("two")
    t->expect(true)->Expect.not->Expect.toBe(false)
  })

  test("eq", t => {
    t->expect(1)->Expect.eq(1)
    t->expect(2.)->Expect.eq(2.)
    t->expect("one")->Expect.eq("one")
    t->expect(true)->Expect.eq(true)
  })

  test("toBeDefined", t => {
    t->expect(Js.Undefined.return(1))->Expect.toBeDefined
    t->expect(Js.Undefined.return(2.))->Expect.toBeDefined
    t->expect(Js.Undefined.return("one"))->Expect.toBeDefined
    t->expect(Js.Undefined.return(true))->Expect.toBeDefined
  })

  test("toBeUndefined", t => {
    t->expect(Js.Undefined.empty)->Expect.toBeUndefined
  })

  test("toBeTruthy", t => {
    t->expect({"foo": "bar"})->Expect.toBeTruthy
    t->expect(1)->Expect.toBeTruthy
    t->expect(0)->Expect.not->Expect.toBeTruthy
    t->expect("one")->Expect.toBeTruthy
    t->expect("")->Expect.not->Expect.toBeTruthy
    t->expect(true)->Expect.toBeTruthy
    t->expect(false)->Expect.not->Expect.toBeTruthy
  })

  test("toBeFalsy", t => {
    t->expect(0)->Expect.toBeFalsy
    t->expect(1)->Expect.not->Expect.toBeFalsy
    t->expect("")->Expect.toBeFalsy
    t->expect("one")->Expect.not->Expect.toBeFalsy
    t->expect(false)->Expect.toBeFalsy
    t->expect(true)->Expect.not->Expect.toBeFalsy
  })

  test("toBeNull", t => {
    t->expect(Js.Null.empty)->Expect.toBeNull
  })

  test("toEqual", t => {
    t->expect(Ok(1))->Expect.toEqual(Ok(1))
    t->expect(Error("error"))->Expect.toEqual(Error("error"))
    t->expect(Some("option"))->Expect.toEqual(Some("option"))
    t->expect(None)->Expect.toEqual(None)
    t->expect({"foo": "bar"})->Expect.toEqual({"foo": "bar"})
    t->expect(1)->Expect.toEqual(1)
    t->expect(2.)->Expect.toEqual(2.)
    t->expect("one")->Expect.toEqual("one")
    t->expect(true)->Expect.toEqual(true)
  })

  test("toBeSome", t => {
    t->expect(Some(1))->Expect.toBeSome
    t->expect(Some(2.))->Expect.toBeSome
    t->expect(Some("one"))->Expect.toBeSome
    t->expect(Some(true))->Expect.toBeSome
    t->expect(Some({"foo": "bar"}))->Expect.toBeSome
  })

  test("toBeNone", t => {
    t->expect(None)->Expect.toBeNone
  })

  test("toStrictEqual", t => {
    t->expect(Ok(1))->Expect.toStrictEqual(Ok(1))
    t->expect(Error("error"))->Expect.toStrictEqual(Error("error"))
    t->expect(Some("option"))->Expect.toStrictEqual(Some("option"))
    t->expect(None)->Expect.toStrictEqual(None)
    t->expect({"foo": "bar"})->Expect.toStrictEqual({"foo": "bar"})
    t->expect(1)->Expect.toStrictEqual(1)
    t->expect(2.)->Expect.toStrictEqual(2.)
    t->expect("one")->Expect.toStrictEqual("one")
    t->expect(true)->Expect.toStrictEqual(true)
  })

  test("toContain", t => {
    t->expect([1, 2, 3])->Expect.toContain(1)
    t->expect([1, 2, 3])->Expect.toContain(2)
    t->expect([1, 2, 3])->Expect.toContain(3)
    t->expect([1, 2, 3])->Expect.not->Expect.toContain(4)
  })

  test("toContainEqual", t => {
    t->expect([{"foo": 1}, {"foo": 2}, {"foo": 3}])->Expect.toContainEqual({"foo": 1})
    t->expect([{"foo": 1}, {"foo": 2}, {"foo": 3}])->Expect.toContainEqual({"foo": 2})
    t->expect([{"foo": 1}, {"foo": 2}, {"foo": 3}])->Expect.toContainEqual({"foo": 3})
    t->expect([{"foo": 1}, {"foo": 2}, {"foo": 3}])->Expect.not->Expect.toContainEqual({"foo": 4})
  })

  test("toMatchSnapshot", t => {
    t->expect(1)->Expect.toMatchSnapshot
    t->expect(2.)->Expect.toMatchSnapshot
    t->expect("one")->Expect.toMatchSnapshot
    t->expect(true)->Expect.toMatchSnapshot
    t->expect({"foo": "bar"})->Expect.toMatchSnapshot
  })

  test("toThrow", t => {
    t->expect(() => raise(Js.Exn.raiseError("error")))->Expect.toThrow
  })

  test("toThrowError", t => {
    t->expect(() => raise(Js.Exn.raiseError("error")))->Expect.toThrowError(~message="error")
  })

  describe("Int", () => {
    describe(
      "Int",
      () => {
        test(
          "toBeGreaterThan",
          t => {
            t->expect(5)->Expect.Int.toBeGreaterThan(3)
            t->expect(10)->Expect.Int.toBeGreaterThan(5)
            t->expect(0)->Expect.Int.toBeGreaterThan(-5)
          },
        )

        test(
          "toBeGreaterThanOrEqual",
          t => {
            t->expect(5)->Expect.Int.toBeGreaterThanOrEqual(3)
            t->expect(5)->Expect.Int.toBeGreaterThanOrEqual(5)
            t->expect(10)->Expect.Int.toBeGreaterThanOrEqual(5)
          },
        )

        test(
          "toBeLessThan",
          t => {
            t->expect(3)->Expect.Int.toBeLessThan(5)
            t->expect(5)->Expect.Int.toBeLessThan(10)
            t->expect(-5)->Expect.Int.toBeLessThan(0)
          },
        )

        test(
          "toBeLessThanOrEqual",
          t => {
            t->expect(3)->Expect.Int.toBeLessThanOrEqual(5)
            t->expect(5)->Expect.Int.toBeLessThanOrEqual(5)
            t->expect(5)->Expect.Int.toBeLessThanOrEqual(10)
          },
        )
      },
    )
  })

  describe("Float", () => {
    test(
      "toBeNaN",
      t => {
        t->expect(Js.Math.acos(2.))->Expect.Float.toBeNaN
      },
    )

    test(
      "toBeCloseTo",
      t => {
        t->expect(1.1)->Expect.Float.toBeCloseTo(1.2, 0)
      },
    )

    test(
      "toBeGreaterThan",
      t => {
        t->expect(5.)->Expect.Float.toBeGreaterThan(3.)
        t->expect(10.)->Expect.Float.toBeGreaterThan(5.)
        t->expect(0.)->Expect.Float.toBeGreaterThan(-5.)
      },
    )

    test(
      "toBeGreaterThanOrEqual",
      t => {
        t->expect(5.)->Expect.Float.toBeGreaterThanOrEqual(3.)
        t->expect(5.)->Expect.Float.toBeGreaterThanOrEqual(5.)
        t->expect(0.)->Expect.Float.toBeGreaterThanOrEqual(-5.)
      },
    )

    test(
      "toBeLessThan",
      t => {
        t->expect(3.)->Expect.Float.toBeLessThan(5.)
        t->expect(5.)->Expect.Float.toBeLessThan(10.)
        t->expect(-5.)->Expect.Float.toBeLessThan(0.)
      },
    )

    test(
      "toBeLessThanOrEqual",
      t => {
        t->expect(3.)->Expect.Float.toBeLessThanOrEqual(5.)
        t->expect(5.)->Expect.Float.toBeLessThanOrEqual(5.)
        t->expect(-5.)->Expect.Float.toBeLessThanOrEqual(0.)
      },
    )
  })

  describe("String", () => {
    test(
      "toContain",
      t => {
        t->expect("hello")->Expect.String.toContain("ell")
        t->expect("hello")->Expect.String.toContain("lo")
        t->expect("hello")->Expect.String.toContain("h")
        t->expect("hello")->Expect.not->Expect.String.toContain("x")
      },
    )

    test(
      "toHaveLength",
      t => {
        t->expect("hello")->Expect.String.toHaveLength(5)
        t->expect("")->Expect.String.toHaveLength(0)
        t->expect("world")->Expect.not->Expect.String.toHaveLength(10)
      },
    )

    test(
      "toMatch",
      t => {
        t->expect("hello")->Expect.String.toMatch(/h.*o/)
        t->expect("world")->Expect.String.toMatch(/w.*d/)
        t->expect("hello")->Expect.not->Expect.String.toMatch(/x.*y/)
      },
    )
  })

  describe("Array", () => {
    test(
      "toContain",
      t => {
        t->expect([1, 2, 3])->Expect.Array.toContain(2)
        t->expect(["hello", "world"])->Expect.Array.toContain("world")
        t->expect([true, false])->Expect.Array.toContain(false)
        t->expect([1, 2, 3])->Expect.not->Expect.Array.toContain(4)
      },
    )

    test(
      "toContainEqual",
      t => {
        t->expect([1, 2, 3])->Expect.Array.toContainEqual(2)
        t->expect(["hello", "world"])->Expect.Array.toContainEqual("world")
        t->expect([true, false])->Expect.Array.toContainEqual(false)
        t->expect([1, 2, 3])->Expect.not->Expect.Array.toContainEqual(4)
      },
    )

    test(
      "toHaveLength",
      t => {
        t->expect([1, 2, 3])->Expect.Array.toHaveLength(3)
        t->expect([])->Expect.Array.toHaveLength(0)
        t->expect([1, 2, 3])->Expect.not->Expect.Array.toHaveLength(5)
      },
    )

    test(
      "toMatch",
      t => {
        t->expect([1, 2, 3])->Expect.Array.toMatch([1, 2, 3])
        t->expect(["hello", "world"])->Expect.Array.toMatch(["hello", "world"])
        t->expect([true, false])->Expect.Array.toMatch([true, false])
        t->expect([1, 2, 3])->Expect.not->Expect.Array.toMatch([1, 2])
      },
    )
  })

  describe("List", () => {
    test(
      "toContain",
      t => {
        let value = list{1, 2, 3}
        t->expect(value)->Expect.List.toContain(1)
        t->expect(value)->Expect.List.toContain(2)
        t->expect(value)->Expect.List.toContain(3)
        t->expect(value)->Expect.not->Expect.List.toContain(4)
      },
    )

    test(
      "toContainEqual",
      t => {
        let value = list{{"property": 1}, {"property": 2}, {"property": 3}}
        t->expect(value)->Expect.List.toContainEqual({"property": 1})
        t->expect(value)->Expect.List.toContainEqual({"property": 2})
        t->expect(value)->Expect.List.toContainEqual({"property": 3})
        t->expect(value)->Expect.not->Expect.List.toContainEqual({"property": 4})
      },
    )

    test(
      "toHaveLength",
      t => {
        let value = list{1, 2, 3}
        t->expect(value)->Expect.List.toHaveLength(3)
        t->expect(value)->Expect.not->Expect.List.toHaveLength(5)
      },
    )

    test(
      "toMatch",
      t => {
        let value = list{1, 2, 3}
        t->expect(value)->Expect.List.toMatch(list{1, 2, 3})
        t->expect(value)->Expect.not->Expect.List.toMatch(list{1, 2})
      },
    )
  })

  describe("Dict", () => {
    test(
      "toHaveProperty",
      t => {
        let dict = Js.Dict.empty()
        Js.Dict.set(dict, "key", "value")
        t->expect(dict)->Expect.Dict.toHaveProperty("key", "value")
        t->expect(dict)->Expect.not->Expect.Dict.toHaveProperty("nonexistent", "value")
      },
    )

    test(
      "toHaveKey",
      t => {
        let dict = Js.Dict.empty()
        Js.Dict.set(dict, "key", "value")
        t->expect(dict)->Expect.Dict.toHaveKey("key")
        t->expect(dict)->Expect.not->Expect.Dict.toHaveKey("nonexistent")
      },
    )

    test(
      "toMatch",
      t => {
        let dict = Js.Dict.empty()
        Js.Dict.set(dict, "key1", "value1")
        Js.Dict.set(dict, "key2", "value2")
        t->expect(dict)->Expect.Dict.toMatch(
          Js.Dict.fromArray([("key1", "value1"), ("key2", "value2")]),
        )
        t->expect(dict)->Expect.Dict.toMatch(Js.Dict.fromArray([("key1", "value1")]))
        t->expect(dict)->Expect.Dict.toMatch(Js.Dict.fromArray([("key2", "value2")]))
        t->expect(dict)->Expect.not->Expect.Dict.toMatch(Js.Dict.fromArray([("key1", "value2")]))
      },
    )
  })

  describe("Promise", () => {
    testAsync(
      "rejects",
      async t => {
        let promise = () => Js.Promise.reject(%raw(`new Error("hi")`))
        await t->expect(promise())->Expect.Promise.rejects->Expect.Promise.toThrow(~message="hi")
        await t->expect(promise())
        ->Expect.Promise.rejects
        ->Expect.Promise.toThrowError(~message="hi")
      },
    )

    testAsync(
      "resolves",
      async t => {
        let promise = () => Js.Promise.resolve(1)
        await t->expect(promise())->Expect.Promise.resolves->Expect.Promise.toEqual(1)
      },
    )
  })
})
