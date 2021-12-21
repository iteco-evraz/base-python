from falcon import App, CORSMiddleware

from users_views import UsersListResource, UserDetailsResource

ALLOW_ORIGINS = [
    "abc.com",
    "www.google.com",
    "http://httpbin.org",
    "http://0.0.0.0:8000",
    "http://mysite.local:8000",
]

cors = CORSMiddleware(allow_origins=ALLOW_ORIGINS)

users_list = UsersListResource()
user_details = UserDetailsResource()

app = App(middleware=cors)

app.add_route("/users", users_list)
app.add_route("/users/{user_id}", user_details)


# if __name__ == '__main__':
#
#     from waitress import serve
#
#     serve(app)
#
# # terminal!!
# # waitress-serve users_api:app
