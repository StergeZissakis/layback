from DBRow import DBRow
from Utils import compare_team_names
import datetime

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
        if self.data["date_time"] is not None and isinstance(self.data["date_time"], datetime.datetime) and \
           other.data["date_time"] is not None and isinstance(other.data["date_time"], datetime.datetime):
            sdate, odate = self.data["date_time"], other.data["date_time"]
            if sdate == odate:
                return self.equals_no_datetime(other)
            #time_diff = sdate - odate if sdate > odate else odate - sdate
            #if( (time_diff.total_seconds() / 60) >= 15 ):
            #return False
            
        return False
    
    def equals_no_datetime(self, other):
        if other is None:
            print("other None detected")
            return False
        home = compare_team_names(self.data["home"], other.data["home"])
        away = compare_team_names(self.data["away"], other.data["away"])
        return home > 0 and away > 0
