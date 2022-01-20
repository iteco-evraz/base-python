from falcon import App, CORSMiddleware
from kombu import Connection

import config
from logging_middleware import LoggingMiddleware
from timing_middleware import TimingMiddleware
from users_views import UsersListResource, UserDetailsResource
from stat_middleware import StatMiddleware


ALLOW_ORIGINS = [
    "https://example.com",
    # "*.abc.org",
    "www.abc.org",
    "shop.abc.org",
    "http://httpbin.org",
]

connection = Connection(config.AMQP_CONNECTION_URL)
statistics_middleware = StatMiddleware(
    connection=connection,
    queue_name=config.STAT_QUEUE_NAME,
)
cors = CORSMiddleware(allow_origins=ALLOW_ORIGINS)

middlewares = [
    statistics_middleware,
    LoggingMiddleware(),
    TimingMiddleware(),
    cors,
]

users_list = UsersListResource()
user_details = UserDetailsResource()

app = App(middleware=middlewares)

app.add_route("/users", users_list)
app.add_route("/users/{user_id}", user_details)
