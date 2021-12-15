from collections import namedtuple

# User = namedtuple("User", ["age", "email"])
# User = namedtuple("User", "age email")
User = namedtuple("User", "id, age, username, email, full_name")

Car = namedtuple("Car", "manufacturer, year")
Book = namedtuple("Book", "author, copies")


# class User:
#     pass


def get_user():
    return User(7, 15, "sam", "sam@example.com", "Sam White")


def compare_different_tuples():
    car = Car("Ford", 2000)
    print(car)

    book = Book("Ford", 2000)
    print(book)

    print("book == car ?", book == car)
    (1, 2) == (1, 2)

    # book.copies = 123


def main():
    compare_different_tuples()

    user = get_user()
    print(user)
    print("id", user[0], "username", user[1])
    print("id", user.id, "username", user.username)


if __name__ == '__main__':
    main()

