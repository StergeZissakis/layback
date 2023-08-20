from DBRow import DBRow
from Utils import compare_team_names
from difflib import SequenceMatcher

class DailyMatchRow(DBRow):

    def __init__(self):
        self.table_name = "daily_over_2p5"
        self.data = {
                "home": None,
                "away": None,
                "date_time": None,
                "url": None
                }

    def equals(self, other):
        if self.data["date_time"].time() != other.data["date_time"].time():
            return False
        return self.equals_no_datetime(other)
    
    def equals_no_datetime(self, other):
        home = compare_team_names(self.data["home"], other.data["home"])
        away = compare_team_names(self.data["away"], other.data["away"])
        return home > 0 and away > 0
