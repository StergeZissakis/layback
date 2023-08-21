import time
import Utils
from  PGConnector import PGConnector
from Browser import Browser
from datetime import datetime, timezone
from DailyMatchRow import DailyMatchRow
from MatchMonitor import monitorMatch
from multiprocessing import Process


if __name__ == "__main__":
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)

    browser = Browser()
    dummy = DailyMatchRow()

    matches = db.select("SELECT * FROM " + dummy.table_name + " WHERE url is not Null ORDER BY date_time ASC, id ASC;")
    now = datetime.now(timezone.utc)
    for m in matches:
        mid = m[0]
        dateTime = m[3]
        if now > dateTime:
            p = Process(target=monitorMatch, args=(mid,))
            p.start()
            print("Spawn match id [%s] @ [%s] with starting time [%s]" % (mid, now, dateTime))
            #db.archive(dummy.table_name, mid)
    




