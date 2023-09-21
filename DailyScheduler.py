import time
import logging
from Utils import initialise_logger
from PGConnector import PGConnector
from DailyMatchRow import DailyMatchRow
from MatchMonitor import monitor
from multiprocessing import Process


if __name__ == "__main__":
    initialise_logger("DailyScheduler")
    db = PGConnector("postgres", "localhost")
    if not db.is_connected():
        exit(-1)

    processes = []

    matches = db.select('select * from "TodayMatches" where plaied = false and (date_time, date_time) OVERLAPS ((now()::timestamp - interval \'45 minutes\') , (now()::timestamp - interval \'15 minutes\'))')
    for m in matches:
        match = DailyMatchRow('TodayMatches')
        match.set("id", m[0])
        match.set("home", m[1])
        match.set("away", m[2])
        match.set("date_time", m[3])
        match.set("url", m[4])
        match.set("league_id", m[6])
        p = Process(target=monitor, args=(match,))
        p.start()
        processes.append(p)
        logging.info("Spawned match [%s]" % match)
        update_match = DailyMatchRow('over2p5orbitxch')
        update_match.set("id", m[0])
        update_match.set("plaied", True)
        db.update(update_match)
        time.sleep(5)

    for p in processes:
        try:
            p.join()
        except  Exception as Argument:
            logging.exception("Failed to join on process  %s" % str(p))
            pass
