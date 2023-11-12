import time
import logging
from queue import Queue
from threading import Thread, Lock

from LayXMatch import LayXMatch
from Utils import initialise_logger
from PGConnector import PGConnector
from DailyMatchRow import DailyMatchRow
from multiprocessing import Process

class LayXManager(Thread):

    pendingMatches = Queue()   # Stores LayXMatchRow
    activeMatches = set()      # Stores LayXMatch
    pendingQueueMutex = Lock()
    activeSetMutex = Lock()

    allMatches = []


    def __init__(self):
        self.daemon = True
        Thread.__init__(self)


    def run(self):
        pass




    def queueLayXMatchRow(self, layXmatchRow):
        self.pendingQueueMutex.acquire()
        self.pendingMatches.put(layXmatchRow)
        self.pendingQueueMutex.release()


    def removeActiveMatch(self, match):
        if match in self.activeMatches:
            self.activeSetMutex.acquire()
            self.activeMatches.remove(match)
            self.activeSetMutex.release()


    def popPendingMatchRow(self):
        self.pendingQueueMutex.acquire()
        matchRow = self.pendingMatches.get()
        self.pendingQueueMutex.release()
        return matchRow

    def startMatch(self, matchRow):
        self.activeSetMutex.acquire()
        layXMatch = LayXMatch(matchRow, self)
        self.activeMatches.add(layXMatch)
        self.activeSetMutex.release()
        layXMatch.start()

    def startNextMatch(self):
        matchRow = self.popPendingMatchRow()
        self.startMatch(matchRow)

    def layXMatchFinished(self, match):
        self.removeActiveMatch(match)
        self.startNextMatch()

