import time
import logging
import math
import random
from difflib import SequenceMatcher


def add_time_to_date(event_date, event_time):
    (hour, minute) = str(event_time).split(":")
    return event_date.replace(hour=int(hour), minute=int(minute), second=0, microsecond=0)


def ratio_odds_to_decimal(odds):
    if odds.find('/') == -1:
        return odds

    (nom, denom) = odds.split('/')
    decimal = (int(nom) / int(denom) + 1)
    return decimal

def stringsContainmentScore(lhs, rhs):
    score = 0
    for l in lhs.split(' '):
        if l in rhs:
            score += 1
    for r in rhs.split(' '):
        if r in lhs:
            score += 1
    return score

def replaceSpecialChars(s):
    mappings = { '-': ' ',
                 'Ø': 'o',
                 'ø': 'o'
                 # "-rø!@#$%^&*()[]{};:,./<>?\|`~-=_+"
            }
    ret = ''
    for c in s:
        if c in mappings.keys():
            c = mappings[c]
        ret += c
    return ret.lower().strip()


def compare_team_names(a, b):
    # pp = pprint.PrettyPrinter(indent=4)
    ca = replaceSpecialChars(a.strip().lower())
    cb = replaceSpecialChars(b.strip().lower())
    pa = ca.split(' ')
    pb = cb.split(' ')
    matches = 0
    for xa in pa:
        for yb in pb:
            # if  xa == yb or A in B or B in A or A in pb or B in pa:
            if xa == yb or xa in yb or SequenceMatcher(None, xa, yb).ratio() >= 0.8:
                matches += 1
    # if matches == 0 and SequenceMatcher(None, ca, cb).ratio() >= 0.8:
    if SequenceMatcher(None, ca, cb).ratio() >= 0.8:
        matches += 1
    return matches

def similar_strings(str1, str2):
    return SequenceMatcher(None, str1, str2).ratio()

def initialise_logger(process_name):
    fmt = "%(process)d %(levelname)s %(asctime)s - %(message)s"
    logging.basicConfig(level=logging.INFO, filename="./logs/"+str(process_name)+".log", format=fmt)


def calculateStakeFor(euros, odds):
    return str(math.ceil(float(euros) / (float(odds) - 1.0)))


def sleep_for_millis(millis):
    time.sleep(millis / 1000)


def sleep_for_millis_random(limit):
    if limit > 100:
        sleep_for_millis(random.randint(100, limit))
    else:
        sleep_for_millis(random.randint(100, 1000))


def sleep_for_seconds(seconds):
    time.sleep(seconds)


def sleep_for_seconds_random(limit):
    if limit > 1:
        sleep_for_seconds(random.randint(1, limit))
    else:
        sleep_for_seconds(random.randint(1, 3))
