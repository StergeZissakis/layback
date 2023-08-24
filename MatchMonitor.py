import time
import Utils
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

def getMatchTime(page):
    while check_exists_by_xpath(page, '//div[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[2]/div[2]') is False:
        sleep()

    rootElement = page.find_element(By.XPATH, '//div[@id="multiMarketContainer"]')
    tm = rootElement.find_element(By.XPATH, './div[1]/div[1]/div/div[2]/div[2]/div[2]').text.split("'")[0]

    return tm

def getTotalGoals(page):
    root = page.find_element(By.XPATH, '//div[@id="multiMarketContainer"]')
    home_goals = root.find_element(By.XPATH, './div[1]/div[1]/div/div[2]/div[2]/div[1]/span[1]').text
    away_goals = root.find_element(By.XPATH, './div[1]/div[1]/div/div[2]/div[2]/div[1]/span[3]').text
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
        if tabText == 'Over/Under 1.5 Goals':
            browser.scroll_move_left_click(tab)
            ou1p5Tab = page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[%s]/div' % i)


def logBet(layback, overUnder, goals, odds, odds_recorded, amount):
    global db, match
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

def placeBet(odds_input, stake_input, bet_button, layback, overUnder, goals, odds, odds_recorded, amount):
    while check_exists_by_xpath(page, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[5]/div/div[3]/div[3]/div/div') or \
        check_exists_by_xpath(page, '//*[@id="multiMarketContainer"]/div[5]/div[2]/div/div'):
        sleep(1)
    odds_input.send_keys(str(odds))
    stake_input.send_keys(str(amount))
    bet_button.click()
    #TODO: Monitor for when the bet Wins
    logBet(layback, overUnder, goals, odds, odds_recorded, amount)


def layUnder1p5at1p5():
    global ou1p5Tab, match
    odds = getLayUnder1p5Odds()
    ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button').click()
    placeBet(ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input'),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input'),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Lay', 'Under', 1.5, 1.5, odds, 1)
    print('[%s VS %s] betted Lay Under 1.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def layUnder2p5at1p5():
    global ou2p5Tab, match
    odds = getLayUnder2p5Odds()
    ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button').click()
    placeBet(ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input'),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input'),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Lay', 'Under', 2.5, 1.5, odds, 1)
    print('[%s VS %s] betted Lay Under 2.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def backUnder1p5at1p5():
    global ou1p5Tab, match
    odds = getBackUnder1p5Odds()
    ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button').click()
    placeBet(ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input'),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input'),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Back', 'Under', 1.5, 1.5, odds, 1)
    print('[%s VS %s] betted Back Under 1.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def backUnder2p5at1p5():
    global ou2p5Tab, match
    odds = getBackUnder2p5Odds()
    ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button').click()
    placeBet(ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input'),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input'),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Back', 'Under', 2.5, 1, odds, 1)
    print('[%s VS %s] betted Back Under 2.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def backUnder1p5():
    global ou1p5Tab, match
    odds = getBackUnder1p5Odds()
    ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button').click()
    placeBet(ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input'),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input'),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Back', 'Under', 1.5, 1, odds, 1)
    print('[%s VS %s] betted Back Under 1.5 @ any odds [%s]' % (match.get("home"), match.get("away"), odds))

def backUnder2p5():
    global ou2p5Tab, match
    odds = getBackUnder2p5Odds()
    ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button').click()
    placeBet(ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input'),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input'),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Back', 'Under', 2.5, 1, odds, 1)
    print('[%s VS %s] betted Back Under 2.5 @ any odds [%s]' % (match.get("home"), match.get("away"), odds))
    return float(odds)
    
def getLayUnder1p5Odds():
    global ou1p5Tab
    return float(ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button').text.split('\n')[0].strip())

def getLayUnder2p5Odds():
    global ou2p5Tab
    return float(ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button/span/div/span[1]').text)

def getBackUnder1p5Odds():
    global ou1p5Tab
    return float(ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button/span/div/span[1]').text)

def getBackUnder2p5Odds():
    global ou2p5Tab
    return float(ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button/span/div/span[1]').text)


def monitorMatch(match_id, url = ''):
    global db, match
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)
    global ou2p5Tab, ou1p5Tab

    match = DailyMatchRow()
    if len(url) == 0:
        row = db.select("SELECT home, away, url FROM " + match.table_name + " WHERE id = '%s';" % (match_id,))
        match.set("home", str(row[0][0]))
        match.set("away", str(row[0][1]))
        match.set("url",  str(row[0][2]))
        url = match.get("url")
        db.delete(match, 'where id = %s' %(match_id,))
    else:
        pass

    browser = Browser()
    page = browser.get(url)
    sleep(4)

    if len(url) and not match_id:
        match.set("home", page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[1]/div[1]/div').text)
        match.set("away", page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[1]/div[1]/div').text)
        match.set("url",  url)

    expandTabsOfInterest(page, browser)

    print('Starting match with url: %s' % url)
    if not check_exists_by_xpath(page, '//*[@id="multiMarketContainer"]'):
        print("Match porbably missed")
        return

    timeout = 60
    while True:
        try:
            elem = page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[3]/div/div[1]/div[1]/div')
            if elem.text == "In-Play":
                break
        except:
            break
        sleep()
        timeout -= 1
        if timeout <= 0:
           print("Match not loaded properly.")
           return

    print("Checking for half time")
    minute = getMatchTime(page)
    if str(minute) == 'Finished':
        print("Match finished")
        return

    while minute != 'Half Time' and int(minute) <= 45:
        sleep()
        minute = getMatchTime(page)

    print('45 minutes passed')
    print('Goals: ' + str(getTotalGoals(page)))
    
    minute = getMatchTime(page)
    while minute == 'Half Time':
        sleep()
        minute = getMatchTime(page)

    print("Half time passed")
    print('Goals: ' + str(getTotalGoals(page)))

    if getTotalGoals(page) == 0:
        layUnder1p5at1p5()
        print("Initial bet played")

        while getTotalGoals(page) == 0:
            if getLayUnder1p5Odds() <= 1.15:
                backUnder1p5()
                print("Lay Under 1.5 Odds dropped below 1.15")
                return 
            sleep()

        while getTotalGoals(page) == 1:
            if getBackUnder1p5Odds() <= 1.52:
                backUnder1p5at1p5()
                print("Back Under 1.5 Odds dropped below 1.52")
                return

    elif getTotalGoals(page) == 1:
        layUnder2p5at1p5()
        print("Initial bet played")
        
        while getTotalGoals(page) == 1:
            if getLayUnder2p5Odds() <= 1.15:
                backUnder2p5()
                print("Lay Under 2.5 Odds dropped below 1.15")
                return 
            sleep()

        while getTotalGoals(page) == 2:
            if getBackUnder2p5Odds() <= 1.52:
                backUnder2p5at1p5()
                print("Back Under 2.5 Odds dropped below 1.52")
                return 
            sleep()
    else:
        print("2 or more goals scored already")
        return


    
    print("Game finished")
