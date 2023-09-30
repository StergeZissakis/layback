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
    placedTime = None
    matched = False
    lasped = False

    def __init__(self, placedTime, matched, lapsed=False):
        self.placedTime = placedTime
        self.matched = matched
        self.lasped = lapsed


class BetMonitor:
    db = None
    browser = None
    page = None
    bet = None

    def __init__(self, db, browser, page, bet):
        self.db = db
        self.browser = browser
        self.page = page
        self.bet = bet

    def getBetStatus(self):
        event_name = self.bet.get("Home") + " v " + self.bet.get("Away")
        try:
            betSlipDiv = self.page.find_elements(By.XPATH, '//*[@data-event-name="' + event_name + '"]')[0]
            betTime = int(betSlipDiv.get_attribute('data-placed-date'))
            statusDiv = betSlipDiv.find_element(By.XPATH, './div/div')
            statusDivClasses = statusDiv.get_attribute('class').split()
            matched = False
            if 'biab_matched' in statusDivClasses:
                matched = True
            return BetStatus(betTime, matched)
        except Exception as Argument:
            logging.debug("Failed to get betslip status: %s" % event_name)
        return None

    def monitor(self):
        logging.info("Waiting for bet to appear: %s" % self.bet)
        #Wait for be to appear
        timeout = 60
        while self.getBetStatus() == None:
            Utils.sleep_for_seconds(1)
            timeout -= 1
            if timeout <= 0:
                logging.info("Bet failed to appear after 1 minute. Lapsing: %s" % self.bet)
                return "Lasped"

        logging.info("Bet appeared: %s" % self.bet)

        status = self.getBetStatus()
        if status.matched:
            self.updateBet(status)
            logging.info("Bet matched since it appeared: %s" % self.bet)
            return "Matched"

        logging.info("Bet not matched: %s" % self.bet)

        status = self.getBetStatus()
        lastKnownExistingStatus = status
        while status is not None and status.matched is False:
            Utils.sleep_for_seconds(1)
            status = self.getBetStatus()
            if status is not None and status.matched:
                self.updateBet(status)
                logging.info("Bet matched after unmatched: %s" % self.bet)
                return "Matched"
            elif status is None:
                lastKnownExistingStatus.lasped = True
                self.updateBet(lastKnownExistingStatus)
                logging.info("Bet lapsed after unmatched: %s" % self.bet)
                return "Lapsed"
            if status is not None:
                lastKnownExistingStatus = status

        if status is None:
            lastKnownExistingStatus.lasped = True
            self.updateBet(lastKnownExistingStatus)
            logging.info("Bet lasped after unmatched2: %s" % self.bet)
            return "Lasped"

        if status.matched is True:
            self.updateBet(status)
            logging.info("Bet matched last resort: %s" % self.bet)
            return "Matched"

        return "Laspsed"

    def updateBet(self, betStatus):
        self.bet.set("BetDateTime", datetime.fromtimestamp(betStatus.placedTime / 1000)) #Orbit epoch is in milliseconds
        if betStatus.lasped:
            self.bet.set("BetResult", 'Lapsed')
        if betStatus.lasped or betStatus.matched:
            self.bet.set("BetResultTime", datetime.now())
        self.db.update(self.bet)
