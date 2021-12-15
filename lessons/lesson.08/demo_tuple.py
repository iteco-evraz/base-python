def get_user_data_tuple():
    user_id = 42
    age = 37
    username = "john"
    email = "john@example.com"
    full_name = "John Smith"
    # return (user_id, age, username, email)
    return user_id, age, username, email, full_name


def main():
    result = get_user_data_tuple()
    print("result:", result)

    print("id:", result[0], "age:", result[1])
    id_, user_age, user_name, user_email, full_name = get_user_data_tuple()
    print(id_, user_age, user_name, user_email)
    print("full name:", full_name)


if __name__ == '__main__':
    main()
