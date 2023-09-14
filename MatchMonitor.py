import time
import logging
import pprint
import Utils 
from PGConnector import PGConnector
from BetRow import BetRow
from Browser import Browser
from datetime import datetime
from DailyMatchRow import DailyMatchRow
from selenium.webdriver.common.by import By
from threading import Thread
from selenium.common.exceptions import NoSuchElementException

class MatchMonitor:

    db = None
    browser = None
    page = None
    match = None
    ou1p5Tab = None
    ou2p5Tab = None
    username = "voyager2007" 
    password = "Zisis1975€€€"
    liveBrowser = None
    livePage = None
    liveMatch = None
    eurosToBet = None

    def __init__(self, match):
        self.match = match
        self.browser = Browser()
        self.liveBrowser = Browser()
        self.eurosToBet = 5

    def __del__(self):
        if self.browser and self.browser.headless: 
            self.browser.quit()
        if self.liveBrowser and self.liveBrowser.headless:
            self.liveBrowser.quit()

    def check_exists_by_xpath(self, element, xpath):
            try:
                element.find_element(By.XPATH, xpath)
            except NoSuchElementException:
                return False
            return True

    def sleep(self, x=60):
        Utils.sleep_for_seconds(x)

    def getMatchTime(self):
        try:
            return self.liveMatch.find_element(By.XPATH, './a/div/div[1]/div').text.strip().split('´')[0]
        except:
            Utils.sleep_for_seconds(2)
        finally:
            if not self.check_exists_by_xpath(self.liveMatch, './a/div/div[1]/div'):
                return None
        return self.liveMatch.find_element(By.XPATH, './a/div/div[1]/div').text.strip().split('´')[0]

    def getTotalGoals(self):
        if not self.check_exists_by_xpath(self.liveMatch, './a/div/div[3]/span'):
            return None
        score_element = self.liveMatch.find_element(By.XPATH, './a/div/div[3]/span').text.strip()
        home_goals, away_goals = score_element.split('-')
        return int(home_goals) + int(away_goals)

    def find_liveMatch(self):
        for lg in self.livePage.find_elements(By.CLASS_NAME, 'poolList'): #live games
            home = lg.find_element(By.XPATH, './a/div/div[2]').text.strip().lower()
            away = lg.find_element(By.XPATH, './a/div/div[4]').text.strip().lower()
            if home == self.match.get("home").lower() or away == self.match.get("away").lower(): # find the live match in the live page
                return lg

        logging.error("Failed to get live match")
        return None

    def expandTabsOfInterest(self):
        for i in range(1, 10):
            tab = None
            if not self.check_exists_by_xpath(self.page, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div/div[1]/div[1]' % i):
                continue
            tab = self.page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div/div[1]/div[1]' % i)
            tabText = tab.text.strip()
            if tabText == 'Over/Under 2.5 Goals' and self.ou2p5Tab is None:
                self.browser.scroll_move_left_click(tab)
                self.ou2p5Tab = self.page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div' % i)
                logging.debug("ou2p5Tab found")
            if tabText == 'Over/Under 1.5 Goals' and self.ou1p5Tab is None:
                self.browser.scroll_move_left_click(tab)
                self.ou1p5Tab = self.page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div' % i)
                logging.debug("ou1p5Tab found")
            if self.ou2p5Tab is not None and self.ou1p5Tab is not None:
                break

        if self.ou2p5Tab is None:
            logging.error("Failed to get OverUnder 2.5 Tab")
            return False
        if self.ou1p5Tab is None:
            logging.error("Failed to get OverUnder 1.5 Tab")
            return False
        return True

    def checkForSupspendedAndWait(self):
        suspended_xpath = '//*[@id="multiMarketContainer"]/div[5]/div[2]/div/div'
        while self.check_exists_by_xpath(self.page, suspended_xpath): #and page.find_element(By.XPATH, suspended_xpath).text == "SUSPENDED":
            logging.debug("Supsension detected")
            Utils.sleep_for_seconds(1)

    def placeBet(self, tab, layback, overUnder, goals, odds, odds_recorded, amount):
        div_palce_bet_button = 1
        if layback == 'Lay': 
            div_palce_bet_button = 2
        checkForSupspendedAndWait()
        tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[%s]/button' % str(div_palce_bet_button)).click() #Place bet button
        checkForSupspendedAndWait()
        tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input' ).send_keys(str(odds))  #odds
        checkForSupspendedAndWait()
        tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input' ).send_keys(Utils.calculateStakeFor(amount, odds))  #stake
        checkForSupspendedAndWait()
        tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button').click()  #bet button
        #TODO: ensure bet is placed
        bet = self.logBet(layback, overUnder, goals, odds, odds_recorded, amount)
        #TODO: Monitor for when it will be matched
        #get final result of bets
        monitorBetThread = Thread(target = self.monitorBet, args = (self, bet)) 
        monitorBetThread.start()
        #monitorBetThread.join() #TODO:?

    def logBet(self, layback, overUnder, goals, odds, odds_recorded, amount):
        #pp = pprint.PrettyPrinter(indent=4)
        bet = BetRow()
        bet.set("MatchDateTime", self.match.get("date_time"))
        bet.set("Home", self.match.get("home"))
        bet.set("Away", self.match.get("away"))
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
        #TODO
        pass

    def layUnder1p5at1p5(self, euros):
        self.placeBet(self.ou1p5Tab, 'Lay', 'Under', 1.5, 1.5, self.getLayUnder1p5Odds(), euros)
        logging.info('%s betted Lay Under 1.5 @ 1.5 odds' % self.match)

    def layUnder2p5at1p5(self, euros):
        self.placeBet(self.ou2p5Tab,  'Lay', 'Under', 2.5, 1.5, self.getLayUnder2p5Odds(), euros)
        logging.info('%s betted Lay Under 2.5 @ 1.5 odds' % (self.match))

    def backUnder1p5at1p5(self, euros):
        self.placeBet(self.ou1p5Tab, 'Back', 'Under', 1.5, 1.5, self.getBackUnder1p5Odds(), euros)
        logging.info('%s betted Back Under 1.5 @ 1.5 odds' % (self.match))

    def backUnder2p5at1p5(self, euros):
        odds = self.getBackUnder2p5Odds()
        self.placeBet(self.ou2p5Tab, 'Back', 'Under', 2.5, odds, odds, euros)
        logging.info('%s betted Back Under 2.5 @ 1.5 odds' % (self.match))
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
        self.checkForSupspendedAndWait()
        return float(self.ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button/span/div/span[1]').text)

    def getLayUnder2p5Odds(self):
        self.checkForSupspendedAndWait()
        return float(self.ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button/span/div/span[1]').text)

    def getBackUnder1p5Odds(self):
        self.checkForSupspendedAndWait()
        return float(self.ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button/span/div/span[1]').text)

    def getBackUnder2p5Odds(self):
        self.checkForSupspendedAndWait()
        return float(self.ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button/span/div/span[1]').text)

    def loginToExchange(self):
        form = self.page.find_element(By.XPATH, '//div[@id="biab_login-block"]/form') # Login
        form.find_element(By.XPATH, './div/input[1]').send_keys(self.username)
        Utils.sleep_for_millis_random(500)
        form.find_element(By.XPATH, './div/input[2]').send_keys(self.password)
        Utils.sleep_for_millis_random(500)
        form.find_element(By.XPATH, './div/button').click()
        #Click the OK tha appears
        self.browser.accept_cookies('//*[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button')
    
    def refreshLiveMatch(self):
        self.livePage = self.liveBrowser.get('https://www.footballsuper.tips/live-scores/live/')
        self.liveMatch = self.find_liveMatch()
    
    def startMonitor(self):
        self.db = PGConnector("postgres", "localhost")
        if not self.db.is_connected():
            logging.error("%s - Failed to connect to DB" % self.match)
            exit(-1)
        
        self.page = self.browser.get(self.match.get("url"))
        Utils.sleep_for_seconds(3)
        self.loginToExchange()
        #self.page.refresh()
        #Utils.sleep_for_seconds(3)
        if self.check_exists_by_xpath(self.page, '//*[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button'):
            self.browser.accept_cookies('//*[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button')
    
        if self.expandTabsOfInterest() == False:
            logging.error('Match failed : %s' % self.match)
            return
    
        logging.info('Starting self.match : %s' % self.match)
    
        self.live_browser = Browser()
        self.livePage = self.live_browser.get('https://www.footballsuper.tips/live-scores/live/')
        self.live_browser.accept_cookies('/html/body/div[5]/div[2]/div[1]/div[2]/div[2]/button[1]')
    
        self.liveMatch = self.find_liveMatch()
        if self.liveMatch is None:
            logging.error('Live Match failed : %s' % self.match)
            return
    
        timeout = 15
        while not self.getMatchTime().isnumeric(): # in case the time has not appeared yet
            logging.info('Time is not numeric : %s' % self.match)
            self.sleep()
            timeout -= 1
            if timeout == 0:
                logging.error('Failed to get self.match time after 15 mins. : %s' % self.match)
                return
            self.refreshLiveMatch()
        
        logging.info('Time is numeric : %s' % self.match)
    
        matchTime = self.getMatchTime()
        while matchTime.isnumeric() and int(matchTime) <= 45:
            self.sleep()
            self.refreshLiveMatch()
    
        logging.info('1st Half passed : %s' % self.match)
        self.sleep(30)
        self.refreshLiveMatch()
    
        while not self.getMatchTime().isnumeric():
            self.sleep(30)
            self.refreshLiveMatch()
        
        logging.info('Beginning of 2nd Half : %s' % self.match)
    
        while int(self.getMatchTime()) <= 46:
            self.sleep(30)
            self.refreshLiveMatch()
    
        logging.info('Goals of %s  @ 46\' : %s' % (self.match, str(self.getTotalGoals())))
        
        if self.getTotalGoals() == 0:
            self.layUnder1p5at1p5(self.eurosToBet)
            logging.info('Initial bet played : %s' % self.match)
    
            self.refreshLiveMatch()
            while self.getTotalGoals() == 0 and str(self.getMatchTime()) != 'FT':
                if self.getLayUnder1p5Odds() <= 1.15:
                    self.backUnder1p5(self.eurosToBet)
                    logging.info('Lay Under 1.5 Odds dropped below 1.15. : %s' % self.match)
                    return 
                self.sleep()
                self.refreshLiveMatch()
    
            if str(self.getMatchTime()) != 'FT':
                logging.info('Goal detected : %s' % self.match)
    
            while self.getTotalGoals() == 1 and str(self.getMatchTime()) != 'FT':
                if self.getBackUnder1p5Odds() <= 1.52:
                    self.backUnder1p5at1p5(self.eurosToBet)
                    logging.info('Back Under 1.5 Odds dropped below 1.52. : %s' % self.match)
                    return
                self.sleep()
                self.refreshLiveMatch()
    
        elif self.getTotalGoals() == 1:
            self.layUnder2p5at1p5(self.eurosToBet)
            logging.info('Initial bet played. : %s' % self.match)
            
            self.refreshLiveMatch()
            while self.getTotalGoals() == 1 and str(self.getMatchTime()) != 'FT':
                if self.getLayUnder2p5Odds() <= 1.15:
                    self.backUnder2p5(self.eurosToBet)
                    logging.info('Lay Under 2.5 Odds dropped below 1.15. : %s' % self.match)
                    return 
                self.sleep()
                self.refreshLiveMatch()
    
            if str(self.getMatchTime()) != 'FT':
                logging.info('Goal detected. : %s' % self.match)
    
            while self.getTotalGoals() == 2 and str(self.getMatchTime()) != 'FT':
                if self.getBackUnder2p5Odds() <= 1.52:
                    self.backUnder2p5at1p5(self.eurosToBet)
                    logging.info('Back Under 2.5 Odds dropped below 1.52. : %s' % self.match)
                    return 
                self.sleep()
                self.refreshLiveMatch()
    
        else:
            logging.info('2 or more goals scored already. : %s' % self.match)
            return
    
        logging.info('Game %s finished with goals : %s' % (self.match, self.getTotalGoals()))
    
def monitor(match):
    mm = MatchMonitor(match)
    mm.startMonitor()
