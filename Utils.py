import time
import difflib
import pprint
import logging
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
    mappings = { '-': ' ',
                 'Ø': 'o',
                 'ø': 'o'
                 #"-rø!@#$%^&*()[]{};:,./<>?\|`~-=_+"
            }
    ret = ''
    for c in s:
        if c in mappings.keys():
            c = mappings[c]
        ret += c
    return ret.lower().strip()

def compare_team_names(a, b):
    #pp = pprint.PrettyPrinter(indent=4)
    ca = replaceSpecialChars(a.strip().lower())
    cb = replaceSpecialChars(b.strip().lower())
    pa = ca.split(' ')
    pb = cb.split(' ')
    matches = 0
    for xa in pa:
        for yb in pb:
            #if  xa == yb or A in B or B in A or A in pb or B in pa:
            if  xa == yb or xa in yb or SequenceMatcher(None, xa, yb).ratio() >= 0.8:
                matches += 1
    #if matches == 0 and SequenceMatcher(None, ca, cb).ratio() >= 0.8:
    if SequenceMatcher(None, ca, cb).ratio() >= 0.8:
        matches += 1
    return matches

def initialise_logger(process_name):
    fmt = "%(process)d %(levelname)s %(asctime)s - %(message)s"
    logging.basicConfig(level=logging.INFO, filename="./logs/"+str(process_name)+".log", format=fmt)
