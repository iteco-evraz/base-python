from falcon import Request, Response

from kombu import Connection, Message


class StatMiddleware:
    def __init__(
        self,
        connection: Connection,
        queue_name="queue_name",
        serializer="json",
    ):
        self.queue = connection.SimpleQueue(queue_name)
        self.serializer = serializer

    def process_request(self, req, resp):
        """Process the request before routing it."""
        self.send_req_stat(req)

    def process_response(self, req, resp, resource, req_succeeded):
        """Post-processing of the response (after routing)."""

    def prepare_request_stat_message(self, req: Request):
        return {
            "message": "new request",
            "path": req.path,
            "headers": req.headers,
            "qs": req.query_string,
            "method": req.method,
            "content_type": req.content_type,
        }

    def send_req_stat(self, req: Request):
        message = self.prepare_request_stat_message(req)
        self.queue.put(message, serializer=self.serializer)

    def process_stat(self, callback, n=1, timeout=1):
        for i in range(n):
            message: Message = self.queue.get(block=True, timeout=timeout)
            callback(message.payload)
            message.ack()

    def close(self):
        self.queue.close()
