import time
import difflib
from selenium.webdriver.common.by import By
from datetime import datetime, date, timedelta
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as ExpectedCondition

def add_time_to_date(event_date, event_time):
    (hour, minute) = str(event_time).split(":")
    return event_date.replace(hour=int(hour), minute=int(minute), second=0, microsecond=0)

def ratio_odds_to_decimal(self, odds):
    if odds.find('/') == -1:
        return odds

    (nom, denom) = odds.split('/')
    decimal = (int(nom) / int(denom) + 1)
    return decimal

def replaceSpecialChars(s):
    return s.translate ({ord(c): '' for c in " !@#$%^&*()[]{};:,./<>?\|`~-=_+"}).strip()

def compare_team_names(a, b):
    #ca = replaceSpecialChars(a).strip().lower()
    #cb = replaceSpecialChars(b).strip().lower()
    return difflib.SequenceMatcher(a.lower(), b.lower()).ratio() > 0.8
