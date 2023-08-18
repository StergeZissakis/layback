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

    parts = tm.split(":'")

    if len(parts) == 1:
        hour = None
        minute = parts[0]
    if len(parts) > 1:
        hour = parts[0]
        minute = parts[1]

    return hour, minute

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

def backUnder2p5(page):
    odds = page.find_element(By.XPATH, '//div[@id="multiMarketContainer"]').find_element(By.XPATH, './div[6]/div[3]/div/div[5]/div/div[3]/div[1]/div[2]/div[2]/div[1]/button/span/div/span[1]') .text
    print('%s Back Under 2.5 at any odds' % (datetime.now(), str(odds)))
    sql = "INSERT INTO over2p5bets(match_id, type, over_under, ratio, odds, amount) VALUES (%s, %s, %s, %s)" % (mid, 'Back', 'Under', 2.5, odds, 50)
    db.execSql(sql) 
    return float(odds)

def spawnThread(p, f):
    t = Thread(target=f, args=[p])
    t.run()
    return t

def watch_rest_of_match(page, db, mid, back_monitor, lay_monitor, bet_function_odds, bet_function_no_odds_to_bet,  goalsSoFar, point5):
    while back_monitor(page, point5) > 1.52:
        sleep()
        if getTotalGoals(page) > goalsSoFar:
            #TODO update the DB, it's a win
            return
        elif lay_monitor(page, db, mid, point5):
            bet_function_no_odds_to_bet(page, db, mid)


    #The value of monitor_function is now <= 1.52
    bet_function_odds(page, db, mid, )


def monitorMatch(mid):
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)

    browser = Browser()
    dummy = DailyMatchRow()
    match = db.select("SELECT url FROM " + dummy.table_name + " WHERE id = '%s';" % mid)
    url = str(match[0][0])
    page = browser.get(url)
    time.sleep(3)

    print('%s Starting match id [%s] with url: %s' % (datetime.now(), str(mid),  url))

    while page.find_element(By.XPATH, '//div[@id="multiMarketContainer"]').find_element(By.XPATH, './div[3]/div/div[1]/div[1]/div').text != 'In-Play':
        sleep()

    
    mt = getMatchTime(page)
    while mt == 'Half Time':
        sleep()
        mt = getMatchTime(page)

    hour = mt[0]
    if hour is not None:
        hour = int(hour)
    minute = int(mt[1].strip('\''))

    while minute < 45 and hour is None:
        sleep()
        mt = getMatchTime(page)
        while mt == 'Half Time':
            sleep()
            mt = getMatchTime(page)
        hour = mt[0]
        if hour is not None:
            hour = int(hour)
        minute = int(mt[1].strip('\''))


    print('45 minutes passed')
    goals = getTotalGoals(page)
    print('goals: ' + str(goals))
    if goals == 0:
        spawnThread(page, layUnder1p5at1p5(page))

        while goals == 0:
            sleep()
            goals = getTotalGoals(page)
            if goals == 0:
                if getUnder1p5Odds(page) <= 1.15:
                    backUnder1p5(page)
                    print('layUnder1p5 <= 1.15')
                    return

            if goals > 0:
                spawnThread(page, backUnder1p5at1p5)

            
        goals = getTotalGoals(page)
        if goals == 1:
            while True:
                if backUnder1p5(page) <= 1.52:
                    backUnder1p5at1p5(page)
                    print('backUnder1p5 <= 1.52')
                    return
                if getTotalGoals(page) != goals:
                    print('There has a another goal')
                    return
                sleep()
        print('End of 0 goals start')
        return

    if goals == 1:
        spawnThread(page, layUnder2p5at1p5(page))
        while getTotalGoals(page) == 1:
            while backUnder2p5(page) > 1.52:
                sleep()
                if getTotalGoals(page) > goals:
                    #TODO log WIN!!!
                    print('WIN!!!')
                    return

                if backUnder2p5() < 1.15:
                    backUnder2p5at1p5(page)
                    print('Under2.5Odss < 1.15')
                    return

            backUnder2p5at1p5(page)
            print('backUnder2p5at1p5')
            return
        print('2 goals')
        return

    if goals > 1:
        #TODO log DROP!!
        print('Too many goals')
        return

