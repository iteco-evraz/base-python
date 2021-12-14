from dataclasses import dataclass, field, FrozenInstanceError


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
    age: int = 0
    username: str = ""
    email: str = ""

    def increase_age(self):
        # self.age = self.age + 1
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

    plane = Plane("gray", cargo=0, max_cargo=100)
    print(plane)


def demo_with_food():
    bread = Food("bread", weight=300)
    print("bread:", bread)

    milk = Food("milk", weight=950)
    print("milk:", milk)

    try:
        milk.weight = 900
    except FrozenInstanceError as e:
        print(repr(e))

    print("milk:", milk)

    shelf = Shelf(id=1)
    print(shelf)
    shelf.products.append(bread)
    print(shelf)
    shelf.products.append(milk)
    print(shelf)
    for product in shelf.products:
        print("food:", product.name, product.weight)

    # car = Car("Ford", 2020)
    # shelf.products.append(car)
    # print(shelf)


def demo_user():
    user = User(1)
    print(user)

    user_john = User(2, username="john")
    print("user_john:", user_john)

    user_sam = User(user_id=3, age=42, username="sam", email="sam@example.com")
    print(user_sam)

    user.username = "nick"
    print(user)

    user_sam.increase_age()
    print(user_sam)

    user.increase_age()
    print(user)

    user_john.increase_age()
    print(user_john)

    user_john.increase_age()
    print(user_john)


def demo_coord():
    coord = Coordinate(1, 2, 3)
    print(coord)

    coord2 = Coordinate(x=1, y=2, z=3)
    print(coord2)

    print("coord == coord2", coord == coord2)
    coord.x = 2
    coord2.y = 4

    print(coord)
    print(coord2)


def demo_coord_other_type():
    coord = Coordinate("123", ["qwe", 432], None)
    print(coord)


def compare_car_and_book():
    car = Car("Ford", 2000)
    book = Book("Ford", 2000)
    print("car == book", car == book)


def main():
    # demo_coord()
    # demo_coord_other_type()
    # compare_car_and_book()
    # demo_user()
    # demo_with_food()
    demo_vehicles()


if __name__ == '__main__':
    main()
