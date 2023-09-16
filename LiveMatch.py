import logging
import Utils 
from Browser import Browser
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException

class LivePage:

    page = None
    match = None
    endOfMatchStr = None

    def __init__(self, page):
        self.page = page

    def canBeMonitored(self):
        return self.findLiveMatch() != None and self.getMatchTime() != None and self.getTotalGoals() != None

    def hasMatchEnded(self):
        return str(self.getMatchTime()) == self.endOfMatchStr:

    def check_exists_by_xpath(self, element, xpath):
        try:
            element.find_element(By.XPATH, xpath)
            return True
        except NoSuchElementException:
            return False

    def findLiveMatch(self):
        return None

    def getMatchTime(self):
        return None

    def getTotalGoals(self):
        return None

    def refreshLiveMatch(self):
        pass

class OrbitLivePage(LivePage):

    def __init__(self, orbitPage):
        super().__init__(orbitPage)
        super().match = self.findLiveMatch()
        super().endOfMatchStr = 'Finished'

    def findLiveMatch(self):
        try:
            ret = super().page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]')
        except:
            return None

    def getMatchTime(self):
        try:
            mtm = super().match.find_element(By.XPATH, './div[2]/div[2]')
            tm = mtm.text.strip().split("'")[0]
            return int(tm)
        except:
            return None

    def getTotalGoals(self):
        try:
            homeGoals = super().match.find_element(By.XPATH, './div[2]/div[1]/span[1]')
            awayGoals = super().match.find_element(By.XPATH, './div[2]/div[1]/span[3]')
            return int(homeGoals) + int(awayGoals)
        except:
            return None

class SuperTipsLivePage(LivePage):

    self.browser = None
    self.url = 'https://www.footballsuper.tips/live-scores/live/'

    def __init__(self)
        self.browser = Browser()
        page = self.live_browser.get(self.url)
        Utils.sleep_for_seconds(2)
        self.live_browser.accept_cookies('/html/body/div[5]/div[2]/div[1]/div[2]/div[2]/button[1]')
        super().__init__(page)
        super().match = self.findLiveMatch()
        super().endOfMatchStr = 'FT'

    def __del__(self):
        if self.browser and self.browser.headless: 
            self.browser.quit()

    def findLiveMatch(self):
        try:
            for lg in super().page.find_elements(By.CLASS_NAME, 'poolList'): #live games
                home = lg.find_element(By.XPATH, './a/div/div[2]').text.strip().lower()
                away = lg.find_element(By.XPATH, './a/div/div[4]').text.strip().lower()
                if home == self.match.get("home").lower() or away == self.match.get("away").lower(): # find the live match in the live page #TODO
                    return lg
        except:
            pass

        logging.error("Failed to get live match")
        return None

    def getMatchTime(self):
        try:
            return super().match.find_element(By.XPATH, './a/div/div[1]/div').text.strip().split('´')[0]
        except:
            Utils.sleep_for_seconds(2)
        finally:
            if not super().check_exists_by_xpath(self.match, './a/div/div[1]/div'):
                return None
        return super().match.find_element(By.XPATH, './a/div/div[1]/div').text.strip().split('´')[0]

    def getTotalGoals(self):
        if not super().check_exists_by_xpath(self.match, './a/div/div[3]/span'):
            return None
        score_element = super().match.find_element(By.XPATH, './a/div/div[3]/span').text.strip()
        home_goals, away_goals = score_element.split('-')
        return int(home_goals) + int(away_goals)

    def refreshLiveMatch(self):
        super().page = self.browser.get(self.url)
        super().match = self.findLiveMatch()
    
