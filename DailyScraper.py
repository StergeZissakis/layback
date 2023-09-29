import logging
from Utils import initialise_logger
from PGConnector import PGConnector
from Browser import Browser
from datetime import datetime, timedelta
from selenium.webdriver.common.by import By
from DailyMatchRow import DailyMatchRow
import Utils

leagues = {
    "AFC AFF Suzuki Cup": 246,  # TODO
    "austria bundesliga": 43,
    "Austria Erste Liga": 133,  # TODO
    "Australia Hyundai A-League": 67,  # TODO
    "belgium first division a": 68,
    "belgium first division b": 136,
    "canadian Championship": 257,
    "canada premier league": 258,
    "CONMEBOL Copa Libertadores": 329,  # TODO
    "CONMEBOL Copa Sudamericana": 330,  # TODO
    "denmark superligaen": 40,
    "denmark division 1": 147,
    "denmark: 1. division": 147,
    "denmark division 2": 148,
    "denmark: 2.  division": 148,
    "england premier league": 2,
    "england championship": 77,
    "euro": 387,
    "euro 2024 qualifying": 274,
    "europa league": 245,
    "france ligue 1": 5,
    "germany bundesliga i": 1,
    "germany bundesliga ii": 93,
    "italy serie a": 4,
    "japan j-league": 28,
    "netherlands eredivisie": 196,
    "netherlands eerste divisie": 199,
    "norway division 1": 204,
    "norway eliteserien": 13,
    "portugal primeira liga": 8,
    "south korea k league 1": 66,
    "spain primera liga": 3,
    "sweden 1": 337,  # TODO
    "sweden allsvenskan": 14,
    "sweden superettan": 336,
    "switzerland 1": 339,  # TODO
    "Switzerland Challenge League": 338,  # TODO
    "switzerland super league": 15,
    "usa championship": 384,
    "usa mls": 76,
    "usl championship": 383,
    "uefa euro": 387,
    "uefa champions league": 244,
    "uefa europa league": 245,
    "uefa Nations League": 350,  # TODO
}

def scrapeGoalsNow(dbase):
    global leagues

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
        if league_name not in leagues.keys():
            continue

        match = DailyMatchRow("over2p5goalsnow")
        match.set("home", m.find_element(By.CLASS_NAME, 'goalshome').text.strip())
        match.set("away", m.find_element(By.CLASS_NAME, 'goalsaway').text.strip())
        now = datetime.now()
        matchTime = m.find_element(By.CLASS_NAME, 'goalstime').text.strip()
        match.set("date_time", Utils.add_time_to_date(event_date=now, event_time=matchTime))
        match.set("league_id", leagues[league_name])

        dbase.insert_or_update(match)
        count += 1

    if browser.headless:
        browser.quit()

    return count


def scrapeFootballSuperTips(dbase):
    global leagues
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
            if league_name not in leagues.keys():
                continue
    
            match = DailyMatchRow("over2p5footballsupertips")
            match.set("home", m.find_element(By.CLASS_NAME, 'homedisp').text.strip())
            match.set("away", m.find_element(By.CLASS_NAME, 'awaydisp').text.strip())
            date_time_str = m.find_element(By.CLASS_NAME, "datedisp").text
            date_time = datetime.strptime(date_time_str, "%d/%m/%y %H:%M")
            match.set("date_time", date_time)
            match.set("league_id", leagues[league_name])

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
    Utils.sleep_for_seconds(10)


    # loop until they day after tommorrow appears on the list
    while browser.wait_for_element_to_appear('//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[3]/div/div[3]/div[1]', 1) is None:
        browser.scroll_to_visible(page.find_element(By.XPATH, '//*[@id="biab_footer"]/div/ul'), centre=True)
        Utils.sleep_for_seconds(3)

    todaysRoot = None
    count = 0
    while todaysRoot is None:
        try:
            todaysRoot = page.find_element(By.XPATH,    '//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[3]/div/div[1]/div[2]/div[2]/div[2]')
        except  Exception as Argument:
            logging.info("Error while getting today's root")
            Utils.sleep_for_seconds(1)
            count += 1
            if count > 20:
                break
            continue

    tommorowsRoot = None
    count = 0
    while tommorowsRoot is None:
        try:
            tommorowsRoot = page.find_element(By.XPATH, '//*[@id="biab_body"]/div[2]/main/div/div[3]/div/div/div[1]/div[3]/div/div[2]/div[2]/div/div[2]')
        except  Exception as Argument:
            logging.exception("Error while getting tomorrow's root")
            Utils.sleep_for_seconds(1)
            count += 1
            if count > 20:
                break
            continue

    # today
    if todaysRoot:
        todaysMatches = todaysRoot.find_elements(By.CSS_SELECTOR,    'div.biab_group-markets-table-row.row.rowMarket')
        count = 0
        for match in todaysMatches:
            row = DailyMatchRow("over2p5orbitxch")
            try:
                matchTime = match.find_element(By.XPATH, './div[1]/div/span')
                matchTime  = matchTime.text.strip()
                if len(matchTime.split(':')) == 2 and len(str(matchTime)) == 5:
                    event_date_time = Utils.add_time_to_date(event_date=datetime.now(), event_time=matchTime)
                    row.set("date_time", event_date_time)
            except  Exception as Argument:
                logging.debug("Failed to extract start time: %s of %s " % ('match./div[1]/div/span', str(row)))
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
    else:
        logging.error("Failed to get today's root")

    # tommorow
    tommorowsCount = 0
    if tommorowsRoot:
        tommorowsMatches = tommorowsRoot.find_elements(By.CSS_SELECTOR, 'div.biab_group-markets-table-row.row.rowMarket')
        tommorowsDate = datetime.today() + timedelta(days=1)
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
            except  Exception as Argument:
                logging.exception("Failed to extract tommorow's start time: %s" % tm)
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
    else:
        logging.error("Fialed to get tommorows root")

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

    #goalsNow = scrapeGoalsNow(db)
    #logging.info("GoalsNow matches: " + str(goalsNow))
    #superTips = scrapeFootballSuperTips(db)
    #logging.info("SuperTips matches: " + str(superTips))
    orbitxch = scrapeOrbitxch(db)
    logging.info("OrbitXCH matches: " + str(orbitxch))
