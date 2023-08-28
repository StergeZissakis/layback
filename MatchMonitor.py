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

def getMatchTime(page):
    if check_exists_by_xpath(page, '//div[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[2]/div[2]') is False:
        return None
    rootElement = page.find_element(By.XPATH, '//div[@id="multiMarketContainer"]')
    text = rootElement.find_element(By.XPATH, './div[1]/div[1]/div/div[2]/div[2]/div[2]').text
    if "'" in text:
        text = text.split("'")[0]
    return  text.strip()

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
    #pp.pprint(bet)
    db.insert(bet)

def placeBet(bet_button, odds_input, stake_input, bet_button, layback, overUnder, goals, odds, odds_recorded, amount):
    global page
    suspended_xpath = '//*[@id="multiMarketContainer"]/div[5]/div[2]/div/div/text()'
    while check_exists_by_xpath(page, suspended_xpath) and page.find_element(By.XPATH, suspended_xpath).text() == "SUSPENDED"):
        sleep(2)
    bet_button.click()
    odds_input.send_keys(str(odds))
    stake_input.send_keys(str(6))
    bet_button.click()
    #TODO: Monitor for when the bet Wins
    logBet(layback, overUnder, goals, odds, odds_recorded, amount)


def layUnder1p5at1p5():
    global ou1p5Tab, match
    odds = getLayUnder1p5Odds()
    placeBet(ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button'            ),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input' ),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input' ),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Lay', 'Under', 1.5, 1.5, odds, 1)
    print('[%s VS %s] betted Lay Under 1.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def layUnder2p5at1p5():
    global ou2p5Tab, match
    odds = getLayUnder2p5Odds()
    placeBet(ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[2]/button'            ),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input' ),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input' ),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Lay', 'Under', 2.5, 1.5, odds, 1)
    print('[%s VS %s] betted Lay Under 2.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def backUnder1p5at1p5():
    global ou1p5Tab, match
    odds = getBackUnder1p5Odds()
    placeBet(ou1p5Tab.find_element(By.XPATH  './div[3]/div[1]/div[2]/div[2]/div[1]/button'            ),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input' ),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input' ),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Back', 'Under', 1.5, 1.5, odds, 1)
    print('[%s VS %s] betted Back Under 1.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def backUnder2p5at1p5():
    global ou2p5Tab, match
    odds = getBackUnder2p5Odds()
    placeBet(ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button'            ),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input' ),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input' ),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Back', 'Under', 2.5, 1, odds, 1)
    print('[%s VS %s] betted Back Under 2.5 @ 1.5 odds' % (match.get("home"), match.get("away")))

def backUnder1p5():
    global ou1p5Tab, match
    odds = getBackUnder1p5Odds()
    placeBet(ou1p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button'            ),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input' ),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input' ),
             ou1p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Back', 'Under', 1.5, 1, odds, 1)
    print('[%s VS %s] betted Back Under 1.5 @ any odds [%s]' % (match.get("home"), match.get("away"), odds))

def backUnder2p5():
    global ou2p5Tab, match
    odds = getBackUnder2p5Odds()
    placeBet(ou2p5Tab.find_element(By.XPATH, './div[3]/div[1]/div[2]/div[2]/div[1]/button'            ),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[2]/input' ),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[3]/input' ),
             ou2p5Tab.find_element(By.XPATH, './div[3]/div[2]/div/div/div[2]/div/div[1]/div[4]/button'),
             'Back', 'Under', 2.5, 1, odds, 1)
    print('[%s VS %s] betted Back Under 2.5 @ any odds [%s]' % (match.get("home"), match.get("away"), odds))
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
        form = page.find_element(By.XPATH, '//div[@id="biab_login-block"]/form') # Login
        form.find_element(By.XPATH, './div/input[1]').send_keys("voyager2007")
        form.find_element(By.XPATH, './div/input[2]').send_keys("Stergios777&&&")
        form.find_element(By.XPATH, './div/button').click()
        browser.wait_for_element_to_appear('//div[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button')
        page.find_element(By.XPATH, '//div[@id="biab_modal"]/div/div[2]/div[2]/div[2]/button').click()
        sleep(6)
        page.refresh()
        sleep(10)
    else:
        print('[%s VS %s] Failure: URL is blank')
        return



    if len(url) and not match_id:
        match.set("home", page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[1]/div[1]/div').text)
        match.set("away", page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]/div[1]/div[1]/div').text)
        match.set("url",  url)

    expandTabsOfInterest(page, browser)

    print('[%s VS %s] Starting match : %s' % (match.get("home"), match.get("away"), url))
    if not check_exists_by_xpath(page, '//*[@id="multiMarketContainer"]'):
        print('[%s VS %s] Possibly missed starting match : %s' % (match.get("home"), match.get("away"), url))
        return

    print('[%s VS %s] Waiting to go In-Play : %s' % (match.get("home"), match.get("away"), url))
    timeout = 30
    while True:
        try:
            elem = page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[3]/div/div[1]/div[1]/div')
            if elem.text == "In-Play":
                break
        except:
            page.refresh()
            sleep(10)
            continue
        sleep()
        timeout -= 1
        if timeout <= 0:
            print('[%s VS %s] Match not loaded properly. : %s' % (match.get("home"), match.get("away"), url))
            return

    print('[%s VS %s] Checking/Waiting for half time. : %s' % (match.get("home"), match.get("away"), url))


    timeout = 15
    while getMatchTime(page) is None:
        timeout -= 1
        if timeout <= 0:
            print('[%s VS %s] Failed to get match time. : %s' % (match.get("home"), match.get("away"), url))
            return
        sleep()

    print('[%s VS %s] Time is not None : %s' % (match.get("home"), match.get("away"), url))

    if getMatchTime(page).isnumeric():
        while getMatchTime(page).isnumeric() and int(getMatchTime(page)) <= 45:
            sleep()

    sleep()
    while not getMatchTime(page).isnumeric():
        sleep()
    
    print('[%s VS %s] Time is numeric : %s' % (match.get("home"), match.get("away"), url))

    minute = getMatchTime(page)
    while int(minute) <= 46:
        sleep()
        minute = getMatchTime(page)

    print('[%s VS %s] Half time passed. Goals @ 46 mins [%s] : %s' % (match.get("home"), match.get("away"), str(getTotalGoals(page)), url))
    
    if getTotalGoals(page) == 0:
        layUnder1p5at1p5()
        print('[%s VS %s] Initial bet played : %s' % (match.get("home"), match.get("away"), url))

        while getTotalGoals(page) == 0 and str(getMatchTime(page)) != 'Finished':
            if getLayUnder1p5Odds() <= 1.15:
                backUnder1p5()
                print('[%s VS %s] Lay Under 1.5 Odds dropped below 1.15. : %s' % (match.get("home"), match.get("away"), url))
                return 
            sleep()

        if str(getMatchTime(page)) != 'Finished':
                print('[%s VS %s] Goal detected. : %s' % (match.get("home"), match.get("away"), url))

        while getTotalGoals(page) == 1 and str(getMatchTime(page)) != 'Finished':
            if getBackUnder1p5Odds() <= 1.52:
                backUnder1p5at1p5()
                print('[%s VS %s] Back Under 1.5 Odds dropped below 1.52. : %s' % (match.get("home"), match.get("away"), url))
                return
            sleep()

    elif getTotalGoals(page) == 1:
        layUnder2p5at1p5()
        print('[%s VS %s] Initial bet played. : %s' % (match.get("home"), match.get("away"), url))
        
        while getTotalGoals(page) == 1 and str(getMatchTime(page)) != 'Finished':
            if getLayUnder2p5Odds() <= 1.15:
                backUnder2p5()
                print('[%s VS %s] Lay Under 2.5 Odds dropped below 1.15. : %s' % (match.get("home"), match.get("away"), url))
                return 
            sleep()

        if str(getMatchTime(page)) != 'Finished':
                print('[%s VS %s] Goal detected. : %s' % (match.get("home"), match.get("away"), url))

        while getTotalGoals(page) == 2 and str(getMatchTime(page)) != 'Finished':
            if getBackUnder2p5Odds() <= 1.52:
                backUnder2p5at1p5()
                print('[%s VS %s] Back Under 2.5 Odds dropped below 1.52. : %s' % (match.get("home"), match.get("away"), url))
                return 
            sleep()
    else:
        print('[%s VS %s] 2 or more goals scored already. : %s' % (match.get("home"), match.get("away"), url))
        return


    
    print('[%s VS %s] Game finished with [%s] goals : %s' % (match.get("home"), match.get("away"), url, getTotalGoals(page)))
