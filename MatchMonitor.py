import sys
from datetime import datetime
import logging
import Utils
from BetMonitor import BetMonitor
from LiveMatch import APILivePage
from PGConnector import PGConnector
from BetRow import BetRow
from Browser import Browser
from selenium.webdriver.common.by import By
# from selenium.common.exceptions import NoSuchElementException


class MatchMonitor:

    db = None
    browser = None
    page = None
    match = None
    ou1p5Tab = None
    ou2p5Tab = None
    username = "voyager2007"
    password = "Zisis1975€€€"
    livePage = None
    liveMatch = None
    eurosToBet = None

    def __init__(self, match):
        self.match = match
        self.browser = Browser()
        self.eurosToBet = 5

    def __del__(self):
        if self.browser and self.browser.headless:
            self.browser.quit()

    @staticmethod
    def sleep(x=60):
        Utils.sleep_for_seconds(x)

    def expandTabsOfInterest(self):
        self.sleep(4)
        for i in range(1, 10):
            if not self.browser.check_exists_by_xpath(self.page, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div/div[1]/div[1]' % i):
                continue
            tab = self.page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div/div[1]/div[1]' % i)
            self.browser.scroll_to_visible(tab, True)
            tabText = tab.text.strip()
            if tabText == 'Over/Under 2.5 Goals' and self.ou2p5Tab is None:
                self.browser.scroll_move_left_click(tab)
                self.ou2p5Tab = self.page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div' % i)
                logging.debug("ou2p5Tab found")
                continue
            if tabText == 'Over/Under 1.5 Goals' and self.ou1p5Tab is None:
                self.browser.scroll_move_left_click(tab)
                self.ou1p5Tab = self.page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div' % i)
                logging.debug("ou1p5Tab found")
                continue
            if self.ou2p5Tab is not None and self.ou1p5Tab is not None:
                break
        ret = True
        if self.ou2p5Tab is None:
            logging.error("Failed to get OverUnder 2.5 Tab")
            ret = False
        if self.ou1p5Tab is None:
            logging.error("Failed to get OverUnder 1.5 Tab")
            ret = False
        return ret

    def checkForSuspendedAndWait(self):
        suspended_xpath = '//*[@id="multiMarketContainer"]/div[5]/div[2]/div/div'
        seconds_count = 0
        while self.browser.check_exists_by_xpath(self.page, suspended_xpath) and self.page.find_element(By.XPATH, suspended_xpath).text == "SUSPENDED":
            Utils.sleep_for_seconds(1)
            seconds_count += 1
            if seconds_count > 900:  # 15 mins
                logging.info("Match suspended for more than 10 minutes [%s]. Quiting..." % self.match)
                sys.exit(2)

    def placeBet(self, tab, layback, overUnder, goals, odds, odds_recorded, amount):
        div_place_bet_button = 1
        if layback == 'Lay':
            div_place_bet_button = 2
        count = 0
        while True:
            try:
                self.checkForSuspendedAndWait()
                tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[%s]/button' % str(div_place_bet_button)).click()  # Place bet button
                self.checkForSuspendedAndWait()
                tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input').send_keys(str(odds))  # odds
                self.checkForSuspendedAndWait()
                tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input').send_keys(Utils.calculateStakeFor(amount, odds))  # stake
                self.checkForSuspendedAndWait()
                tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button').click()  # bet button
                break
            except Exception as Argument:
                self.sleep(1)
                logging.debug("Error during placeBet: %s -> %s" % (self.match, Argument))
                count += 1
                if count >= 600:
                    logging.error("Error during placeBet - Max timeout reached : %s" % self.match)
                    sys.exit(3)
                continue

        bet = self.logBet(layback, overUnder, goals, odds, odds_recorded, amount)
        self.monitorBet(bet)

    def extractOrbitTeamNames(self):
        home = None
        away = None
        homepath = '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[1]/div[1]/div'
        awaypath = '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[3]/div[1]/div'
        if self.browser.check_exists_by_xpath(self.page, homepath) and self.browser.check_exists_by_xpath(self.page, awaypath):
            home = self.page.find_element(By.XPATH, homepath).text.strip()
            away = self.page.find_element(By.XPATH, awaypath).text.strip()
        else:
            teamspath = '//*[@id="multiMarketContainer"]/div[1]/div/div[1]/div/h2'
            if self.browser.check_exists_by_xpath(self.page, teamspath):
                teams = self.page.find_element(By.XPATH, teamspath)
                home, away = teams.text.split(' v ')
                home = home.strip()
                away = away.strip()
            else:
                logging.error('Failed to extract bet team names: %s' % self.match)
        return home, away

    def logBet(self, layback, overUnder, goals, odds, odds_recorded, amount):
        home, away = self.extractOrbitTeamNames()
        if home is None:  # best effort
            home = self.match.get("home")
        if away is None:
            away = self.match.get("away")
        bet = BetRow()
        bet.set("MatchDateTime", self.match.get("date_time"))
        bet.set("Home", home)
        bet.set("Away", away)
        bet.set("BetDateTime", datetime.now())
        bet.set("LayBack", layback)
        bet.set("OverUnder", overUnder)
        bet.set("Goals", goals)
        bet.set("Odds", odds)
        bet.set("OddsRecorded", odds_recorded)
        bet.set("Amount", amount)
        self.db.insert_or_update(bet)
        logging.debug("Bet placed: %s", str(bet))
        return bet

    def monitorBet(self, bet):
        bm = BetMonitor(self.db, self.browser, self.page, bet)
        if not bm.prepare():
            return
        betStatus = bm.monitor()
        logging.info('Bet Status [%s] of [%s]' % (betStatus, self.match))

    def layUnder1p5at1p5(self, euros):
        self.placeBet(self.ou1p5Tab, 'Lay', 'Under', 1.5, 1.5, self.getLayUnder1p5Odds(), euros)
        logging.info('%s betted Lay Under 1.5 @ 1.5 odds' % self.match)

    def layUnder2p5at1p5(self, euros):
        self.placeBet(self.ou2p5Tab,  'Lay', 'Under', 2.5, 1.5, self.getLayUnder2p5Odds(), euros)
        logging.info('%s betted Lay Under 2.5 @ 1.5 odds' % self.match)

    def backUnder1p5at1p5(self, euros):
        self.placeBet(self.ou1p5Tab, 'Back', 'Under', 1.5, 1.5, self.getBackUnder1p5Odds(), euros)
        logging.info('%s betted Back Under 1.5 @ 1.5 odds' % self.match)

    def backUnder2p5at1p5(self, euros):
        odds = self.getBackUnder2p5Odds()
        self.placeBet(self.ou2p5Tab, 'Back', 'Under', 2.5, 1.5, odds, euros)
        logging.info('%s betted Back Under 2.5 @ 1.5 odds' % self.match)
        return float(odds)

    def backUnder1p5(self, euros):
        odds = self.getBackUnder1p5Odds()
        self.placeBet(self.ou1p5Tab, 'Back', 'Under', 1.5, odds, odds, euros)
        logging.info('%s betted Back Under 1.5 @ [%s] odds ' % (self.match, odds))
        return float(odds)

    def backUnder2p5(self, euros):
        odds = self.getBackUnder2p5Odds()
        self.placeBet(self.ou2p5Tab, 'Back', 'Under', 2.5, odds, odds, euros)
        logging.info('%s betted Back Under 2.5 @ any [%s] odds ' % (self.match, odds))
        return float(odds)

    def getLayUnder1p5Odds(self):
        self.checkForSuspendedAndWait()
        return float(self.ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button/span/div/span[1]').text)

    def getLayUnder2p5Odds(self):
        self.checkForSuspendedAndWait()
        return float(self.ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button/span/div/span[1]').text)

    def getBackUnder1p5Odds(self):
        self.checkForSuspendedAndWait()
        return float(self.ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button/span/div/span[1]').text)

    def getBackUnder2p5Odds(self):
        self.checkForSuspendedAndWait()
        return float(self.ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button/span/div/span[1]').text)

    def loginToExchange(self):
        form = self.page.find_element(By.XPATH, '//div[@id="biab_login-block"]/form')  # Login
        form.find_element(By.XPATH, './div/input[1]').send_keys(self.username)
        Utils.sleep_for_millis_random(500)
        form.find_element(By.XPATH, './div/input[2]').send_keys(self.password)
        Utils.sleep_for_millis_random(500)
        form.find_element(By.XPATH, './div/button').click()
        # Click the OK tha appears
        self.browser.accept_cookies('//*[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button')

    def startMonitor(self):
        self.db = PGConnector("postgres", "localhost")
        if not self.db.is_connected():
            logging.error("%s - Failed to connect to DB" % self.match)
            exit(-1)

        self.page = self.browser.get(self.match.get("url"))
        Utils.sleep_for_seconds(3)
        self.loginToExchange()

        if self.browser.check_exists_by_xpath(self.page, '//*[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button'):
            self.browser.accept_cookies('//*[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button')

        retryCount = 0
        while not self.expandTabsOfInterest():
            logging.error('Failed to expand tabs: %s' % self.match)
            self.page = self.browser.get(self.match.get("url"))
            self.sleep(2)
            retryCount += 1
            if retryCount > 10:
                logging.info('Failed to get over under tabs after 10 retries. Possibly 2 goals already scored : %s' % self.match)
                return

        logging.info('Starting : %s' % self.match)

        self.livePage = APILivePage(self.match)
        if not self.livePage.canBeMonitored():
            logging.error('Live Match capture failed : %s' % self.match)
            return

        logging.info("Checking for not started->%s" % self.match)
        while self.livePage.getMatchStatus() == "NS":
            self.sleep()

        logging.info("Waiting for 1st half to finish->%s" % self.match)
        while self.livePage.getMatchStatus() == "1H":
            self.sleep()

        logging.info("Waiting for half time to finish->%s" % self.match)
        while self.livePage.getMatchStatus() == "HT":
            self.sleep()

        logging.info("Waiting for 2nd half to start->%s" % self.match)
        while self.livePage.getMatchStatus() != "2H":
            self.sleep()

        logging.info("2nd half started->%s" % self.match)
        while self.livePage.getMatchTime() < 55:
            self.sleep()

        self.match.set("ht_goals", self.livePage.getTotalGoals())
        self.db.update(self.match)

        if self.livePage.getMatchStatus() == 'FT':
            logging.error("Match ended prematurely->%s" % self.match)
            self.match.set("ft_goals", self.livePage.getTotalGoals())
            self.db.update(self.match)
            return

        if self.livePage.getTotalGoals() == 0:
            self.layUnder1p5at1p5(self.eurosToBet)
            logging.info('Initial bet played : %s' % self.match)
    
            while self.livePage.getTotalGoals() == 0 and self.livePage.getMatchStatus() != 'FT':
                if self.getLayUnder1p5Odds() <= 1.15:
                    self.backUnder1p5(self.eurosToBet)
                    logging.info('Lay Under 1.5 Odds dropped below 1.15. : %s' % self.match)
                    break
                self.sleep()

            if self.livePage.getMatchStatus() != 'FT':
                logging.info('Goal detected : %s' % self.match)
    
            while self.livePage.getTotalGoals() == 1 and self.livePage.getMatchStatus() != 'FT':
                if self.getBackUnder1p5Odds() <= 1.52:
                    self.backUnder1p5at1p5(self.eurosToBet)
                    logging.info('Back Under 1.5 Odds dropped below 1.52. : %s' % self.match)
                    break
                self.sleep()
    
        elif self.livePage.getTotalGoals() == 1:
            self.layUnder2p5at1p5(self.eurosToBet)
            logging.info('Initial bet played. : %s' % self.match)
            
            while self.livePage.getTotalGoals() == 1 and self.livePage.getMatchStatus() != 'FT':
                if self.getLayUnder2p5Odds() <= 1.15:
                    self.backUnder2p5(self.eurosToBet)
                    logging.info('Lay Under 2.5 Odds dropped below 1.15. : %s' % self.match)
                    break
                self.sleep()

            if self.livePage.getMatchStatus() != 'FT':
                logging.info('Goal detected. : %s' % self.match)
    
            while self.livePage.getTotalGoals() == 2 and self.livePage.getMatchStatus() != 'FT':
                if self.getBackUnder2p5Odds() <= 1.52:
                    self.backUnder2p5at1p5(self.eurosToBet)
                    logging.info('Back Under 2.5 Odds dropped below 1.52. : %s' % self.match)
                    break
                self.sleep()
    
        else:
            logging.info('2 or more goals scored already. : %s' % self.match)

        logging.info("Waiting for match to end->%s" % self.match)
        while self.livePage.getMatchStatus() != "FT":
            self.sleep()

        self.match.set("ft_goals", self.livePage.getTotalGoals())
        self.db.update(self.match)
        logging.info('Game %s finished with goals : %s' % (self.match, self.livePage.getTotalGoals()))


def monitor(match):
    mm = MatchMonitor(match)
    mm.startMonitor()
