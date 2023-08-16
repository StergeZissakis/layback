from DBRow import DBRow
from Utils import compare_team_names

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
        if self.data["date_time"] != other.data["date_time"]:
            return False
        return self.equals_no_datetime(other)
    
    def equals_no_datetime(self, other):
        home_matches = compare_team_names(self.data["home"], other.data["home"])
        away_matches = compare_team_names(self.data["away"], other.data["away"])
        return home_matches > 0 and away_matches > 0
