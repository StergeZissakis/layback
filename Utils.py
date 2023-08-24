import time
import difflib
import pprint
from difflib import SequenceMatcher
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
        if c == '-': #if c in "!@#$%^&*()[]{};:,./<>?\|`~-=_+":
            c = ' '
        ret += c
    return ret.lower().strip()

def compare_team_names(a, b):
    #pp = pprint.PrettyPrinter(indent=4)
    ca, cb = replaceSpecialChars(a.strip().lower()), replaceSpecialChars(b.strip().lower())
    pa, pb = ca.split(' '), cb.split(' ')
    matches = 0
    for A in pa:
        for B in pb:
            #if  A == B or A in B or B in A or A in pb or B in pa:
            if  A == B or A in B or SequenceMatcher(None, A, B).ratio() >= 0.5:
                matches += 1
    if matches == 0 and SequenceMatcher(None, ca, cb).ratio() >= 0.5:
        matches += 1
    #pp.pprint("[" + a + "] vs [" + b + "] = " + str(matches))
    return matches
