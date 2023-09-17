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
        return self.findLiveMatch() is not None and self.getMatchTime() is not None and self.getTotalGoals() is not None

    def hasMatchEnded(self):
        return str(self.getMatchTime()) == self.endOfMatchStr

    @staticmethod
    def check_exists_by_xpath(element, xpath):
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
        self.match = self.findLiveMatch()
        self.endOfMatchStr = 'Finished'

    def findLiveMatch(self):
        try:
            return self.page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]')
        except:
            return None

    def getMatchTime(self):
        try:
            mtm = self.match.find_element(By.XPATH, './div[2]/div[2]')
            tm = mtm.text.strip().split("'")[0]
            return int(tm)
        except:
            return None

    def getTotalGoals(self):
        try:
            homeGoals = self.match.find_element(By.XPATH, './div[2]/div[1]/span[1]')
            awayGoals = self.match.find_element(By.XPATH, './div[2]/div[1]/span[3]')
            return int(homeGoals.text.strip()) + int(awayGoals.text.strip())
        except:
            return None


class SuperTipsLivePage(LivePage):

    browser = None
    url = 'https://www.footballsuper.tips/live-scores/live/'

    def __init__(self, match):
        self.browser = Browser()
        page = self.browser.get(self.url)
        Utils.sleep_for_seconds(2)
        self.browser.accept_cookies('/html/body/div[5]/div[1]/div[2]/div/div/div/div[5]/div[2]/a')
        super().__init__(page)
        self.match = match
        self.match = self.findLiveMatch()
        self.endOfMatchStr = 'FT'

    def __del__(self):
        if self.browser and self.browser.headless: 
            self.browser.quit()

    def findLiveMatch(self):
        try:
            for lg in self.page.find_elements(By.CLASS_NAME, 'poolList'):  # live games
                home = lg.find_element(By.XPATH, './a/div/div[2]').text.strip().lower()
                away = lg.find_element(By.XPATH, './a/div/div[4]').text.strip().lower()
                if (Utils.stringsContainmentScore(home, self.match.get("home").lower()) > 0 and
                        Utils.stringsContainmentScore(away, self.match.get("away").lower()) > 0):
                    return lg
        except:
            pass

        logging.error("Failed to get live match")
        return None

    def getMatchTime(self):
        try:
            return self.match.find_element(By.XPATH, './a/div/div[1]/div').text.strip().split('´')[0]
        except:
            Utils.sleep_for_seconds(2)
        finally:
            if not self.check_exists_by_xpath(self.match, './a/div/div[1]/div'):
                return None
        return self.match.find_element(By.XPATH, './a/div/div[1]/div').text.strip().split('´')[0]

    def getTotalGoals(self):
        if not self.check_exists_by_xpath(self.match, './a/div/div[3]/span'):
            return None
        score_element = self.match.find_element(By.XPATH, './a/div/div[3]/span').text.strip()
        home_goals, away_goals = score_element.split('-')
        return int(home_goals) + int(away_goals)

    def refreshLiveMatch(self):
        self.page = self.browser.get(self.url)
        self.match = self.findLiveMatch()
    
