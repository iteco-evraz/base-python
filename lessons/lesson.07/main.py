from frozendict import frozendict
# from models.power_switch import PowerSwitch
# from models.switchables import LightBulb
from models import PowerSwitch, LightBulb


def demo_switchables():
    light_bulb = LightBulb()
    light_bulb.turn_off()
    light_bulb.turn_on()
    light_bulb.turn_off()

    switch = PowerSwitch(light_bulb)
    switch.toggle()
    switch.toggle()
    switch.toggle()


def demo_frozendict():
    fd = frozendict({"spam": "eggs", "fizz": "buzz"})
    print(fd)

    print("spam:", fd["spam"])

    try:
        fd["buzzword"]
    except KeyError as e:
        print(repr(e))

    print("len(fd):", len(fd))

    print('"spam" in fd', "spam" in fd)
    print('"spam" not in fd', "spam" not in fd)
    print('"buzzword" not in fd', "buzzword" not in fd)

    print("hash(fd)", hash(fd))

    print("fd.items()", fd.items())
    print("frozenset(fd.items())", frozenset(fd.items()))

    my_data = {
        fd: list(range(10)),
    }
    print("dict with frozendict as key:", my_data)

    fd_unhashable = frozendict({1: []})
    try:
        hash(fd_unhashable)
    except TypeError as e:
        print(repr(e))

    fd2 = frozendict(fd)
    print("fd == fd2", fd == fd2)
    print("fd is fd2", fd is fd2)

    fd3 = fd2.copy()
    print("fd2 == fd3", fd2 == fd3)
    print("fd2 is fd3", fd2 is fd3)

    fd4 = fd3
    print(fd4)

    a = 1
    b = a
    print("a == b", a == b)
    print("a is b", a is b)

    t1 = ("spam", "eggs")
    t2 = t1
    print("t1 == t2", t1 == t2)
    print("t1 is t2", t1 is t2)


def main():
    # demo_switchables()
    demo_frozendict()


if __name__ == '__main__':
    main()
