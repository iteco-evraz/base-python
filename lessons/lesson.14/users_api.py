from falcon import App, CORSMiddleware
from kombu import Connection

import config
from logging_middleware import LoggingMiddleware
from timing_middleware import TimingMiddleware
from stat_middleware import StatMiddleware
from users_views import UsersListResource, UserDetailsResource

ALLOW_ORIGINS = [
    "abc.com",
    "www.google.com",
    "http://httpbin.org",
    "http://0.0.0.0:8000",
    "http://mysite.local:8000",
]

connection = Connection(config.AMQP_CONNECTION_URL)
stats_middleware = StatMiddleware(
    connection=connection,
    queue_name=config.STAT_QUEUE_NAME,
)
cors = CORSMiddleware(allow_origins=ALLOW_ORIGINS)

middlewares = [
    stats_middleware,
    LoggingMiddleware(),
    TimingMiddleware(),
    cors,
]

users_list = UsersListResource()
user_details = UserDetailsResource()

app = App(middleware=middlewares)

app.add_route("/users", users_list)
app.add_route("/users/{user_id}", user_details)
