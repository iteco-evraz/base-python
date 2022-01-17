def my_func():
    print("start my func")
    print("define another func")

    def another_func():
        print("start another func")
        print("finish another func")
        return 42

    print("defined another func. call it")
    another_func()

    print("finish my func")
    return {"spam": "eggs"}


def func_for_x():
    x = "x in enclosing func"
    print("x in outer func:", x)
    # output: x in outer func: x in enclosing func
    def inner_func():
        x = "x in enclosed func"
        print("x in inner func:", x)
        # output: x in inner func: x in enclosed func

    inner_func()
    print("x in outer func (again):", x)
    # output: x in outer func (again): x in enclosing func


def some_x_func():
    x = "x in enclosing func"
    print("x in outer func:", x)
    # output: x in outer func: x in enclosing func

    def inner_func():
        print("inner func has access to "
              "all outer scopes: enclosing, global, builtin, "
              "so we can print x:", x)
        # output: inner func has access to all outer scopes:
        #         enclosing, global, builtin,
        #         so we can print x: x in enclosing func

    inner_func()
    print("x in outer func (again):", x)
    # output: x in outer func (again): x in enclosing func


def main():
    # my_func()
    # func_for_x()
    some_x_func()


if __name__ == '__main__':
    main()

