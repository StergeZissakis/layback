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

    processes = []

    matches = db.select("SELECT * FROM " + dummy.table_name + " WHERE url is not Null and date_time < now() - interval '15 minutes'  ORDER BY date_time ASC, id ASC;")
    #matches = db.select("SELECT * FROM " + dummy.table_name + " WHERE url is not Null and date_time between (now() - interval '60 minutes') AND (now() - interval '36 minutes') ORDER BY date_time ASC, id ASC;")
    for m in matches:
        mid = m[0]
        dateTime = m[3]
        p = Process(target=monitorMatch, args=(mid,))
        p.start()
        processes.append(p)
        print("Spawn match id [%s] @ [%s] with starting time [%s]" % (mid, datetime.now(), dateTime))
        time.sleep(15)

    for p in processes:
        try:
            p.join()
        except:
            pass
