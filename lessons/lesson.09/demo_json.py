import json


def demo_dump_to_json():
    user_data_dict = {
        "id": 42,
        "name": "John Smith",
        "friends": [
            {"id": 3},
            {"id": 4},
        ],
        "username": None,
        "online": False,
    }
    print(type(user_data_dict))
    print(user_data_dict)

    # user_data_json_str = json.dumps(user_data_dict, indent=2)
    user_data_json_str = json.dumps(user_data_dict)
    print(type(user_data_json_str))
    print(user_data_json_str)

    print(user_data_json_str[1:5])


def demo_loads_from_json_string():
    user_data_json_string = """
    {
      "id": 123,
      "name": "Sam White",
      "friends": [
        {
          "id": 5,
          "name": null
        },
        {
          "id": 7,
          "name": "Nick"
        }
      ],
      "username": "sam",
      "online": true
    }
    """

    print(type(user_data_json_string))
    print(user_data_json_string)

    user_data_dict = json.loads(user_data_json_string)
    print(type(user_data_dict))
    print(user_data_dict)

    print("name:", user_data_dict["name"])

    for friend in user_data_dict["friends"]:
        print("friend #", friend["id"], "name:", friend["name"])


def main():
    # demo_dump_to_json()
    demo_loads_from_json_string()


if __name__ == '__main__':
    main()
