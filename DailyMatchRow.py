from DBRow import DBRow

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
        if self.data["home"] != other.data["home"]:
            return False
        if self.data["away"] != other.data["away"]:
            return False
        if self.data["date_time"] != other.data["date_time"]:
            return False
        return True
