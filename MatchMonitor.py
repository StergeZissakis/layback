import re
import time
import Utils
from  PGConnector import PGConnector
from Browser import Browser
from datetime import datetime
from DailyMatchRow import DailyMatchRow
from selenium.webdriver.common.by import By
from threading import Thread
from selenium.common.exceptions import NoSuchElementException

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

ou1p5Tab = None
ou2p5Tab = None
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


def logBet(db, mid, layback, overUnder, goals, amount):
    sql = "INSERT INTO public.over2p5bets(match_id, action, OverUnder, Goals, odds, amount) VALUES (%s, %s, %s, %s, %s, %s)" % (mid, layBack, overUnder, goals, odds, amount)
    db.execSql(sql) 

def layUnder1p5at1p5(page, db, mid):
    logBet(db, mid, 'Lay', 'Under', 1.5, 1.5, 50)
    print('[%s] betted Lay Under 1.5 @ 1.5 odds' % mid)

def layUnder2p5at1p5(page, db, mid):
    logBet(db, mid, 'Lay', 'Under', 2.5, 1.5, 50)
    print('[%s] betted Lay Under 2.5 @ 1.5odds' % mid)

def backUnder1p5at1p5(page, db, mid):
    logBet(db, mid, 'Back', 'Under', 1.5, 1.5, 50)
    print('[%s] betted Back Under 1.5 @ 1.5odds' % mid)

def backUnder2p5at1p5(page, db, mid):
    logBet(db, mid, 'Back', 'Under', 2.5, 1.5, 50)
    print('[%s] betted Back Under 2.5 @ 1.5odds' % mid)

def backUnder1p5(page, db, mid):
    odds = getBackUnder1p5Odds(page)
    logBet(db, mid, 'Back', 'Under', 1.5, odds, 50)
    print('[%s] betted Back Under 1.5 @ any odds [%s]' % (mid, odds))

def getLayUnder1p5Odds(page):
    global ou1p5Tab
    return float(ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button').text)

def layUnder1p5(page, db, mid):
    odds = getLayUnder1p5Odds(page)
    logBet(db, mid, 'Lay', 'Under', 1.5, odds, 50)
    print("[%s] betted Lay Under 1.5 @ any odds [%s]" % (mind, odds))

def getLayUnder2p5Odds(page):
    global ou2p5Tab
    return float(ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button/span/div/span[1]').text)

def backUnder2p5(page, db, mid):
    odds = getBackUnder2p5Odds(page)
    logBet(db, mid, 'Back', 'Under', 2.5, odds, 50)
    print("[%s] betted Back Under 2.5 @ any odds %s" % (mind, odds))
    return float(odds)
    
def getBackUnder1p5Odds(page):
    global ou1p5Tab
    return float(ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button/span/div/span[1]').text)

def getBackUnder2p5Odds(page):
    global ou2p5Tab
    return float(ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button/span/div/span[1]').text)


def monitorMatch(mid):
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)
    global ou2p5Tab, ou1p5Tab

    browser = Browser()
    dummy = DailyMatchRow()
    match = db.select("SELECT url FROM " + dummy.table_name + " WHERE id = '%s';" % mid)
    url = str(match[0][0])
    page = browser.get(url)
    time.sleep(5)
    expandTabsOfInterest(page, browser)

    print('%s Starting match id [%s] with url: %s' % (datetime.now(), str(mid),  url))
    if not check_exists_by_xpath(page, '//*[@id="multiMarketContainer"]'):
        print("Match porbably missed")
        return

    while True:
        try:
            elem = page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[3]/div/div[1]/div[1]/div')
            if elem.text == "In-Play":
                break
        except:
            pass
        sleep()

    print("Checking for half time")
    minute = getMatchTime(page)
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
        layUnder1p5at1p5(page, db, mid)
    elif getTotalGoals(page) == 1:
        layUnder2p5at1p5(page, db, mid)
    else:
        return

    print("Initial bet played")

    while getTotalGoals(page) == 0:
        if getBackUnder1p5Odds(page) <= 1.52:
            backUnder1p5at1p5(page, db, mid)
            print("Back Under 1.5 Odds dropped below 1.52")
            return
        
        if getLayUnder1p5Odds(page) <= 1.15:
            backUnder1p5(page, db, mid)
            print("Lay Under 1.5 Odds dropped below 1.15")
            return 
        sleep()
        if getMatchTime(page) > 90 or getTotalGoals(page) > 0:
            break;
    
    while getTotalGoals(page) == 1:
        if getBackUnder2p5Odds(page) <= 1.52:
            backUnder2p5at1p5(page, db, mid)
            print("Back Under 2.5 Odds dropped below 1.52")
            return 
        
        if getLayUnder2p5Odds(page) <= 1.15:
            backUnder2p5(page, db, mid)
            print("Lay Under 2.5 Odds dropped below 1.15")
            return 
        sleep()
        if getMatchTime(page) > 90 or getTotalGoals(page) > 1:
            break;

    print("Game finished")
# SUSPENDED XPATH
#//*[@id="multiMarketContainer"]/div[5]/div[2]/div/div
