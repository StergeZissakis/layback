from DBRow import DBRow

class DailyMatchRow(DBRow):

    def __init__(self):
        self.table_name = "daily_over_under"
        self.data = {
                "home": None,
                "away": None,
                "date_time": None,
                "url": None
                }

