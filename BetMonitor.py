import sys
from datetime import datetime
import logging
import Utils
from LiveMatch import APILivePage
from PGConnector import PGConnector
from BetRow import BetRow
from Browser import Browser
from selenium.webdriver.common.by import By
from threading import Thread


class BetStatus:
    id = None
    placedTime = None
    matched = None
    lasped = False

    def __init__(self, id, placedTime, matched, lapsed=False):
        self.id = id
        self.placedTime = placedTime
        self.matched = matched
        self.lasped = lapsed


class BetMonitor:
    db = None
    browser = None
    page = None
    bet = None
    lastGoodKnownBetStatus = None

    def __init__(self, db, browser, page, bet):
        self.db = db
        self.browser = browser
        self.page = page
        self.bet = bet

    def getBetStatus(self):
        event_name = self.bet.get("Home") + " v " + self.bet.get("Away")
        try:
            betSlipDiv = self.page.find_elements(By.XPATH, '//*[@data-event-name="' + event_name + '"]')[0]
            betId = betSlipDiv.get_attribute('data-offer-id')
            betTime = int(betSlipDiv.get_attribute('data-placed-date'))
            statusDiv = betSlipDiv.find_element(By.XPATH, './div/div')
            statusDivClasses = statusDiv.get_attribute('class').split()
            matched = None
            if 'biab_unmatched' in statusDivClasses:
                matched = False
            elif 'biab_matched' in statusDivClasses:
                matched = True
            return BetStatus(betId, betTime, matched)
        except Exception as Argument:
            logging.info("Failed to get betslip status: %s" % event_name)
        return None

    def monitor(self):
        timeout = 30
        betStatus = self.getBetStatus()
        retries = 0
        while betStatus is None:
            Utils.sleep_for_seconds(1)
            betStatus = self.getBetStatus()
            retries += 1
            if retries > timeout:
                return "Not found"

        if betStatus.matched:
            self.updateBet(betStatus)
            self.lastGoodKnownBetStatus = betStatus
            return "Matched"

        Utils.sleep_for_seconds(1)
        betStatus = self.getBetStatus()
        while betStatus and betStatus.matched is False:
            Utils.sleep_for_seconds(1)
            betStatus = self.getBetStatus()

        if betStatus is None and self.lastGoodKnownBetStatus.matched is False: # lapsed
            self.lastGoodKnownBetStatus.lapsed = True
            self.updateBet(self.lastGoodKnownBetStatus)
            return "Lapsed"

        if betStatus and betStatus.matched:
            self.updateBet(betStatus)
            return "Matched"

        return "Unknown"

    def updateBet(self, betStatus):
        self.bet.set("BetDateTime", datetime.fromtimestamp(betStatus.placedTime))
        self.bet.set("BetId", betStatus.id)
        if betStatus.lasped:
            self.bet.set("BetResult", 'Lapsed')
        if betStatus.lasped or betStatus.matched:
            self.bet.set("BetResultTime", datetime.now())
        self.db.update(self.bet)
