import json


def demo_dump_to_json():
    user_data_dict = {
        "id": 42,
        "name": "John Smith",
        "friends": [
            {"id": 3},
            {"id": 5},
        ],
        "username": None,
        "online": True,
    }

    print(type(user_data_dict))
    print(user_data_dict)

    user_data_json_str = json.dumps(user_data_dict)
    print(type(user_data_json_str))
    print(user_data_json_str)

    print(user_data_json_str[1:5])


def demo_loads_from_str():
    user_data_str = """
    {
        "id": 55, 
        "name": "Sam White", 
        "friends": [{"id": 1}, {"id": 5}, {"id": 7}], 
        "username": "sam",
        "online": false
    }
    """

    print(type(user_data_str))
    print(user_data_str)

    # print(repr(user_data_str))

    user_data_dict = json.loads(user_data_str)
    print(type(user_data_dict))
    print(user_data_dict)

    print(user_data_dict["id"])
    print(user_data_dict["username"])
    print(user_data_dict["name"])


def main():
    # demo_dump_to_json()
    demo_loads_from_str()


if __name__ == '__main__':
    main()
