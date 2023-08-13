import psycopg2
import sqlparse
from DailyMatchRow import DailyMatchRow

class PGBase:

    def __init__(self, db, db_host, db_user='postgres', db_pass='p0stgr35', db_port=5432):
        self.pg = psycopg2.connect(database=db, host=db_host, user=db_user, password=db_pass, port=str(db_port))
        if self.pg is None:
            print("DatabasE::CTOR [Failed to connect to databse]")

    def is_connected(self):
        return self.pg is not None

class PGConnector(PGBase):

    def insert(self, row):
        sql = row.generate_sql_insert_into_values()
        values = row.generate_sql_insert_values()
        cursor = self.pg.cursor()
        cursor.execute( sql, values )
        self.pg.commit()
        cursor.close()

    def insert_or_update(self, row):

        sql = row.generate_sql_insert_into_values() + ' ON CONFLICT ON CONSTRAINT ' + match.table_name + '_unique DO UPDATE SET ' + match.generate_do_update_set();
        values = match.generate_sql_insert_values()
        cursor = self.pg.cursor()
        cursor.execute( sql, values )
        self.pg.commit()
        ret = cursor.fetchone();
        self.pg.commit()
        cursor.close()
        if ret is not None:
            ret = ret[0]
        else:
            cursor = self.pg.cursor()
            sql = match.generate_select(('id'))
            cursor.execute( sql )
            ret = cursor.fetchone()
            if ret is not None:
                ret = ret[0]
            cursor.close()

        return ret

    def insert_or_update_over(self, table_name, match_id, half, goals, odds, bet_links = [], payout = "", sql_checked = True):
        if not sql_checked and not self.validate_non_sql((str(match_id), str(half), str(goals), str(odds), str(payout))):
            print("Found SQL on page")
            return
        cursor = self.pg.cursor()
        cursor.execute( 
                'INSERT INTO "' + table_name + '" (match_id, half, goals, type, odds,  bet_links, payout) VALUES (%s, %s, %s, %s, %s, %s, %s) ' +
                'ON CONFLICT ON CONSTRAINT "' + table_name + '_unique" DO UPDATE SET odds = EXCLUDED.odds, payout = EXCLUDED.payout;',
                (str(match_id), str(half), goals, 'Over', odds, bet_links, str(payout))
                )

        self.pg.commit()
        cursor.close()

    def insert_or_update_under(self, table_name, match_id, half, goals, odds, bet_links = [], payout = "", sql_checked = True):
        if not sql_checked and not self.validate_non_sql((str(match_id), str(half), str(goals), str(odds), str(payout))):
            print("Found SQL on page")
            return

        cursor = self.pg.cursor()
        cursor.execute( 
                'INSERT INTO "' + table_name + '" (match_id, half, goals, type, odds, bet_links, payout) VALUES (%s, %s, %s, %s, %s, %s, %s) ' +
                'ON CONFLICT ON CONSTRAINT "' + table_name + '_unique" DO UPDATE SET odds = EXCLUDED.odds, payout = EXCLUDED.payout;',
                (str(match_id), str(half), goals, 'Under', odds, bet_links, str(payout))
                )

        self.pg.commit()
        cursor.close()

    def insert_or_update_over_under(self, table_name, match_id, half, data_array):
        for row in data_array:
            (goals, over, under, payout, bet_links) = row

            if over and str(over) not in ("", " ", "-"):
                self.insert_or_update_over(table_name, match_id, half, goals, over, bet_links, payout)

            if under and str(under) not in ("", " ", "-"):
                self.insert_or_update_under(table_name, match_id, half, goals, under, bet_links, payout)

    def update_historical_results_over_under(self, table_name, event_date_time, home_team, guest_team, home_goals, guest_goals, half_1_score, half_2_score):
        update_sql  = " UPDATE public.\"" + table_name + "\" " + " SET \"Home_Team_Goals\" = %s, "
        update_sql += " \"Guest_Team_Goals\" = %s, \"Home_Team_Goals_1st_Half\" = %s, \"Home_Team_Goals_2nd_Half\" = %s, "
        update_sql += " \"Guest_Team_Goals_1st_Half\" = %s, \"Guest_Team_Goals_2nd_Half\" = %s "
        where_sql   = " WHERE \"Date_Time\" = timestamp %s "
        params = list()
        params.append(home_goals)
        params.append(guest_goals)
        params.append(half_1_score.split(':')[0])
        params.append(half_2_score.split(':')[0])
        params.append(half_1_score.split(':')[-1])
        params.append(half_2_score.split(':')[-1])
        params.append(event_date_time)


        if len(home_team.split(' ')) > 1:
            home_parts = home_team.split(' ')
            where_home_sql = " (\"Home_Team\" = ANY(%s) OR SPLIT_PART(\"Home_Team\", ' ', 1) = ANY(%s)) "
            params.append(home_parts)
            params.append(home_parts)
        else:
            where_home_sql = " (\"Home_Team\" = %s OR %s = ANY(string_to_array(\"Home_Team\", ' '))) "
            params.append(home_team)
            params.append(home_team)

        if len(guest_team.split(' ')) > 1:
            guest_parts = guest_team.split(' ')
            where_guest_sql = " (\"Guest_Team\" = ANY(%s) OR SPLIT_PART(\"Guest_Team\", ' ', 1) = ANY(%s)) "
            params.append(guest_parts)
            params.append(guest_parts)
        else:
            where_guest_sql = " (\"Guest_Team\" = %s OR %s = ANY(string_to_array(\"Guest_Team\", ' '))) "
            params.append(guest_team)
            params.append(guest_team)

        sql_update = update_sql + where_sql + " AND " + where_home_sql + " AND " + where_guest_sql + " ; "
        cursor = self.pg.cursor()
        cursor.execute(sql_update, params)
        self.pg.commit()
        cursor.close()

    def insert_or_update_soccer_statistics(self, soccerStatsRow):

        sql = soccerStatsRow.generate_sql_insert_into_values() + ' ON CONFLICT ON CONSTRAINT ' + soccerStatsRow.table_name + '_unique DO UPDATE SET ' + soccerStatsRow.generate_do_update_set();
        #print(sql)
        values = soccerStatsRow.generate_sql_insert_values()
        #print(values)
        cursor = self.pg.cursor()
        cursor.execute( sql, values )
        self.pg.commit()
        cursor.close()

    def getLatestRecordDateTimeOfSoccerStats(self):
        ssr = SoccerStatsRow()
        sql = "SELECT max(date_time) as max_date_time from public." + ssr.table_name + ";"

        cursor = self.pg.cursor()
        cursor.execute( sql )
        res = cursor.fetchone()
        if res is not None:
            res = res[0]

        cursor.close()
        return res
