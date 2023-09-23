import logging
import Utils 
import requests
import json
from Browser import Browser
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException

class APILivePage:
    match = None
    api_key = "Fv6kKZy7fwSLBTB7"
    api_secret = "Bef6mREpHUEqpF44aboUaW2qsUc4ONbp"
    fixture_id = None
    #get_fixtures_url = "https://livescore-api.com/api-client/fixtures/matches.json?key=%s&secret=%s&date=today&lang=en&competition_id="
    get_fixtures_url = "https://livescore-api.com/api-client/scores/live.json?key=%s&secret=%s&date=today&lang=en&competition_id="
    get_live_url = "https://livescore-api.com/api-client/scores/live.json?key=%s&secret=%s&fixture_id="
    last_known_score = None
    last_known_time = None
    last_known_status = None
    def __init__(self, match):
        self.match = match
        self.endOfMatchStr = 'FT'
        self.get_fixtures_url %= (self.api_key, self.api_secret)
        self.get_fixtures_url += str(match.get("league_id"))
        self.get_live_url %= (self.api_key, self.api_secret)
        self.fixture_id = self.findLiveMatch()
        if self.fixture_id:
            self.get_live_url += str(self.fixture_id)

    def canBeMonitored(self):
        return self.fixture_id is not None

    def findLiveMatch(self):
        matches = requests.get(self.get_fixtures_url).json()
        for match in matches['data']['match']:
            if Utils.similar_strings(match['home_name'], self.match.get("home")) > 0.51 and Utils.similar_strings(match['away_name'], self.match.get("away")) > 0.51:
                return match['fixture_id']
        return None

    def refresh_fixture(self):
        response = requests.get(self.get_live_url)
        if response.status_code != 200:
            return None
        js_resp = response.json()
        if js_resp['success'] is not True:
            return None
        return response.json()

    def getMatchTime(self):
        live = self.refresh_fixture()
        if live is None and self.last_known_time is not None:
            logging.info("Failed to get current match time. Using last known %s" % self.last_known_time)
            return self.last_known_time
        minutes = live['data']['match'][0]['time'].strip().split('+')[0]
        if not minutes.isnumeric():
            return self.last_known_time
        tm = int(minutes.strip())
        self.last_known_time = tm
        return tm

    def getMatchStatus(self):
        live = self.refresh_fixture()
        if live is None and self.last_known_status is not None:
            logging.info("Failed to get current match status. Using last known %s" % self.last_known_status)
            return self.last_known_status
        status = live["data"]["match"][0]["status"]
        if isinstance(status, str):
            if status == 'NOT STARTED':
                self.last_known_status = "NS"
            elif status in ("IN PLAY", "ADDED TIME"):
                tm = self.getMatchTime()
                if tm <= 45:
                    self.last_known_status = '1H'
                else:
                    self.last_known_status = '2H'
            elif status == "HALF TIME BREAK":
                self.last_known_status = "HT"
            elif status == "FINISHED":
                self.last_known_status = "FT"
            else:
                pass # use last known status
        return self.last_known_status

    def getTotalGoals(self):
        live = self.refresh_fixture()
        if live is None and self.last_known_score is not None:
            logging.info("Failed to get current score. Using last known %s" % self.last_known_score )
            return self.last_known_score
        score = live['data']['match'][0]['score']
        if '-' in score:
            home, away = score.split('-')
            sc = int(home.strip()) + int(away.strip())
            self.last_known_score = sc
            return sc
        else:
            return None

