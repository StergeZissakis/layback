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
    while rootElement.find_element(By.XPATH, './div[1]/div[1]/div/div[2]/div[2]/div[2]') is None:
        sleep()

    tm = rootElement.find_element(By.XPATH, './div[1]/div[1]/div/div[2]/div[2]/div[2]').text
    if ':' in tm:
        parts = tm.split(":")
    if '\'' in tm:
        parts = tm.split("'").split(":")

    if len(parts) == 1:
        hour = None
        minute = parts[0]
    if len(parts) > 1:
        hour = parts[1]
        minute = parts[0]

    return minute, hour

def getTotalGoals(page):
    root = page.find_element(By.XPATH, '//div[@id="multiMarketContainer"]')
    home_goals = root.find_element(By.XPATH, './div[1]/div[1]/div/div[2]/div[2]/div[1]/span[1]').text
    away_goals = root.find_element(By.XPATH, './div[1]/div[1]/div/div[2]/div[2]/div[1]/span[3]').text
    return int(home_goals) + int(away_goals)


def layUnder1p5at1p5(page, db, mid):
    sql = "INSERT INTO over2p5bets(match_id, type, over_under, ratio, odds, amount) VALUES (%s, %s, %s, %s)" % (mid, 'Lay', 'Under', 1.5, 1.50, 50)
    db.execSql(sql) 
    print('%s betted Lay Under 1.5 @ 1.5odds' % datetime.now())
    print('%s SQL: %s' % sql)

def layUnder2p5at1p5(page, db, mid):
    sql = "INSERT INTO over2p5bets(match_id, type, over_under, ratio, odds, amount) VALUES (%s, %s, %s, %s)" % (mid, 'Lay', 'Under', 2.5, 1,50, 50)
    db.execSql(sql) 
    print('%s betted Lay Under 2.5 @ 1.5odds' % datetime.now())
    print('%s SQL: %s' % sql)

def backUnder1p5at1p5(page, db, mid):
    sql = "INSERT INTO over2p5bets(match_id, type, over_under, ratio, odds, amount) VALUES (%s, %s, %s, %s)" % (mid, 'Back', 'Under', 1.5, 1,50, 50)
    db.execSql(sql) 
    print('%s betted Back Under 1.5 @ 1.5odds' % datetime.now())

def backUnder2p5at1p5(page, db, mid):
    sql = "INSERT INTO over2p5bets(match_id, type, over_under, ratio, odds, amount) VALUES (%s, %s, %s, %s)" % (mid, 'Back', 'Under', 2.5, 1,50, 50)
    db.execSql(sql) 
    print('%s betted Back Under 2.5 @ 1.5odds' % datetime.now())

def backUnder1p5(page, db, mid):
    sql = "INSERT INTO over2p5bets(match_id, type, over_under, ratio, odds, amount) VALUES (%s, %s, %s, %s)" % (mid, 'Back', 'Under', 1.5, odds, 50)
    db.execSql(sql) 
    print('%s betted Back Under 1.5 @ any odds' % datetime.now())

def getLayUnder1p5Odds(page):
    root = page.find_element(By.XPATH, '//div[@id="multiMarketContainer"]')
    tabs = root.find_elements(By.XPATH, './div[@data-market-prices="true"]')
    for t in tabs:
        if t.text == 'Over/Under 1.5 Goals':
            browser.scroll_move_left_click(t)
            return t.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[5]/div/div[3]/div[1]/div[2]/div[2]/div[2]/button').text
    return None

def layUnder1p5(page, db, mid):
    odds = getLayUnder1p5Odds(page)
    print('%s Lay Under 1.5 odds [%s]' % (datetime.now(), str(odds)))
    sql = "INSERT INTO over2p5bets(match_id, type, over_under, ratio, odds, amount) VALUES (%s, %s, %s, %s)" % (mid, 'Lay', 'Under', 1.5, odds, 50)
    db.execSql(sql) 
    return float(odds)

def getLayUnder2p5Odds(page, db, mid):
    root = page.find_element(By.XPATH, '//div[@id="multiMarketContainer"]')
    tabs = root.find_elements(By.XPATH, './div[@data-market-prices="true"]')
    for t in tabs:
        if t.text == 'Over/Under 2.5 Goals':
            browser.scroll_move_left_click(t)
            return t.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[6]/div[3]/div/div[5]/div/div[3]/div[1]/div[2]/div[2]/div[2]/button').text
    return None

def backUnder2p5(page, db, mid):
    odds = page.find_element(By.XPATH, '//div[@id="multiMarketContainer"]').find_element(By.XPATH, './div[6]/div[3]/div/div[5]/div/div[3]/div[1]/div[2]/div[2]/div[1]/button/span/div/span[1]') .text
    print('%s Back Under 2.5 at any odds' % (datetime.now(), str(odds)))
    sql = "INSERT INTO over2p5bets(match_id, type, over_under, ratio, odds, amount) VALUES (%s, %s, %s, %s)" % (mid, 'Back', 'Under', 2.5, odds, 50)
    db.execSql(sql) 
    return float(odds)
    
def getBackUnder1p5Odds():
    pass 

def getBackUnder2p5Odds():
    pass

def monitorMatch(mid):
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)

    browser = Browser()
    dummy = DailyMatchRow()
    match = db.select("SELECT url FROM " + dummy.table_name + " WHERE id = '%s';" % mid)
    url = str(match[0][0])
    page = browser.get(url)
    time.sleep(5)

    print('%s Starting match id [%s] with url: %s' % (datetime.now(), str(mid),  url))
    inPlayText = ''
    root = page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]')
    while len(inPlayText) == 0:
        browser.wait_for_element_to_appear('//div[@id="multiMarketContainer"]/div[3]/div/div[1]/div[1]/div', timeout = 60)
        try:
            elem = root.find_element(By.XPATH, './div[3]/div/div[1]/div[1]/div')
            inPlayText = elem.text
        except:
            inPlayText = ''

     
    mt = getMatchTime(page)
    while mt[0] == 'Half Time':
        sleep()
        mt = getMatchTime(page)

    mt = getMatchTime(page)
    (minute, hour) = (mt[0], mt[1])
    while minute < 45 and hour is None:
        sleep()
        mt = getMatchTime(page)
        while mt[0] == 'Half Time':
            sleep()
            mt = getMatchTime(page)
        hour = mt[1]
        if hour is not None:
            hour = int(hour)
        minute = int(mt[0])

    print('45 minutes passed')
    print('Goals: ' + str(getTotalGoals(page)))

    if getTotalGoals(page) == 0:
        layUnder1p5at1p5(page, db, mid)
    elif getTotalGoals(page) == 1:
        layUnder2p5at1p5(page, db, mid)
    else:
        return

    while True:
        while getTotalGoals(page) == 0:
            if getBackUnder1p5Odds(page) <= 1.52:
                backUnder1p5at1p5(page, db, mid)
                return
        
            if getLayUnder1p5Odds(page) <= 1.15 and getTotalGoals(page) == 0:
                backUnder1p5(page, db, mid)
                return 
    
        while getTotalGoals(page) == 1:
            if getBackUnder2p5Odds(page) <= 1.52:
                backUnder2p5at1p5(page, db, mid)
        
            if getLayUnder2p5Odds(page) <= 1.15 and getTotalGoals(page) == 1:
                backUnder2p5(page, db, mid)
                return 
    
            if getTotalGoals(page) > 1:
                #TODO update the DB, it's a win
                return
        
        if getTotalGoals(page) > 1:
            return
