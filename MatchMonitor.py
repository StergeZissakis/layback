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
    try:
        return live_match.find_element(By.XPATH, './a/div/div[1]/div').text.strip().split('´')[0]
    except:
        sleep(2)
    finally:
        return live_match.find_element(By.XPATH, './a/div/div[1]/div').text.strip().split('´')[0]

def getTotalGoals(live_match):
    score_element = live_match.find_element(By.XPATH, './a/div/div[3]/span').text.strip()
    home_goals, away_goals = score_element.split('-')
    return int(home_goals) + int(away_goals)

def find_live_match(live_page):
    global match
    live_games = live_page.find_elements(By.CLASS_NAME, 'poolList')
    for lg in live_games:
        home = lg.find_element(By.XPATH, './a/div/div[2]').text.strip().lower()
        away = lg.find_element(By.XPATH, './a/div/div[4]').text.strip().lower()
        if home == match.get("home").lower() or away == match.get("away").lower():
            return lg

    logging.error("Failed to get live match")
    return None

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
    suspended_xpath = '//*[@id="multiMarketContainer"]/div[5]/div[2]/div/div'
    while check_exists_by_xpath(page, suspended_xpath): #and page.find_element(By.XPATH, suspended_xpath).text == "SUSPENDED":
        logging.debug("Supsension detected")
        sleep(2)
    div_palce_bet_button = 1
    if layback == 'Lay': 
        div_palce_bet_button = 2
    tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[%s]/button' % (str(div_palce_bet_button),) ).click() #Place bet button
    sleep(1)
    tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input' ).send_keys(str(odds))  #odds
    tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input' ).send_keys(str(6))  #stake
    tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button').click()  #bet button
    #TODO: Monitor for when the bet Wins
    logBet(layback, overUnder, goals, odds, odds_recorded, amount)


def layUnder1p5at1p5():
    global ou1p5Tab, match
    odds = getLayUnder1p5Odds()
    placeBet(ou1p5Tab, 'Lay', 'Under', 1.5, 1.5, odds, 1)
    logging.info('%s betted Lay Under 1.5 @ 1.5 odds' % (str(match)))

def layUnder2p5at1p5():
    global ou2p5Tab, match
    odds = getLayUnder2p5Odds()
    placeBet(ou2p5Tab,  'Lay', 'Under', 2.5, 1.5, odds, 1)
    logging.info('%s betted Lay Under 2.5 @ 1.5 odds' % (str(match)))

def backUnder1p5at1p5():
    global ou1p5Tab, match
    odds = getBackUnder1p5Odds()
    placeBet(ou1p5Tab, 'Back', 'Under', 1.5, 1.5, odds, 1)
    logging.info('%s betted Back Under 1.5 @ 1.5 odds' % (str(match)))

def backUnder2p5at1p5():
    global ou2p5Tab, match
    odds = getBackUnder2p5Odds()
    placeBet(ou2p5Tab, 'Back', 'Under', 2.5, 1, odds, 1)
    logging.info('%s betted Back Under 2.5 @ 1.5 odds' % (str(match)))

def backUnder1p5():
    global ou1p5Tab, match
    odds = getBackUnder1p5Odds()
    placeBet(ou1p5Tab, 'Back', 'Under', 1.5, 1, odds, 1)
    logging.info('%s betted Back Under 1.5 @ any odds [%s]' % (str(match), odds))

def backUnder2p5():
    global ou2p5Tab, match
    odds = getBackUnder2p5Odds()
    placeBet(ou2p5Tab, 'Back', 'Under', 2.5, 1, odds, 1)
    logging.info('%s betted Back Under 2.5 @ any odds [%s]' % (str(match), odds))
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

def monitorMatch(m, url = ''):
    global db, match, page
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)
    global ou2p5Tab, ou1p5Tab

    match = m
    if len(url) == 0:
        url = m.get("url")
        #db.delete(match, 'where id = %s' %(match_id,))
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
        if browser.headless: browser.quit()
        return



    if len(url) and not m:
        match.set("home", page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[1]/div[1]/div').text)
        match.set("away", page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[1]/div[1]/div').text)
        match.set("url",  url)

    expandTabsOfInterest(page, browser)

    logging.info('Starting match : %s' % (str(match),))

    live_browser = Browser()
    live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
    live_browser.accept_cookies('/html/body/div[5]/div[2]/div[1]/div[2]/div[2]/button[1]')

    live_match = find_live_match(live_page)

    timeout = 15
    while not getMatchTime(live_match).isnumeric(): # in case the time has not appeared yet
        logging.info('Time is not numeric : %s' % (str(match),))
        sleep()
        timeout -= 1
        if timeout <= 0:
            logging.error('Failed to get match time after 15 mins. : %s' % (str(match),))
            if browser.headless: browser.quit()
            return
        live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
        live_match = find_live_match(live_page)
    
    logging.info('Time is numeric : %s' % (str(match),))

    while getMatchTime(live_match).isnumeric() and int(getMatchTime(live_match)) <= 45:
        sleep()
        live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
        live_match = find_live_match(live_page)

    logging.info('Half Time passed : %s' % (str(match),))
    sleep()
    live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
    live_match = find_live_match(live_page)
    while not getMatchTime(live_match).isnumeric():
        sleep()
        live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
        live_match = find_live_match(live_page)
    
    minute = getMatchTime(live_match)
    while int(minute) <= 46:
        sleep()
        live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
        live_match = find_live_match(live_page)
        minute = getMatchTime(live_match)

    logging.info('Goals of %s  @ 46 mins : %s' % (str(match), str(getTotalGoals(live_match))))
    
    if getTotalGoals(live_match) == 0:
        layUnder1p5at1p5()
        logging.info('Initial bet played : %s' % (str(match),))

        live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
        live_match = find_live_match(live_page)
        while getTotalGoals(live_match) == 0 and str(getMatchTime(live_match)) != 'FT':
            if getLayUnder1p5Odds() <= 1.15:
                backUnder1p5()
                logging.info('Lay Under 1.5 Odds dropped below 1.15. : %s' % (str(match),))
                if browser.headless: browser.quit()
                return 
            sleep()
            live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
            live_match = find_live_match(live_page)

        if str(getMatchTime(live_match)) != 'FT':
                logging.info('Goal detected : %s' % (str(match),))

        while getTotalGoals(live_match) == 1 and str(getMatchTime(live_match)) != 'FT':
            if getBackUnder1p5Odds() <= 1.52:
                backUnder1p5at1p5()
                logging.info('Back Under 1.5 Odds dropped below 1.52. : %s' % (str(match),))
                if browser.headless: browser.quit()
                return
            sleep()
            live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
            live_match = find_live_match(live_page)

    elif getTotalGoals(live_match) == 1:
        layUnder2p5at1p5()
        logging.info('Initial bet played. : %s' % (str(match),))
        
        live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
        live_match = find_live_match(live_page)
        while getTotalGoals(live_match) == 1 and str(getMatchTime(live_match)) != 'FT':
            if getLayUnder2p5Odds() <= 1.15:
                backUnder2p5()
                logging.info('Lay Under 2.5 Odds dropped below 1.15. : %s' % (str(match),))
                if browser.headless: browser.quit()
                return 
            sleep()
            live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
            live_match = find_live_match(live_page)

        if str(getMatchTime(live_match)) != 'FT':
                logging.info('Goal detected. : %s' % (str(match),))

        while getTotalGoals(live_match) == 2 and str(getMatchTime(live_match)) != 'FT':
            if getBackUnder2p5Odds() <= 1.52:
                backUnder2p5at1p5()
                logging.info('Back Under 2.5 Odds dropped below 1.52. : %s' % (str(match),))
                if browser.headless: browser.quit()
                return 
            sleep()
            live_page = live_browser.get('https://www.footballsuper.tips/live-scores/live/')
            live_match = find_live_match(live_page)
    else:
        logging.info('2 or more goals scored already. : %s' % (str(match),))
        if browser.headless: browser.quit()
        return

    logging.info('Game %s finished with goals : %s' % (str(match), getTotalGoals(live_match)))
    if browser.headless: browser.quit()
