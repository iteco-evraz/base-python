DB_USER = "example-user"
DB_PASSWORD = "my_cool_secret"
DB_HOST = "127.0.0.1"
DB_PORT = "3306"
DB_NAME = "blog_app"

SQLALCHEMY_CONN_URL = f"mariadb+mariadbconnector://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
SQLALCHEMY_ECHO = True
