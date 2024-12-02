open Vitest
open! Bindings.BuiltIn

describe("Assert", () => {
  test("assert_", _t => {
    Assert.assert_(true)
    Assert.assert_(1 == 1)
    Assert.assert_("one" == "one")
    Assert.assert_(1 == 1)
  })

  test("unreachable", _t => {
    try {
      let _ = Js.Exn.raiseError("error")
      Assert.unreachable()
    } catch {
    | _ => Assert.assert_(~message="threw error", true)
    }

    try {
      expect(true)->Expect.toBe(true)
    } catch {
      | _ => Assert.unreachable()
    }
  })
})

describe("Expect", () => {
  test("toBe", _t => {
    expect(1)->Expect.toBe(1)
    expect(2.)->Expect.toBe(2.)
    expect("one")->Expect.toBe("one")
    expect(true)->Expect.toBe(true)
  })

  test("not", _t => {
    expect(1)->Expect.not->Expect.toBe(2)
    expect(2.)->Expect.not->Expect.toBe(1.)
    expect("one")->Expect.not->Expect.toBe("two")
    expect(true)->Expect.not->Expect.toBe(false)
  })

  test("eq", _t => {
    expect(1)->Expect.eq(1)
    expect(2.)->Expect.eq(2.)
    expect("one")->Expect.eq("one")
    expect(true)->Expect.eq(true)
  })

  test("toBeDefined", _t => {
    Js.Undefined.return(1)->expect->Expect.toBeDefined
    Js.Undefined.return(2.)->expect->Expect.toBeDefined
    Js.Undefined.return("one")->expect->Expect.toBeDefined
    Js.Undefined.return(true)->expect->Expect.toBeDefined
  })

  test("toBeUndefined", _t => {
    Js.Undefined.empty->expect->Expect.toBeUndefined
  })

  test("toBeTruthy", _t => {
    expect({"foo": "bar"})->Expect.toBeTruthy
    expect(1)->Expect.toBeTruthy
    expect(0)->Expect.not->Expect.toBeTruthy
    expect("one")->Expect.toBeTruthy
    expect("")->Expect.not->Expect.toBeTruthy
    expect(true)->Expect.toBeTruthy
    expect(false)->Expect.not->Expect.toBeTruthy
  })

  test("toBeFalsy", _t => {
    expect(0)->Expect.toBeFalsy
    expect(1)->Expect.not->Expect.toBeFalsy
    expect("")->Expect.toBeFalsy
    expect("one")->Expect.not->Expect.toBeFalsy
    expect(false)->Expect.toBeFalsy
    expect(true)->Expect.not->Expect.toBeFalsy
  })

  test("toBeNull", _t => {
    Js.Null.empty->expect->Expect.toBeNull
  })

  test("toEqual", _t => {
    expect(Ok(1))->Expect.toEqual(Ok(1))
    expect(Error("error"))->Expect.toEqual(Error("error"))
    expect(Some("option"))->Expect.toEqual(Some("option"))
    expect(None)->Expect.toEqual(None)
    expect({"foo": "bar"})->Expect.toEqual({"foo": "bar"})
    expect(1)->Expect.toEqual(1)
    expect(2.)->Expect.toEqual(2.)
    expect("one")->Expect.toEqual("one")
    expect(true)->Expect.toEqual(true)
  })

  test("toBeSome", _t => {
    Some(1)->expect->Expect.toBeSome
    Some(2.)->expect->Expect.toBeSome
    Some("one")->expect->Expect.toBeSome
    Some(true)->expect->Expect.toBeSome
    Some({"foo": "bar"})->expect->Expect.toBeSome
  })

  test("toBeNone", _t => {
    None->expect->Expect.toBeNone
  })

  test("toStrictEqual", _t => {
    expect(Ok(1))->Expect.toStrictEqual(Ok(1))
    expect(Error("error"))->Expect.toStrictEqual(Error("error"))
    expect(Some("option"))->Expect.toStrictEqual(Some("option"))
    expect(None)->Expect.toStrictEqual(None)
    expect({"foo": "bar"})->Expect.toStrictEqual({"foo": "bar"})
    expect(1)->Expect.toStrictEqual(1)
    expect(2.)->Expect.toStrictEqual(2.)
    expect("one")->Expect.toStrictEqual("one")
    expect(true)->Expect.toStrictEqual(true)
  })

  test("toContain", _t => {
    expect([1, 2, 3])->Expect.toContain(1)
    expect([1, 2, 3])->Expect.toContain(2)
    expect([1, 2, 3])->Expect.toContain(3)
    expect([1, 2, 3])->Expect.not->Expect.toContain(4)
  })

  test("toContainEqual", _t => {
    expect([{"foo": 1}, {"foo": 2}, {"foo": 3}])->Expect.toContainEqual({"foo": 1})
    expect([{"foo": 1}, {"foo": 2}, {"foo": 3}])->Expect.toContainEqual({"foo": 2})
    expect([{"foo": 1}, {"foo": 2}, {"foo": 3}])->Expect.toContainEqual({"foo": 3})
    expect([{"foo": 1}, {"foo": 2}, {"foo": 3}])->Expect.not->Expect.toContainEqual({"foo": 4})
  })

  test("toMatchSnapshot", _t => {
    expect(1)->Expect.toMatchSnapshot
    expect(2.)->Expect.toMatchSnapshot
    expect("one")->Expect.toMatchSnapshot
    expect(true)->Expect.toMatchSnapshot
    expect({"foo": "bar"})->Expect.toMatchSnapshot
  })

  test("toThrow", _t => {
    expect(() => raise(Js.Exn.raiseError("error")))->Expect.toThrow
  })

  test("toThrowError", _t => {
    expect(() => raise(Js.Exn.raiseError("error")))->Expect.toThrowError(~message="error")
  })

  describe("Int", () => {
    describe(
      "Int",
      () => {
        test(
          "toBeGreaterThan",
          _t => {
            expect(5)->Expect.Int.toBeGreaterThan(3)
            expect(10)->Expect.Int.toBeGreaterThan(5)
            expect(0)->Expect.Int.toBeGreaterThan(-5)
          },
        )

        test(
          "toBeGreaterThanOrEqual",
          _t => {
            expect(5)->Expect.Int.toBeGreaterThanOrEqual(3)
            expect(5)->Expect.Int.toBeGreaterThanOrEqual(5)
            expect(10)->Expect.Int.toBeGreaterThanOrEqual(5)
          },
        )

        test(
          "toBeLessThan",
          _t => {
            expect(3)->Expect.Int.toBeLessThan(5)
            expect(5)->Expect.Int.toBeLessThan(10)
            expect(-5)->Expect.Int.toBeLessThan(0)
          },
        )

        test(
          "toBeLessThanOrEqual",
          _t => {
            expect(3)->Expect.Int.toBeLessThanOrEqual(5)
            expect(5)->Expect.Int.toBeLessThanOrEqual(5)
            expect(5)->Expect.Int.toBeLessThanOrEqual(10)
          },
        )
      },
    )
  })

  describe("Float", () => {
    test(
      "toBeNaN",
      _t => {
        expect(Js.Math.acos(2.))->Expect.Float.toBeNaN
      },
    )

    test(
      "toBeCloseTo",
      _t => {
        expect(1.1)->Expect.Float.toBeCloseTo(1.2, 0)
      },
    )

    test(
      "toBeGreaterThan",
      _t => {
        expect(5.)->Expect.Float.toBeGreaterThan(3.)
        expect(10.)->Expect.Float.toBeGreaterThan(5.)
        expect(0.)->Expect.Float.toBeGreaterThan(-5.)
      },
    )

    test(
      "toBeGreaterThanOrEqual",
      _t => {
        expect(5.)->Expect.Float.toBeGreaterThanOrEqual(3.)
        expect(5.)->Expect.Float.toBeGreaterThanOrEqual(5.)
        expect(0.)->Expect.Float.toBeGreaterThanOrEqual(-5.)
      },
    )

    test(
      "toBeLessThan",
      _t => {
        expect(3.)->Expect.Float.toBeLessThan(5.)
        expect(5.)->Expect.Float.toBeLessThan(10.)
        expect(-5.)->Expect.Float.toBeLessThan(0.)
      },
    )

    test(
      "toBeLessThanOrEqual",
      _t => {
        expect(3.)->Expect.Float.toBeLessThanOrEqual(5.)
        expect(5.)->Expect.Float.toBeLessThanOrEqual(5.)
        expect(-5.)->Expect.Float.toBeLessThanOrEqual(0.)
      },
    )
  })

  describe("String", () => {
    test(
      "toContain",
      _t => {
        expect("hello")->Expect.String.toContain("ell")
        expect("hello")->Expect.String.toContain("lo")
        expect("hello")->Expect.String.toContain("h")
        expect("hello")->Expect.not->Expect.String.toContain("x")
      },
    )

    test(
      "toHaveLength",
      _t => {
        expect("hello")->Expect.String.toHaveLength(5)
        expect("")->Expect.String.toHaveLength(0)
        expect("world")->Expect.not->Expect.String.toHaveLength(10)
      },
    )

    test(
      "toMatch",
      _t => {
        expect("hello")->Expect.String.toMatch(%re("/h.*o/"))
        expect("world")->Expect.String.toMatch(%re("/w.*d/"))
        expect("hello")->Expect.not->Expect.String.toMatch(%re("/x.*y/"))
      },
    )
  })

  describe("Array", () => {
    test(
      "toContain",
      _t => {
        expect([1, 2, 3])->Expect.Array.toContain(2)
        expect(["hello", "world"])->Expect.Array.toContain("world")
        expect([true, false])->Expect.Array.toContain(false)
        expect([1, 2, 3])->Expect.not->Expect.Array.toContain(4)
      },
    )

    test(
      "toContainEqual",
      _t => {
        expect([1, 2, 3])->Expect.Array.toContainEqual(2)
        expect(["hello", "world"])->Expect.Array.toContainEqual("world")
        expect([true, false])->Expect.Array.toContainEqual(false)
        expect([1, 2, 3])->Expect.not->Expect.Array.toContainEqual(4)
      },
    )

    test(
      "toHaveLength",
      _t => {
        expect([1, 2, 3])->Expect.Array.toHaveLength(3)
        expect([])->Expect.Array.toHaveLength(0)
        expect([1, 2, 3])->Expect.not->Expect.Array.toHaveLength(5)
      },
    )

    test(
      "toMatch",
      _t => {
        expect([1, 2, 3])->Expect.Array.toMatch([1, 2, 3])
        expect(["hello", "world"])->Expect.Array.toMatch(["hello", "world"])
        expect([true, false])->Expect.Array.toMatch([true, false])
        expect([1, 2, 3])->Expect.not->Expect.Array.toMatch([1, 2])
      },
    )
  })

  describe("List", () => {
    test(
      "toContain",
      _t => {
        let value = list{1, 2, 3}
        expect(value)->Expect.List.toContain(1)
        expect(value)->Expect.List.toContain(2)
        expect(value)->Expect.List.toContain(3)
        expect(value)->Expect.not->Expect.List.toContain(4)
      },
    )

    test(
      "toContainEqual",
      _t => {
        let value = list{{"property": 1}, {"property": 2}, {"property": 3}}
        expect(value)->Expect.List.toContainEqual({"property": 1})
        expect(value)->Expect.List.toContainEqual({"property": 2})
        expect(value)->Expect.List.toContainEqual({"property": 3})
        expect(value)->Expect.not->Expect.List.toContainEqual({"property": 4})
      },
    )

    test(
      "toHaveLength",
      _t => {
        let value = list{1, 2, 3}
        expect(value)->Expect.List.toHaveLength(3)
        expect(value)->Expect.not->Expect.List.toHaveLength(5)
      },
    )

    test(
      "toMatch",
      _t => {
        let value = list{1, 2, 3}
        expect(value)->Expect.List.toMatch(list{1, 2, 3})
        expect(value)->Expect.not->Expect.List.toMatch(list{1, 2})
      },
    )
  })

  describe("Dict", () => {
    test(
      "toHaveProperty",
      _t => {
        let dict = Js.Dict.empty()
        Js.Dict.set(dict, "key", "value")
        expect(dict)->Expect.Dict.toHaveProperty("key", "value")
        expect(dict)->Expect.not->Expect.Dict.toHaveProperty("nonexistent", "value")
      },
    )

    test(
      "toHaveKey",
      _t => {
        let dict = Js.Dict.empty()
        Js.Dict.set(dict, "key", "value")
        expect(dict)->Expect.Dict.toHaveKey("key")
        expect(dict)->Expect.not->Expect.Dict.toHaveKey("nonexistent")
      },
    )

    test(
      "toMatch",
      _t => {
        let dict = Js.Dict.empty()
        Js.Dict.set(dict, "key1", "value1")
        Js.Dict.set(dict, "key2", "value2")
        expect(dict)->Expect.Dict.toMatch(
          Js.Dict.fromArray([("key1", "value1"), ("key2", "value2")]),
        )
        expect(dict)->Expect.Dict.toMatch(Js.Dict.fromArray([("key1", "value1")]))
        expect(dict)->Expect.Dict.toMatch(Js.Dict.fromArray([("key2", "value2")]))
        expect(dict)->Expect.not->Expect.Dict.toMatch(Js.Dict.fromArray([("key1", "value2")]))
      },
    )
  })

  describe("Promise", () => {
    testAsync(
      "rejects",
      async _t => {
        let promise = () => Js.Promise.reject(%raw(`new Error("hi")`))
        await expect(promise())->Expect.Promise.rejects->Expect.Promise.toThrow(~message="hi")
        await expect(promise())->Expect.Promise.rejects->Expect.Promise.toThrowError(~message="hi")
      },
    )

    testAsync(
      "resolves",
      async _t => {
        let promise = () => Js.Promise.resolve(1)
        await expect(promise())->Expect.Promise.resolves->Expect.Promise.toEqual(1)
      },
    )
  })
})
