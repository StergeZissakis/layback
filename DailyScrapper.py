import re
import time
import pprint
from  LayBackPGConnector import LayBackPGConnector
from LayBackBrowser import LayBackBrowser
from datetime import datetime
from collections import OrderedDict
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as ExpectedCondition
from DailyMatchRow import DailyMatchRow


def scrapeGoalsNow():
    ret = []
    browser = LayBackBrowser()
    page = browser.get("https://www.goalsnow.com/over-under-predictions/")

    matches = wait(page, 5).until(ExpectedCondition.presence_of_all_elements_located((By.XPATH, './div[contains(@class, "with100")]')))
    for m in matches:
        tip = m.find_element(By.XPATH, './div[contains(@class, "goalstip"]./span').text()
        if tip != "Over 2.5":
            continue

        match = DailyMatchRow()
        match["home"] = m.find_element(By.XPATH, './div[contains(@class, "goalshome")]').text()
        match["away"] = m.find_element(By.XPATH, './div[contains(@class, "goalsaway")]').text()
        now = datetime.now()
        matchTime = m.find_element(By.XPATH, './div[contains(@class, "goalstime")]').text()
        (h, m) = matchTime.split(';')
        now.replace(hour=h, minute=m)
        match["date_time"] = now

        ret.append(match)

    return ret
    

def scrapeFootballSuperTips():
    ret = []
    browser = LayBackBrowser()
    page = browser.get("https://www.goalsnow.com/over-under-predictions/")

    return ret

if __name__ == "__main__":
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)

    goalsNow = scrapeGoalsNow()
    print(goalsNow)
    print(len(goalsNow))
    superTips = scrapeFootballSuperTips()

    if browser.headless:
        browser.quit()
