from .switchable import Switchable


class LightBulb(Switchable):

    def turn_on(self):
        print("LightBulb turned on")

    def turn_off(self):
        print("LightBulb turned off")
