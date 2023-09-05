import time
import Utils
import logging
from  PGConnector import PGConnector
from BetRow import BetRow
from Browser import Browser
from datetime import datetime
from DailyMatchRow import DailyMatchRow
from selenium.webdriver.common.by import By
from threading import Thread
from selenium.common.exceptions import NoSuchElementException
import pprint

db = None
page = None
match = None
ou1p5Tab = None
ou2p5Tab = None

def check_exists_by_xpath(element, xpath):
        try:
            element.find_element(By.XPATH, xpath)
        except NoSuchElementException:
            return False
        return True

def sleep(x=60):
    time.sleep(x)

def getMatchTime(live_match):
    return live_match.find_element(By.XPATH, './a/div/div[1]/div').text.strip().split('´')[0]

def getTotalGoals(live_match):
    score_element = live_match.find_element(By.XPATH, './a/div/div[3]/span').text.strip()
    home_goals, away_goals = score_element.split('-')
    return int(home_goals) + int(away_goals)

def expandTabsOfInterest(page, browser):
    global ou2p5Tab, ou1p5Tab
    for i in range(1, 10):
        tab = None
        try:
            tab = page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div/div[1]/div[1]' % i)
        except:
            continue
        tabText = tab.text.strip()
        if tabText == 'Over/Under 2.5 Goals':
            browser.scroll_move_left_click(tab)
            ou2p5Tab = page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div' % i)
            logging.debug("ou2p5Tab found")
        if tabText == 'Over/Under 1.5 Goals':
            browser.scroll_move_left_click(tab)
            ou1p5Tab = page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div' % i)
            logging.debug("ou1p5Tab found")


def logBet(layback, overUnder, goals, odds, odds_recorded, amount):
    global db, match
    #pp = pprint.PrettyPrinter(indent=4)
    bet = BetRow()
    bet.set("MatchDateTime", match.get("date_time"))
    bet.set("Home", match.get("home"))
    bet.set("Away", match.get("away"))
    bet.set("LayBack", layback)
    bet.set("OverUnder", overUnder)
    bet.set("Goals", goals)
    bet.set("Odds", odds)
    bet.set("OddsRecorded", odds_recorded)
    bet.set("Amount", amount)
    db.insert(bet)
    logging.debug("Bet placed: %s", str(bet))

def placeBet(tab, layback, overUnder, goals, odds, odds_recorded, amount):
    global page
    suspended_xpath = '//*[@id="multiMarketContainer"]/div[5]/div[2]/div/div/text()'
    while check_exists_by_xpath(page, suspended_xpath) and page.find_element(By.XPATH, suspended_xpath).text == "SUSPENDED":
        logging.debug("Supsension detected")
        sleep(2)
    div_palce_bet_button = 1
    if layback == 'Lay': 
        div_palce_bet_button = 2
    tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[' + str(div_palce_bet_button) + ']/button' ).click() #Place bet button
    tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input' ).send_keys(str(odds))  #odds
    tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input' ).send_keys(str(6))  #stake
    tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button').click()  #bet button
    #TODO: Monitor for when the bet Wins
    logBet(layback, overUnder, goals, odds, odds_recorded, amount)


def layUnder1p5at1p5():
    global ou1p5Tab, match
    odds = getLayUnder1p5Odds()
    placeBet(ou1p5Tab, 'Lay', 'Under', 1.5, 1.5, odds, 1)
    logging.info('[%s VS %s] betted Lay Under 1.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def layUnder2p5at1p5():
    global ou2p5Tab, match
    odds = getLayUnder2p5Odds()
    placeBet(ou2p5Tab,  'Lay', 'Under', 2.5, 1.5, odds, 1)
    logging.info('[%s VS %s] betted Lay Under 2.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def backUnder1p5at1p5():
    global ou1p5Tab, match
    odds = getBackUnder1p5Odds()
    placeBet(ou1p5Tab, 'Back', 'Under', 1.5, 1.5, odds, 1)
    logging.info('[%s VS %s] betted Back Under 1.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def backUnder2p5at1p5():
    global ou2p5Tab, match
    odds = getBackUnder2p5Odds()
    placeBet(ou2p5Tab, 'Back', 'Under', 2.5, 1, odds, 1)
    logging.info('[%s VS %s] betted Back Under 2.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def backUnder1p5():
    global ou1p5Tab, match
    odds = getBackUnder1p5Odds()
    placeBet(ou1p5Tab, 'Back', 'Under', 1.5, 1, odds, 1)
    logging.info('[%s VS %s] betted Back Under 1.5 @ any odds [%s]' % (match.get("home"), match.get("away"), odds))

def backUnder2p5():
    global ou2p5Tab, match
    odds = getBackUnder2p5Odds()
    placeBet(ou2p5Tab, 'Back', 'Under', 2.5, 1, odds, 1)
    logging.info('[%s VS %s] betted Back Under 2.5 @ any odds [%s]' % (match.get("home"), match.get("away"), odds))
    return float(odds)
    
def getLayUnder1p5Odds():
    global ou1p5Tab
    return float(ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button/span/div/span[1]').text)

def getLayUnder2p5Odds():
    global ou2p5Tab
    return float(ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button/span/div/span[1]').text)

def getBackUnder1p5Odds():
    global ou1p5Tab
    return float(ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button/span/div/span[1]').text)

def getBackUnder2p5Odds():
    global ou2p5Tab
    return float(ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button/span/div/span[1]').text)

def loginToExchange(page, browser):
    form = page.find_element(By.XPATH, '//div[@id="biab_login-block"]/form') # Login
    form.find_element(By.XPATH, './div/input[1]').send_keys("voyager2007")
    form.find_element(By.XPATH, './div/input[2]').send_keys("Zisis1975€€€")
    form.find_element(By.XPATH, './div/button').click()
    if browser.wait_for_element_to_appear('//div[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button') is not None:
        page.find_element(By.XPATH, '//div[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button').click()
    sleep(6)

def monitorMatch(match_id, url = ''):
    global db, match, page
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)
    global ou2p5Tab, ou1p5Tab

    match = DailyMatchRow()
    if len(url) == 0:
        row = db.select("SELECT date_time, home, away, url FROM " + match.table_name + " WHERE id = '%s';" % (match_id,))
        if row and len(row) > 0:
            match.set("date_time", str(row[0][0]))
            match.set("home",      str(row[0][1]))
            match.set("away",      str(row[0][2]))
            match.set("url",       str(row[0][3]))
            url = match.get("url")
            db.delete(match, 'where id = %s' %(match_id,))
    else:
        pass

    browser = Browser()
    if len(url):
        page = browser.get(url)
        sleep(4)
        loginToExchange(page, browser)
        page.refresh()
        sleep(10)
        browser.accept_cookies('//*[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button')
    else:
        logging.error('[%s VS %s] Failure: URL is blank')
        return



    if len(url) and not match_id:
        match.set("home", page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[1]/div[1]/div').text)
        match.set("away", page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[1]/div[1]/div').text)
        match.set("url",  url)

    expandTabsOfInterest(page, browser)

    logging.info('[%s VS %s] Starting match : %s' % (match.get("home"), match.get("away"), url))

    live_browser = Browser()
    live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
    live_browser.accept_cookies('/html/body/div[5]/div[2]/div[1]/div[2]/div[2]/button[1]')

    live_match = None

    live_games = live_page.find_elements(By.CLASS_NAME, 'poolList')
    for lg in live_games:
        home = lg.find_element(By.XPATH, './a/div/div[2]')
        away = lg.find_element(By.XPATH, './a/div/div[4]')
        tmp_match = DailyMatchRow()
        tmp_match.set("home", home)
        tmp_match.set("away", away)
        if tmp_match.equals(match):
            live_match = lg
            break

    if live_match is None:
        logging.error("Failed to get live match")
        return

    time_strings = ['ST', 'HT', 'FT']
    while getMatchTime(live_match) in time_strings:
        sleep()

    logging.info('[%s VS %s] Time is not in strings : %s' % (match.get("home"), match.get("away"), url))

    timeout = 15
    while not getMatchTime(live_match).isnumeric(): # in case the time has not appeared yet
        sleep()
        timeout -= 1
        if timeout <= 0:
            logging.error('[%s VS %s] Failed to get match time after 15 mins. : %s' % (match.get("home"), match.get("away"), url))
            return
    
    logging.info('[%s VS %s] Time is numeric : %s' % (match.get("home"), match.get("away"), url))

    while getMatchTime(live_match).isnumeric() and int(getMatchTime(live_match)) <= 45:
        sleep()

    logging.info('[%s VS %s] Half Time passed : %s' % (match.get("home"), match.get("away"), url))
    sleep()
    while not getMatchTime(live_match).isnumeric():
        sleep()
    
    minute = getMatchTime(live_match)
    while int(minute) <= 46:
        sleep()
        minute = getMatchTime(live_match)

    logging.info('[%s VS %s] Goals @ 46 mins [%s] : %s' % (match.get("home"), match.get("away"), str(getTotalGoals(live_match)), url))
    
    if getTotalGoals(live_match) == 0:
        layUnder1p5at1p5()
        logging.info('[%s VS %s] Initial bet played : %s' % (match.get("home"), match.get("away"), url))

        while getTotalGoals(live_match) == 0 and str(getMatchTime(live_match)) != 'FT':
            if getLayUnder1p5Odds() <= 1.15:
                backUnder1p5()
                logging.info('[%s VS %s] Lay Under 1.5 Odds dropped below 1.15. : %s' % (match.get("home"), match.get("away"), url))
                return 
            sleep()

        if str(getMatchTime(live_match)) != 'FT':
                logging.info('[%s VS %s] Goal detected. : %s' % (match.get("home"), match.get("away"), url))

        while getTotalGoals(live_match) == 1 and str(getMatchTime(live_match)) != 'FT':
            if getBackUnder1p5Odds() <= 1.52:
                backUnder1p5at1p5()
                logging.info('[%s VS %s] Back Under 1.5 Odds dropped below 1.52. : %s' % (match.get("home"), match.get("away"), url))
                return
            sleep()

    elif getTotalGoals(live_match) == 1:
        layUnder2p5at1p5()
        logging.info('[%s VS %s] Initial bet played. : %s' % (match.get("home"), match.get("away"), url))
        
        while getTotalGoals(live_match) == 1 and str(getMatchTime(live_match)) != 'FT':
            if getLayUnder2p5Odds() <= 1.15:
                backUnder2p5()
                logging.info('[%s VS %s] Lay Under 2.5 Odds dropped below 1.15. : %s' % (match.get("home"), match.get("away"), url))
                return 
            sleep()

        if str(getMatchTime(live_match)) != 'FT':
                logging.info('[%s VS %s] Goal detected. : %s' % (match.get("home"), match.get("away"), url))

        while getTotalGoals(live_match) == 2 and str(getMatchTime(live_match)) != 'FT':
            if getBackUnder2p5Odds() <= 1.52:
                backUnder2p5at1p5()
                logging.info('[%s VS %s] Back Under 2.5 Odds dropped below 1.52. : %s' % (match.get("home"), match.get("away"), url))
                return 
            sleep()
    else:
        logging.info('[%s VS %s] 2 or more goals scored already. : %s' % (match.get("home"), match.get("away"), url))
        return

    logging.info('[%s VS %s] Game finished with [%s] goals : %s' % (match.get("home"), match.get("away"), url, getTotalGoals(live_match)))
