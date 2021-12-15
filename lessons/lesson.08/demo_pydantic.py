from datetime import datetime
from typing import Optional
from pydantic import BaseModel, validator


class Food(BaseModel):
    name: str
    weight: int

    class Config:
        frozen = True


class User(BaseModel):
    id: int
    # name: str = "John Doe"
    name = "John Doe"
    signup_ts: Optional[datetime] = None
    friends_list: list[int] = []

    @validator("name")
    def validate_name(cls, value: str):
        print("before:", repr(value))
        value = value.strip()
        print("after:", repr(value))

        if not value:
            raise ValueError("name required")

        if " " not in value:
            raise ValueError("name has to contain spaces")
            # raise ValueError("name has to be ")

        return value


def demo_user():
    user_sam = User(id=42, name="Sam Smith")
    print("user_sam:", user_sam)

    user_john = User(id=15)
    print("user_john:", user_john)

    user_john.friends_list.append(1)
    user_john.friends_list.append(2)
    user_john.friends_list.append(3)

    user_sam.friends_list.append(4)
    user_sam.friends_list.append(5)
    user_sam.friends_list.append(6)

    print("user_john:", user_john)
    print("user_sam:", user_sam)

    external_data = {
        "id": "123",
        "signup_ts": "2020-07-22 14:55",
        "friends_list": [1, "2", b"5"],
    }
    user = User(**external_data)
    print(user)
    print("sign up date:", user.signup_ts.date())

    print(user.dict())

    # user = User(id=1, name=None)
    # user = User(id=1, name="")
    # user = User(id=1, name=" ")
    # user = User(id=1, name=" John ")
    user = User(id=1, name=" John Doe")
    print(user)



def demo_food():
    bread = Food(name="bread", weight=300)
    print("bread:", bread)

    milk = Food(name="milk", weight="950")
    print("milk:", milk)

    try:
        milk.weight = 900
    except TypeError as e:
        print(e)

    print("milk:", milk)


def main():
    # demo_food()
    demo_user()


if __name__ == '__main__':
    main()
