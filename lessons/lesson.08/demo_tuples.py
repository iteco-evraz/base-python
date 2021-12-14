def get_user_data_tuple():
    user_id = 37
    age = 42
    username = "sam"
    email = "sam@example.com"
    full_name = "Sam White"
    return user_id, age, username, email, full_name


def main():
    result = get_user_data_tuple()
    print("user data result:", result)
    print("user id =", result[0], "and user age =", result[1])

    user_id, user_age, user_name, user_email, name = get_user_data_tuple()
    print("user_id:", user_id)
    print("user_age:", user_age)
    print("user_name:", user_name)
    print("user_email:", user_email)
    print("name:", name)


if __name__ == '__main__':
    main()
