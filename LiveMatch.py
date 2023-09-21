import logging
import Utils 
import requests
import json
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
        return False

    def hasMatchEnded(self):
        return str(self.getMatchTime()) == self.endOfMatchStr

    def findLiveMatch(self):
        return None

    def getMatchTime(self):
        return None

    def getTotalGoals(self):
        return None



class OrbitLivePage(LivePage):

    def __init__(self, orbitPage):
        super().__init__(orbitPage)
        self.match = self.findLiveMatch()
        self.endOfMatchStr = 'Finished'

    def canBeMonitored(self):
        return self.match is not None and self.getMatchTime() is not None and self.getTotalGoals() is not None

    def findLiveMatch(self):
        try:
            return self.page.find_element(By.XPATH, '//*[@id="multiMarketContainer"]/div[1]/div[1]/div/div[2]')
        except  Exception as Argument:
            logging.exception("Exception in FindLiveMatch")
            return None

    def getMatchTime(self):
        try:
            mtm = self.match.find_element(By.XPATH, './div[2]/div[2]')
            tm = mtm.text.strip().split("'")[0]
            return int(tm)
        except  Exception as Argument:
            logging.exception("Exception in getMatchTime")
            return None

    def getTotalGoals(self):
        try:
            homeGoals = self.match.find_element(By.XPATH, './div[2]/div[1]/span[1]')
            awayGoals = self.match.find_element(By.XPATH, './div[2]/div[1]/span[3]')
            return int(homeGoals.text.strip()) + int(awayGoals.text.strip())
        except  Exception as Argument:
            logging.exception("Exception in getTotalGoals")
            return None


class APILivePage(LivePage):

    api_key = "Fv6kKZy7fwSLBTB7"
    api_secret = "Bef6mREpHUEqpF44aboUaW2qsUc4ONbp"
    fixture_id = None
    get_fixtures_url = "https://livescore-api.com/api-client/fixtures/matches.json?key=%s&secret=%s&date=today&lang=en&competition_id="
    get_live_url = "https://livescore-api.com/api-client/scores/live.json?key=%s&secret=%s&fixture_id="

    def __init__(self, match):
        self.match = match
        self.endOfMatchStr = 'FT'
        self.get_fixtures_url %= (self.api_key, self.api_secret)
        self.get_fixtures_url += match.get("league_id")
        self.get_live_url %= (self.api_key, self.api_secret)
        self.fixture_id = self.findLiveMatch()
        if self.fixutre_id:
            self.get_live_url += self.fixutre_id

    def canBeMonitored(self):
        return self.fixture_id is not None

    def findLiveMatch(self):
        league_fixtures = requests.get(self.get_fixtures_url).json()
        for fixture in league_fixtures['data']['fixtures']:
            if Utils.similar_strings(fixture['home_name'], self.match.get("home")) > 0.51 and Utils.similar_strings(fixture['away_name'], self.match.get("away")) > 0.51:
                return fixture['id']
        return None

    def refresh_fixture(self):
        return requests.get(self.get_live_url).json()

    def getMatchTime(self):
        live = self.refresh_fixture()
        minutes = live['data']['match'][0]['time']
        if not minutes.isnumeric():
            return None
        return int(minutes.strip())

    def getTotalGoals(self):
        live = self.refresh_fixture()
        score = live['data']['match'][0]['score']
        if '-' in score:
            home, away = score.split('-')
            return int(home.strip()) + int(away.strip())
        else:
            return None

