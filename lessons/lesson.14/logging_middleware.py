import logging

logger = logging.getLogger(__name__)


class LoggingMiddleware:
    # def __init__(self, foo, bar):
    #     self.spam = foo
    #     self.eggs = bar

    def process_request(self, req, resp):
        """Process the request before routing it."""
        # logger.info("%s %s", self.spam, self.eggs)
        logger.info("process request %s. Prepared response: %s",
                    req, resp)

    def process_resource(self, req, resp, resource, params):
        """Process the request after routing."""
        logger.info("process resource %s with params %s."
                    " Request %s. Prepared response %s",
                    resource, params, req, resp)

    def process_response(self, req, resp, resource, req_succeeded):
        """Post-processing of the response (after routing)."""
        logger.info("process response %s for resource %s."
                    " Request %s, success: %s",
                    resp, resource, req, req_succeeded)
