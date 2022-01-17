HOUR_MINUTES = 60
DAY_HOURS = 24
DAY_MINUTES = DAY_HOURS * HOUR_MINUTES


def foobar():
    return {"spam": "eggs"}


class MyHelper:

    @classmethod
    def get_class_name(cls):
        return cls.__name__


if __name__ == '__main__':
    print("Module", __name__, "initialized")
    print("We have some things here:", MyHelper, foobar)
