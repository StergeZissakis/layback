import time
import logging
import daemon
import Utils
from Utils import initialise_logger
from PGConnector import PGConnector
from DailyMatchRow import DailyMatchRow
from MatchMonitor import monitor
from multiprocessing import Process


with daemon.DaemonContext():
    while True:
        db = PGConnector("postgres", "192.168.1.156")
        if not db.is_connected():
            exit(-1)

        liveMatches = []
        select  = ' select id, home, away, date_time, league_id, url '
        select += ' from "TodayMatches" '
        select += " where plaied = false and (date_time::timestamp, date_time::timestamp) OVERLAPS ((now()::timestamp - interval '45 minutes') , (now()::timestamp - interval '15 minutes'))"

        matches = db.select(select)
        for m in matches:
            match = DailyMatchRow('TodayMatches')
            match.set("id", m[0])
            match.set("home", m[1])
            match.set("away", m[2])
            match.set("date_time", m[3])
            match.set("league_id", m[4])
            match.set("url", m[5])
            p = Process(target=monitor, args=(match,))
            p.start()
            liveMatches.append(match)
            logging.info("Spawned match [%s]" % match)
            update_match = DailyMatchRow('over2p5orbitxch')
            update_match.set("id", m[0])
            update_match.set("plaied", True)
            db.update(update_match)
            time.sleep(5)

        Utils.sleep_for_seconds(60)
