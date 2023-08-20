from  MatchMonitor import *
import unittest 
from unittest.mock import MagicMock

def check_exists_by_xpath(element, xpath):
    return True

minute = None
hour = None

def getMatchTime(page):
    global minute, hour
    return (minute, hour)

goals = None
def getTotalGoals(page):
    global goals
    return goals

layUnder1p5Odds = None
def getLayUnder1p5Odds(page):
    global layUnder1p5Odds
    return layUnder1p5Odds

layUnder2p5Odds = None
def getLayUnder2p5Odds(page):
    global layUnder2p5Odds
    return layUnder2p5Odds


def layUnder1p5at1p5(page, db, mid):
    print("layUnder1p5at1p5")

def layUnder2p5at1p5(page, db, mid):
    print("layUnder2p5at1p5")

def backUnder1p5at1p5(page, db, mid):
    print("backUnder1p5at1p5")

def backUnder2p5at1p5(page, db, mid):
    print("backUnder2p5at1p5")

def backUnder1p5(page, db, mid):
    print("backUnder1p5")

def layUnder1p5(page, db, mid):
    print("layUnder1p5")

layUnder2p5Odds = None
def getLayUnder2p5Odds(page, db, mid):
    global layUnder2p5Odds
    return layUnder2p5Odds

def backUnder2p5(page, db, mid):
    print("backUnder2p5")
    
backUnder1p5Odds = None
def getBackUnder1p5Odds():
    global backUnder1p5Odds
    return backUnder1p5Odds

backUnder2p5Odds = None
def getBackUnder2p5Odds():
    global backUnder2p5Odds
    return backUnder2p5Odds

class TestMatchMonitor(unittest.TestCase):

    def test_exists(self):
        self.assertEqual(check_exists_by_xpath(10,''), True)

    def test_getMatchTime(self):
        global minute, hour
        dummy = {}
        minute = 10
        hour = 10
        m, h = getMatchTime(dummy)
        self.assertEqual(m, 10)
        self.assertEqual(h, 10)

    def test_getTotalGoals(self):
        global goals
        dummy = {}
        goals = 0
        self.assertEqual(getTotalGoals(dummy), 0)

    def test_getLayUnder1p5Odds(self):
        global layUnder1p5Odds
        dummy = {}
        layUnder1p5Odds = 1.5
        self.assertEqual(getLayUnder1p5Odds(dummy), 1.5)

    def test_getLayUnder2p5Odds(self):
        global layUnder2p5Odds
        dummy = {}
        layUnder2p5Odds = 1.5
        self.assertEqual(getLayUnder2p5Odds(dummy, dummy, dummy), 1.5)

    def test_monitorMatch(self):
        global minute, hour
        minute = 'Half Time'
        mid = 551
        #monitorMatch(mid)

if __name__ == '__main__':
    #unittest.main()
    monitorMatch(634)
