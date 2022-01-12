import logging

from waitress import serve

from users_api import app

logging.basicConfig(level=logging.INFO)


def main():
    logging.info("Start app..")
    serve(app, port="8000")


if __name__ == '__main__':
    main()
