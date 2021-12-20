from falcon import App, CORSMiddleware

from users_views import UsersListResource, UserDetailsResource

ALLOW_ORIGINS = [
    "https://example.com",
    # "*.abc.org",
    "www.abc.org",
    "shop.abc.org",
    "http://httpbin.org",
]

cors = CORSMiddleware(allow_origins=ALLOW_ORIGINS)

users_list = UsersListResource()
user_details = UserDetailsResource()

app = App(middleware=cors)

app.add_route("/users", users_list)
app.add_route("/users/{user_id}", user_details)

