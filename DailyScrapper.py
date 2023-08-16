import re
import time
import pprint
from  PGConnector import PGConnector
from Browser import Browser
from datetime import datetime
from collections import OrderedDict
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as ExpectedCondition
from DailyMatchRow import DailyMatchRow
import Utils


def scrapeGoalsNow():
    ret = []
    browser = Browser()
    page = browser.get("https://www.goalsnow.com/over-under-predictions/")

    matches = page.find_elements(By.CLASS_NAME, 'with100')
    for m in matches:
        tip_div = m.find_element(By.CLASS_NAME, 'goalstip');
        tip = tip_div.find_element(By.XPATH, './span').text.strip()
        if tip != "Over 2.5":
            continue
        match = DailyMatchRow()
        match.set("home", m.find_element(By.CLASS_NAME, 'goalshome').text.strip())
        match.set("away", m.find_element(By.CLASS_NAME, 'goalsaway').text.strip())
        now = datetime.now()
        matchTime = m.find_element(By.CLASS_NAME, 'goalstime').text.strip()
        match.set("date_time", Utils.add_time_to_date(event_date = now, event_time = matchTime))

        ret.append(match)

    if browser.headless:
        browser.quit()
        
    return ret
    

def scrapeFootballSuperTips():
    ret = []
    browser = Browser()
    page = browser.get("https://www.footballsuper.tips/todays-over-under-football-super-tips/")

    browser.accept_cookies('/html/body/div[4]/div[2]/div[1]/div[2]/div[2]/button[1]/p')

    matches = page.find_elements(By.CLASS_NAME, 'poolList')
    for m in matches:
        browser.scroll_to_visible(m, centre=True)
        over = m.find_element(By.CLASS_NAME, 'prediresults').text.strip()
        if over != "OVER":
            continue
        match = DailyMatchRow()
        match.set("home", m.find_element(By.CLASS_NAME, 'homedisp').text.strip())
        match.set("away", m.find_element(By.CLASS_NAME, 'awaydisp').text.strip())
        date_time_str = m.find_element(By.CLASS_NAME, "datedisp").text
        date_time = datetime.strptime(date_time_str, "%d/%m/%y %H:%M")
        match.set("date_time", date_time)

        ret.append(match)

    if browser.headless:
        browser.quit()
        
    return ret

if __name__ == "__main__":
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)

    browser = Browser()
    goalsNow = scrapeGoalsNow()
    print("GoalsNow matches: " + str(len(goalsNow)))
    superTips = scrapeFootballSuperTips()
    print("SuperTips matches: " + str(len(superTips)))

    intersection = set()
    for gn in goalsNow:
        for st in superTips:
            if gn.equals(st):
                intersection.add(gn)

    print("Matches of interest: " + str(len(intersection)))


    page = browser.get("https://www.orbitxch.com/customer/sport/1")
    time.sleep(1)
    browser.move_to_element_and_left_click(page.find_element(By.XPATH, '//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[1]/div/ul/li[3]'))
    time.sleep(1)

    root = page.find_element(By.CLASS_NAME, 'biab_group-markets')

    todaysMatches = root.find_elements(By.CSS_SELECTOR, 'div.biab_group-markets-table-row.row.rowMarket')
    last = 0
    while last < len(todaysMatches):
        last = len(todaysMatches) 
        browser.scroll_to_visible(todaysMatches[-1], centre=True)
        todaysMatches = root.find_elements(By.CSS_SELECTOR, 'div.biab_group-markets-table-row.row.rowMarket')

    print('Total Exchange Matches found:' + str(len(todaysMatches)))

    urls_found = 0
    for match in todaysMatches:
        names = match.find_element(By.CLASS_NAME, 'biab_market-title-team-names')
        home, away = names.find_elements(By.CSS_SELECTOR, 'p')
        market = match.get_attribute('data-market-id')

        row = DailyMatchRow()
        row.set("home", home.text)
        row.set("away", away.text)
        for m in intersection:
            if m.equals_no_datetime(row):
                url = 'https://www.orbitxch.com/customer/sport/1/market/' + market
                m.set("url", url)
                urls_found += 1
                break

    print("Found [" + str(urls_found) + "] out of [" + str(len(intersection)) + "] urls")

    db.execute("ArchiveDailyOver2p5")

    for m in intersection:
        db.insert(m)

    if browser.headless:
        browser.quit()
