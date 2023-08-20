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
    ret = ''
    for c in s:
        if c in "!@#$%^&*()[]{};:,./<>?\|`~-=_+":
            c = ' '
        ret += c
    return ret.lower().strip()

def compare_team_names(a, b):
    ca, cb = replaceSpecialChars(a.strip().lower()), replaceSpecialChars(b.strip().lower())
    pa, pb = a.split(' '), b.split(' ')
    matches = 0
    for s in pa:
        if s in pb:
            matches += 1
    return matches
