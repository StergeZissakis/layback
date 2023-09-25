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
    betslips = None

    def __init__(self, db, browser, page, bet):
        self.db = db
        self.browser = browser
        self.page = page
        self.bet = bet

    def prepare(self):
        betslipsPath = '//*[@id="biab_body"]/div[2]/div[2]/div/div/div/div[1]/div[2]/div'
        if not self.browser.check_exists_by_xpath(self.page, betslipsPath):
            logging.error("BetMonitor failed to locate betslips: %s" % self.bet)
            return False
        self.betslips = self.page.find_element(By.XPATH, betslipsPath)
        return True

    def locateBet(self):
        event_name = self.bet.get("Home") + " v " + self.bet.get("Away")
        while self.betslips is None:
            self.prepare()
            Utils.sleep_for_seconds(1)

        for div in self.betslips.find_elements(By.XPATH, './div'):    # tODO unable to locate
            for innerDiv in div.find_element(By.XPATH, './div'):
                div_event_name = innerDiv.get_attribute('data-event-name')
                if div_event_name is not None and div_event_name == event_name: # bet located
                    betId = innerDiv.get_attribute('data-offer-id')
                    betTime = innerDiv.get_attribute('data-placed-date')
                    statusDiv = innerDiv.find_element(By.XPATH, './div/div')
                    statusDivClasses = statusDiv.get_attribute('class').split()
                    if 'biab_unmatched' in statusDivClasses:
                        matched = False
                    elif 'biab_matched' in statusDivClasses:
                        matched = True
                    else:
                        continue
                    return BetStatus(betId, betTime, matched)

        return None

    def monitor(self):
        timeout = 30
        bet = self.locateBet()
        retries = 0
        while bet is None:
            Utils.sleep_for_seconds(1)
            bet = self.locateBet()
            retries += 1
            if retries > timeout:
                return "Not found"

        if bet.matched:
            self.updateBet(bet)
            return "Matched"

        if self.bet is None:
            self.bet = bet

        Utils.sleep_for_seconds(1)
        bet = self.locateBet()
        while bet and bet == self.bet:
            Utils.sleep_for_seconds(1)
            bet = self.locateBet()

        if bet is None: # lapsed
            bet = BetStatus(self.bet.id, self.bet.placedTime, self.bet.matched, True )
            self.updateBet(bet)
            return "Lapsed"

        if bet.matched:
            self.updateBet(bet)
            return "matched"

        return "Unknown"

    def updateBet(self, betStatus):
        self.bet.set("BetDateTime", datetime.fromtimestamp(betStatus.placedTime))
        self.bet.set("BetId", betStatus.id)
        if betStatus.lasped:
            self.bet.set("BetResult", 'Lapsed')
        if betStatus.lasped or betStatus.matched:
            self.bet.set("BetResultTime", datetime.now())
        self.db.update(self.bet)
