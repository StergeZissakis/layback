import re
import time
import pprint
import logging
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
    leagues = [
            "england premier league", 
            "germany bundesliga i", 
            "belgium first division a", 
            "belgium first division b", 
            "denmark superligaen", 
            "netherlands eredivisie", 
            "netherlands eerste divisie", 
            "austria bundesliga",
            "usa mls",
            "usl championship",
            "usa championship",
            "canadian premier league",
            "canada premier league",
            "denmark division 1",
            "denmark division 2",
            "eufa",
            "euro",
            "eurpean",
            "uefa european championship qualifying"
            ]
    ret = []
    browser = Browser()
    page = browser.get("https://www.goalsnow.com/over-under-predictions/")

    matches = page.find_elements(By.CLASS_NAME, 'with100')
    for m in matches:
        tip_div = m.find_element(By.CLASS_NAME, 'goalstip');
        tip = tip_div.find_element(By.XPATH, './span').text.strip()
        if tip != "Over 2.5":
            continue

        league = m.find_elements(By.XPATH, 'preceding::div[@class="goalsleague"]')[-1]
        league_name = league.find_element(By.CLASS_NAME, 'league-name').text.lower().strip()
        if league_name not in leagues:
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
    leagues = [
            "england premier league", 
            "germany bundesliga i", 
            "belgium first division a", 
            "belgium first division b", 
            "denmark superligaen", 
            "netherlands eredivisie", 
            "netherlands eerste divisie", 
            "austria bundesliga",
            "usa mls",
            "usl championship",
            "usa championship",
            "canadian premier league",
            "canada premier league",
            "denmark division 1",
            "denmark division 2",
            "eufa",
            "euro",
            "eurpean",
            "uefa european championship qualifying"
            ]
    browser = Browser()
    page = browser.get("https://www.footballsuper.tips/todays-over-under-football-super-tips/")
    time.sleep(2)

    browser.accept_cookies('/html/body/div[5]/div[2]/div[1]/div[2]/div[2]/button[1]')

    matches = page.find_elements(By.CLASS_NAME, 'poolList')
    for m in matches:
        browser.scroll_to_visible(m, centre=True)
        over = m.find_element(By.CLASS_NAME, 'prediresults').text.strip()
        if over != "OVER":
            continue

        league = m.find_elements(By.XPATH, 'preceding-sibling::div[@class="pool-list-group"]')[-1]
        league_name = league.find_element(By.XPATH, './div/strong').text.lower().strip()
        if league_name not in leagues:
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

    goalsNow = scrapeGoalsNow()
    logging.info("GoalsNow matches: " + str(len(goalsNow)))
    superTips = scrapeFootballSuperTips()
    logging.info("SuperTips matches: " + str(len(superTips)))

    intersection = set()
    for gn in goalsNow:
        for st in superTips:
            if gn.equals(st):
                intersection.add(gn)

    logging.info("Matches of interest: " + str(len(intersection)))


    browser = Browser()
    page = browser.get("https://www.orbitxch.com/customer/sport/1")
    time.sleep(3)

    browser.move_to_element_and_left_click(page.find_element(By.XPATH, '//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[1]/div/ul/li[1]'))
    time.sleep(3)
    browser.move_to_element_and_left_click(page.find_element(By.XPATH, '//*[@id="biab_header"]/div[2]/div[2]/div[1]/div'))
    time.sleep(1)
    browser.move_to_element_and_left_click(page.find_element(By.XPATH, '//*[@id="-60"]')) # GMT+1
    time.sleep(3)


    #loop until tommorrow appears on the list
    while browser.wait_for_element_to_appear('//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[3]/div/div[2]/div[1]', 1) == None:
        browser.scroll_to_visible(page.find_element(By.XPATH, '//*[@id="biab_footer"]/div/ul'), centre=True)
        time.sleep(2) 

    try:
        root = page.find_element(By.XPATH, '//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[3]/div/div[1]/div[2]/div[2]/div[2]');
    except:
        root = page.find_element(By.XPATH, '//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[3]/div/div[1]/div[2]/div[1]/div[2]');

    todaysMatches = root.find_elements(By.CSS_SELECTOR, 'div.biab_group-markets-table-row.row.rowMarket')
        
    logging.info('Total Exchange Matches found:' + str(len(todaysMatches)))

    urls_found = 0
    for match in todaysMatches:
        names = match.find_element(By.CLASS_NAME, 'biab_market-title-team-names')
        home, away = names.find_elements(By.CSS_SELECTOR, 'p')
        market = match.get_attribute('data-market-id')

        row = DailyMatchRow()
        row.set("home", home.text)
        row.set("away", away.text)
        try:
            matchTime = match.find_element(By.XPATH, './div[1]/div/span').text.strip()
            if len(matchTime.split(':')) == 2 and len(str(matchTime)) == 5:
                event_date_time = Utils.add_time_to_date(event_date = datetime.now(), event_time = matchTime)
                row.set("date_time", event_date_time)
        except:
            pass
    
        for m in intersection:
            if m.equals(row):
                url = 'https://www.orbitxch.com/customer/sport/1/market/' + market
                m.set("url", url)
                logging.info("%s vs %s -> %s" % (m.get("home"), m.get("away"), url))
                urls_found += 1
                break

    logging.info("Found [" + str(urls_found) + "] out of [" + str(len(intersection)) + "] urls")

    db.execute("ArchiveDailyOver2p5")

    finalSet = set()
    excludedSet = []

    for m in intersection:
        if m.get("url") is None or len(m.get("url")) == 0: 
            excludedSet.append(m)
        else:
            finalSet.add(m)

    for m in finalSet:
        db.insert(m)

    for m in excludedSet:
        m.table_name += "_historical"
        db.insert(m)

    if browser.headless:
        browser.quit()
