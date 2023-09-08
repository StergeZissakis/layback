import re
import time
import pprint
import logging
from Utils import initialise_logger
from  PGConnector import PGConnector
from Browser import Browser
from datetime import datetime
from collections import OrderedDict
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as ExpectedCondition
from DailyMatchRow import DailyMatchRow
import Utils


def scrapeGoalsNow(db):
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
            "uefa european championship qualifying",
            "euro 2024 qualifying"
            ]
    #leagues.append("denmark cup")
    count = 0
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

        match = DailyMatchRow("over2p5goalsnow")
        match.set("home", m.find_element(By.CLASS_NAME, 'goalshome').text.strip())
        match.set("away", m.find_element(By.CLASS_NAME, 'goalsaway').text.strip())
        now = datetime.now()
        matchTime = m.find_element(By.CLASS_NAME, 'goalstime').text.strip()
        match.set("date_time", Utils.add_time_to_date(event_date = now, event_time = matchTime))

        db.insert_or_update(match)
        count += 1

    if browser.headless: browser.quit()

    return count

def scrapeFootballSuperTips(db):
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
            "uefa european championship qualifying",
            "euro 2024 qualifying"
            ]
    #leagues.append("denmark cup")
    count = 0
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

        match = DailyMatchRow("over2p5footballsupertips")
        match.set("home", m.find_element(By.CLASS_NAME, 'homedisp').text.strip())
        match.set("away", m.find_element(By.CLASS_NAME, 'awaydisp').text.strip())
        date_time_str = m.find_element(By.CLASS_NAME, "datedisp").text
        date_time = datetime.strptime(date_time_str, "%d/%m/%y %H:%M")
        match.set("date_time", date_time)

        db.insert_or_update(match)
        count += 1

    if browser.headless: browser.quit()

    return count
        
def scrapeOrbitxch(db):
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

    count = 0
    for match in todaysMatches:
        names = match.find_element(By.CLASS_NAME, 'biab_market-title-team-names')
        home, away = names.find_elements(By.CSS_SELECTOR, 'p')
        market = match.get_attribute('data-market-id')
        url = 'https://www.orbitxch.com/customer/sport/1/market/' + market

        row = DailyMatchRow("over2p5orbitxch")
        row.set("home", home.text)
        row.set("away", away.text)
        row.set("url", url)
        try:
            matchTime = match.find_element(By.XPATH, './div[1]/div/span')
            matchTime  = matchTime.text.strip()
            if len(matchTime.split(':')) == 2 and len(str(matchTime)) == 5:
                event_date_time = Utils.add_time_to_date(event_date = datetime.now(), event_time = matchTime)
                row.set("date_time", event_date_time)
        except:
            logging.error("Failed to extract start time: %s of %s " % ('match./div[1]/div/span', str(row)))
            continue
    
        if row.get("date_time") is not None:
            db.insert_or_update(row)
        count += 1

    if browser.headless: browser.quit()

    return count
        


if __name__ == "__main__":
    initialise_logger("DailyScraper")
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)

    goalsNow = scrapeGoalsNow(db)
    logging.info("GoalsNow matches: " + str((goalsNow)))
    superTips = scrapeFootballSuperTips(db)
    logging.info("SuperTips matches: " + str((superTips)))
    orbitxch = scrapeOrbitxch(db)
    logging.info("OrbitXCH matches: " + str((orbitxch)))
