import logging

from users_api import app

logging.basicConfig(level=logging.INFO)


def main():
    from waitress import serve

    logging.info("Start app..")
    serve(app, port="8000")


if __name__ == '__main__':
    main()
