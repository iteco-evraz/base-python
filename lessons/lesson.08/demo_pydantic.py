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
    name: str = "John Doe"
    signup_ts: Optional[datetime] = None
    friends: list[int] = []

    @validator("name")
    def validate_name(cls, value: str):
        value = value.strip()

        # " Sam" -> "Sam"
        # " Sam White " -> "Sam White"
        # " " -> ""
        # value = value.strip()

        if not value:
            raise ValueError("name can't be empty")

        if " " not in value:
            raise ValueError("name has to contain at least one space")

        return value


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


def demo_user():
    user_sam = User(id=42, name="Sam Smith")
    print(user_sam)

    user_nick = User(id=7, name="Nick Black")
    print(user_nick)

    user_sam.friends.append(1)
    user_sam.friends.append(2)
    user_sam.friends.append(3)

    user_nick.friends.append(4)
    user_nick.friends.append(6)
    user_nick.friends.append(8)

    print(user_sam)
    print(user_nick)

    external_data = {
        "id": "123",
        "signup_ts": "2021-12-14 15:44",
        "friends": [1, "23", b"54"],
    }
    user = User(**external_data)
    print(user)
    print(user.signup_ts.date())

    print(user.dict())
    print(user.json())

    # User(id=0, name="")
    # User(id=0, name=" ")
    # User(id=0, name=None)
    u = User(id=0, name="John Smith ")
    print(u)


def main():
    # print(datetime.fromtimestamp())
    # print(datetime.now())
    # date_time = datetime.now()
    # print(datetime.date(datetime.now()))
    # print(date_time.date())
    # demo_food()
    demo_user()


if __name__ == '__main__':
    main()
