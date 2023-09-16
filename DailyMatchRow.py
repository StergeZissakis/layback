from DBRow import DBRow


class DailyMatchRow(DBRow):

    def __init__(self, table_name):
        self.table_name = table_name
        self.data = {
                "id": None,
                "home": None,
                "away": None,
                "date_time": None,
                "url": None
                }
