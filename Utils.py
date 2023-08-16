import time
from selenium.webdriver.common.by import By
from datetime import datetime, date, timedelta
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as ExpectedCondition

def count_children_divs(section_div):
    return len(section_div.find_elements(By.XPATH, './div'))

def get_section_kind(section_div):
    num_children_divs = count_children_divs(section_div)

    if num_children_divs == 1:
        return "Match"
    elif num_children_divs == 2:
        return "DateRow"
    elif num_children_divs == 3:
        return "TopHeader"

    return None
    
def get_event_date(section_div, event_date, kind):
    if kind == "TopHeader":
        date = section_div.find_element(By.XPATH, './div[2]/div[1]/div').text.split('-')[0].strip()
        print("Date: " + str(date))
        if date.startswith('Today'):
            return datetime.today()
        elif date.startswith('Yesterday'):
            return datetime.today() - timedelta(days=1)
        elif datetime.strptime(date, "%d %b %Y"):
            return datetime.strptime(date, "%d %b %Y")
    elif kind ==  "DateRow":
        date = section_div.find_element(By.XPATH, './div/div/div').text.split('-')[0].strip()
        print("Date: " + str(date))
        if datetime.strptime(date, "%d %b %Y"):
            return datetime.strptime(date, "%d %b %Y")

    return event_date

def get_event_time(section_div, kind):
    if kind  == "TopHeader":
        div = section_div.find_element(By.XPATH, './div[3]/div/a/div[1]/div/div/p')
    elif kind == "DateRow":
        try:
            div = section_div.find_element(By.XPATH, './div[2]/div/a/div[1]/div/div/p')
        except:
            div = section_div.find_element(By.XPATH, './div[3]/div/a/div[1]/div/div/p')
    elif kind == "Match":
        div = section_div.find_element(By.XPATH, './div/div/a/div[1]/div/div/p')
    else:
        return None

    return div.text

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
    return s.translate ({ord(c): " " for c in "!@#$%^&*()[]{};:,./<>?\|`~-=_+"}).strip()

def compare_team_names(a, b):
    ca, cb = replaceSpecialChars(a), replaceSpecialChars(b)
    pa, pb = a.split(' '), b.split(' ')
    matches = 0
    for s in pa:
        if s in pb:
            matches += 1
    return matches
