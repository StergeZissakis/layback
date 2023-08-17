import re
import time
import Utils
from  PGConnector import PGConnector
from Browser import Browser
from datetime import datetime
from DailyMatchRow import DailyMatchRow

def monitorMatch(mid):
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)

    browser = Browser()
    dummy = DailyMatchRow()
    match = db.select("SELECT url FROM " + dummy.table_name + " WHERE id = '%s';" % mid)
    print(match[0])
