import logging
from Utils import initialise_logger
from PGConnector import PGConnector
from Browser import Browser
from datetime import datetime, timedelta
from selenium.webdriver.common.by import By
from DailyMatchRow import DailyMatchRow
import Utils


def scrapeGoalsNow(dbase):
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
            "denmark: 1. division",
            "denmark division 2",
            "denmark: 2.  division",
            "eufa",
            "euro",
            "eurpean",
            "uefa european championship qualifying",
            "euro 2024 qualifying"
            ]
    # leagues.append("denmark cup")
    count = 0
    browser = Browser()
    page = browser.get("https://www.goalsnow.com/over-under-predictions/")

    matches = page.find_elements(By.CLASS_NAME, 'with100')
    for m in matches:
        tip_div = m.find_element(By.CLASS_NAME, 'goalstip')
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
        match.set("date_time", Utils.add_time_to_date(event_date=now, event_time=matchTime))

        dbase.insert_or_update(match)
        count += 1

    if browser.headless:
        browser.quit()

    return count


def scrapeFootballSuperTips(dbase):
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
            "denmark: 1. division",
            "denmark division 2",
            "denmark: 2.  division",
            "eufa",
            "euro",
            "eurpean",
            "uefa european championship qualifying",
            "euro 2024 qualifying"
            ]
    # leagues.append("denmark cup")
    urls = ["https://www.footballsuper.tips/todays-over-under-football-super-tips/", "https://www.footballsuper.tips/tomorrows-over-under-football-super-tips/"]
    tomorrow = False
    todaysCount = 0
    tommorowsCount = 0
    for url in urls:
        browser = Browser()
        page = browser.get(url)
        Utils.sleep_for_seconds(2)

        browser.accept_cookies('/html/body/div[5]/div[1]/div[2]/div/div/div/div[5]/div[2]/a')

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

            if tomorrow and int(date_time.hour) >= 6:
                continue
    
            dbase.insert_or_update(match)

            if tomorrow:
                # add all tommorow's match to the Goals now table so that they will be accounted for
                match.set("id", None)
                match.table_name = "over2p5goalsnow"
                dbase.insert_or_update(match)
                tommorowsCount += 1
            else:
                todaysCount += 1
    
        if browser.headless:
            browser.quit()
        tomorrow = True
    
    return todaysCount + tommorowsCount
        

def scrapeOrbitxch(dbase):
    browser = Browser()
    page = browser.get("https://www.orbitxch.com/customer/sport/1")
    Utils.sleep_for_seconds(3)

    browser.move_to_element_and_left_click(page.find_element(By.XPATH, '//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[1]/div/ul/li[1]'))
    Utils.sleep_for_seconds(3)
    browser.move_to_element_and_left_click(page.find_element(By.XPATH, '//*[@id="biab_header"]/div[2]/div[2]/div[1]/div'))
    Utils.sleep_for_seconds(1)
    browser.move_to_element_and_left_click(page.find_element(By.XPATH, '//*[@id="-60"]'))  # GMT+1
    Utils.sleep_for_seconds(3)


    # loop until they day afgter tommorrow appears on the list
    while browser.wait_for_element_to_appear('//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[3]/div/div[3]/div[1]', 1) is None:
        browser.scroll_to_visible(page.find_element(By.XPATH, '//*[@id="biab_footer"]/div/ul'), centre=True)
        Utils.sleep_for_seconds(2) 

    todaysRoot = None
    while todaysRoot is None:
        try:
            todaysRoot = page.find_element(By.XPATH,    '//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[3]/div/div[1]/div[2]/div[2]/div[2]')
        except:
            Utils.sleep_for_seconds(1)
            continue

    tommorowsRoot = None
    while tommorowsRoot is None:
        try:
            tommorowsRoot = page.find_element(By.XPATH, '//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[3]/div/div[2]/div[2]/div/div[2]')
        except:
            Utils.sleep_for_seconds(1)
            continue

    # today
    todaysMatches    = todaysRoot.find_elements(By.CSS_SELECTOR,    'div.biab_group-markets-table-row.row.rowMarket')
    count = 0
    for match in todaysMatches:
        row = DailyMatchRow("over2p5orbitxch")
        try:
            matchTime = match.find_element(By.XPATH, './div[1]/div/span')
            matchTime  = matchTime.text.strip()
            if len(matchTime.split(':')) == 2 and len(str(matchTime)) == 5:
                event_date_time = Utils.add_time_to_date(event_date=datetime.now(), event_time=matchTime)
                row.set("date_time", event_date_time)
        except:
            logging.error("Failed to extract start time: %s of %s " % ('match./div[1]/div/span', str(row)))
            continue
    
        names = match.find_element(By.CLASS_NAME, 'biab_market-title-team-names')
        home, away = names.find_elements(By.CSS_SELECTOR, 'p')
        market = match.get_attribute('data-market-id')
        row.set("home", home.text.strip())
        row.set("away", away.text.strip())
        row.set("url", 'https://www.orbitxch.com/customer/sport/1/market/' + market.strip())

        if row.get("date_time") is not None:
            dbase.insert_or_update(row)
            count += 1

    # tommorow
    tommorowsMatches = tommorowsRoot.find_elements(By.CSS_SELECTOR, 'div.biab_group-markets-table-row.row.rowMarket')
    tommorowsDate = datetime.today() + timedelta(days=1)
    tommorowsCount = 0
    for tm in tommorowsMatches:
        row = DailyMatchRow("over2p5orbitxch")
        try:
            matchTime = tm.find_element(By.XPATH, './div[1]/div/span[2]')
            mTime = matchTime.text.strip()
            if len(mTime.split(':')) == 2 and len(str(mTime)) == 5:
                hour, minute = mTime.split(':')
                if int(hour) >= 6:
                    break
                event_date_time = Utils.add_time_to_date(event_date=tommorowsDate, event_time=mTime)
                row.set("date_time", event_date_time)
        except:
            logging.error("Failed to extract tommorow's start time: %s" % tm)
            continue
        names = tm.find_element(By.CLASS_NAME, 'biab_market-title-team-names')
        home, away = names.find_elements(By.CSS_SELECTOR, 'p')
        market = tm.get_attribute('data-market-id')
        row.set("home", home.text.strip())
        row.set("away", away.text.strip())
        row.set("url", 'https://www.orbitxch.com/customer/sport/1/market/' + market.strip())
        
        if row.get("date_time") is not None:
            dbase.insert_or_update(row)
            tommorowsCount += 1
    
    logging.info('Total Exchange Matches found for tommorow until 05:30: %s' % str(tommorowsCount))

    if browser.headless:
        browser.quit()

    return count
        

if __name__ == "__main__":
    initialise_logger("DailyScraper")
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        logging.error("Failed to connect to DB")
        exit(-1)

    goalsNow = scrapeGoalsNow(db)
    logging.info("GoalsNow matches: " + str(goalsNow))
    superTips = scrapeFootballSuperTips(db)
    logging.info("SuperTips matches: " + str(superTips))
    orbitxch = scrapeOrbitxch(db)
    logging.info("OrbitXCH matches: " + str(orbitxch))
