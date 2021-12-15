from dataclasses import dataclass, FrozenInstanceError, field


@dataclass
class Coordinate:
    x: int
    y: int
    z: int


@dataclass
class Car:
    manufacturer: str
    year: int


@dataclass
class Book:
    author: str
    copies: int


@dataclass
class User:
    user_id: int
    # status: str = ""
    age: int = 0
    username: str = ""
    email: str = ""

    def increase_age(self):
        self.age += 1


@dataclass(frozen=True)
class Food:
    name: str
    weight: int


@dataclass(frozen=True)
class Shelf:
    id: int
    products: list[Food] = field(default_factory=list)


@dataclass
class VehicleBase:
    color: str


@dataclass
class Ship(VehicleBase):
    cabins: int


@dataclass
class Plane(VehicleBase):
    cargo: int
    max_cargo: int


def demo_vehicles():
    vehicle = VehicleBase("red")
    print(vehicle)

    ship = Ship("white", 5)
    print(ship)

    plane = Plane("grey", cargo=0, max_cargo=100)
    print(plane)

    plane.cargo += 10
    print(plane)


def demo_with_food():
    bread = Food(name="bread", weight=300)
    print(bread)

    milk = Food("milk", weight=950)
    print(milk)

    try:
        milk.weight = 900
    except FrozenInstanceError as e:
        print(repr(e))

    print(milk)

    shelf = Shelf(id=1)
    print(shelf)

    shelf.products.append(bread)
    print(shelf)

    shelf.products.append(milk)
    print(shelf)

    # car = Car("Ford", 2020)
    # shelf.products.append(car)
    # shelf.products = []

    for product in shelf.products:
        print(product.name, product.weight)


def demo_user():
    user_sam = User(7)
    print(user_sam)

    user_sam.username = "sam"
    print(user_sam)

    user_john = User(user_id=9, username="john")
    print(user_john)

    # user_nick = User(3, 10, "nick", "nick@example.com")
    user_nick = User(user_id=3, age=10, username="nick", email="nick@example.com")
    print(user_nick)

    user_sam.increase_age()
    print(user_sam)

    user_john.increase_age()
    user_john.increase_age()
    print(user_john)

    user_nick.increase_age()
    print(user_nick)


def compare_book_and_car():
    car = Car("Ford", 2000)
    print(car)

    book = Book("Ford", 2000)
    print(book)

    print("book == car:", book == car)


def demo_coord():
    coord = Coordinate(1, 2, 3)
    print(coord)

    coord2 = Coordinate(x=1, y=2, z=3)
    print(coord2)

    print("coord2 == coord", coord2 == coord)

    coord.x = 2
    coord2.y = 4

    print(coord)
    print(coord2)
    coord.x += 1
    print(coord)


def demo_coord_other_type():
    coord = Coordinate("123asd", ["qwe", 123], None)
    print(coord)
    # coord.x += 1


def main():
    # demo_coord()
    # demo_coord_other_type()
    # compare_book_and_car()
    # demo_user()
    # demo_with_food()
    demo_vehicles()


if __name__ == '__main__':
    main()
