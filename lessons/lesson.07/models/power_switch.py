# from .switchables.switchable import Switchable
from .switchables import Switchable


class PowerSwitch:
    def __init__(self, client: Switchable):
        self.client = client
        self.on = False

    def toggle(self):
        if self.on:
            self.client.turn_off()
            self.on = False
        else:
            self.client.turn_on()
            self.on = True
