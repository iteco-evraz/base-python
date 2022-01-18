import logging
from timeit import default_timer

logger = logging.getLogger(__name__)


class TimingMiddleware:
    def process_request(self, req, resp):
        """Process the request before routing it."""
        start_time = default_timer()
        req.context.start_time = start_time

    def process_response(self, req, resp, resource, req_succeeded):
        """Post-processing of the response (after routing)."""
        end_time = default_timer()
        total_time = end_time - req.context.start_time
        logger.info("request to %s with result status %s took %s (success: %s)",
                    req.path, resp.status, total_time, req_succeeded)
