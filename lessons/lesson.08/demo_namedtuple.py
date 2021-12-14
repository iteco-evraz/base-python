from collections import namedtuple

# User = namedtuple("User", ["user_id", "username"])
# User = namedtuple("User", "user_id username")
User = namedtuple("User", "user_id, age, username, email, full_name")

Car = namedtuple("Car", "manufacturer, year")
Book = namedtuple("Book", "author, copies")


def get_user():
    id_ = 42
    age = 40
    user_name = "john"
    user_email = "john@example.com"
    full_name = "John Smith"
    return User(id_, age, user_name, user_email, full_name)


def demo_user_tuple():

    user = get_user()
    print(user)
    print(user[0], user[1])
    print(user.user_id, user.username)
    print(user.username, user[1])
    print(user.age, user.full_name)
    print(user.email)

    # id_, user_name, user_email = user
    # print(id_, user_name, user_email)


def compare_different_tuples():
    # (1, 2) == (1, 2)
    car = Car("Ford", 2000)
    print(car)

    book = Book("Ford", 2000)
    print(book)

    print("car == book", car == book)


def main():
    # demo_user_tuple()
    compare_different_tuples()


if __name__ == '__main__':
    main()
