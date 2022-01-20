import logging
from contextlib import closing

from kombu import Connection

import config
from stat_middleware import StatMiddleware

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def process_entry(entry):
    logger.info("New message: %s", entry)


def process_queue_for_stat_forever(timeout=None):
    with Connection(config.AMQP_CONNECTION_URL) as conn:
        stat_mw = StatMiddleware(
            connection=conn,
            queue_name=config.STAT_QUEUE_NAME,
        )
        with closing(stat_mw):
            while True:
                try:
                    stat_mw.process_stat(process_entry, timeout=timeout)
                except KeyboardInterrupt:
                    logger.warning("Bye!")
                    return


def main():
    logger.warning("Start listening")
    process_queue_for_stat_forever()


if __name__ == '__main__':
    main()
