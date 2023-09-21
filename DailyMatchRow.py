from DBRow import DBRow


class DailyMatchRow(DBRow):

    def __init__(self, table_name):
        self.table_name = table_name
        self.data = {
                "id": None,
                "home": None,
                "away": None,
                "date_time": None,
                "league_id": None,
                "url": None
                }
    def __str__(self):
        return '%s: [%s] [%s]vs[%s]@[%s]->"%s" L[%s]' % (self.table_name, self.data["id"], self.data["home"], self.data["away"], self.data["date_time"], self.data["url"], self.data["league_id"])
