from threading import Thread

from Browser import Browser


class LayXMatch(Thread):
    match = None
    manager = None

    db = None
    browser = None

    def __init__(self, match, layXMatchManager):
        self.match = match
        self.manager = layXMatchManager


    def run(self):
        pass
