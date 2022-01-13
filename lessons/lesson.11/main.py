import logging

from waitress import serve

from users_api import app

logging.basicConfig(level=logging.INFO)

if __name__ == '__main__':
    # logging.info("Starting server")
    serve(app, port="8000")
