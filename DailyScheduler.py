import time
import Utils
import logging
from Utils import initialise_logger
from  PGConnector import PGConnector
from Browser import Browser
from datetime import datetime, timezone
from DailyMatchRow import DailyMatchRow
from MatchMonitor import monitorMatch
from multiprocessing import Process


if __name__ == "__main__":
    initialise_logger("DailyScheduler")
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)

    browser = Browser()

    processes = []

    matches = db.select('select * from "TodayMatches" where date_time < now() - interval \'15 minutes\' and plaied = false;')
    for m in matches:
        match = DailyMatchRow('TodayMatches')
        match.set("id", m[0])
        match.set("home", m[1])
        match.set("away", m[2])
        match.set("date_time", m[3])
        match.set("url", m[4])
        p = Process(target=monitorMatch, args=(match,))
        p.start()
        processes.append(p)
        logging.info("Spawn match [%s]" % (str(match),))
        update_match = DailyMatchRow('over2p5orbitxch')
        update_match.set("id", m[0])
        update_match.set("plaied", True)
        db.update(update_match)
        time.sleep(10)

    for p in processes:
        try:
            p.join()
        except:
            logging.debug("Failed to join on process  %s" % (str(p),))
            pass
