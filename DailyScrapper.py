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
        (h, m) = matchTime.split(':')
        now.replace(hour=int(h), minute=int(m))
        match.set("date_time", now)

        ret.append(match)

    return ret
    

def scrapeFootballSuperTips():
    ret = []
    browser = Browser()
    page = browser.get("https://www.footballsuper.tips/todays-over-under-football-super-tips/")

    browser.accept_cookies('/html/body/div[4]/div[2]/div[1]/div[2]/div[2]/button[1]/p')

    matches = page.find_elements(By.CLASS_NAME, 'poolList')
    print(len(matches))
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
        print(match.data)

        ret.append(match)

    print(len(ret))
    return ret

if __name__ == "__main__":
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)

    browser = Browser()

    #goalsNow = scrapeGoalsNow()
    superTips = scrapeFootballSuperTips()

    if browser.headless:
        browser.quit()
