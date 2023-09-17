import psycopg2
import logging


class PGBase:

    def __init__(self, db, db_host, db_user='postgres', db_pass='p0stgr35', db_port=5432):
        self.pg = psycopg2.connect(database=db, host=db_host, user=db_user, password=db_pass, port=str(db_port))
        if self.pg is None:
            print("Database::CTOR [Failed to connect to database]")
        else:
            cursor = self.pg.cursor()
            cursor.execute("SET timezone TO 'Europe/London'")
            cursor.close()

    def is_connected(self):
        return self.pg is not None


class PGConnector(PGBase):

    def select(self, sql):
        cursor = self.pg.cursor()
        cursor.execute(sql)
        ret = cursor.fetchall()
        cursor.close()
        return ret

    def select_match(self, match):
        cursor = self.pg.cursor()
        cursor.execute(match.generate_select())
        ret = cursor.fetchall()
        cursor.close()
        return ret

    def insert(self, match):
        sql = match.generate_sql_insert_into_values()
        values = match.generate_sql_insert_values()
        cursor = self.pg.cursor()
        cursor.execute(sql, values)
        self.pg.commit()
        cursor.close()

    def update(self, match):
        sql = match.generate_update()
        if len(sql):
            cursor = self.pg.cursor()
            cursor.execute(sql)
            self.pg.commit()
            cursor.close()
        else:
            logging.error("Match update attempted without data.")

    def insert_or_update(self, match):
        sql = '%s ON CONFLICT ON CONSTRAINT %s_pkey DO UPDATE SET %s RETURNING id' % (match.generate_sql_insert_into_values(), match.table_name, match.generate_do_update_set())
        values = match.generate_sql_insert_values()
        cursor = self.pg.cursor()
        print(sql + " " + str(values))
        cursor.execute(sql, values)
        self.pg.commit()
        rid = None
        try:
            rid = cursor.fetchone()
            self.pg.commit()
            cursor.close()
        except:
            cursor.close()
            cursor = self.pg.cursor()
            sql = match.generate_select('id')
            cursor.execute(sql)
            rid = cursor.fetchone()
            cursor.close()
        finally:
            cid = rid[0]

        if match.get("id") is not None:
            cid = match.get("id")
        else:
            match.set("id", id)
        return cid

    def delete(self, match, where=''):
        sql = match.generate_delete(where)
        cursor = self.pg.cursor()
        cursor.execute(sql)
        self.pg.commit()
        cursor.close()

    def execSql(self, sql):
        cursor = self.pg.cursor()
        cursor.execute(sql)
        self.pg.commit()
        cursor.close()

    def execute(self, call):
        sql = 'SELECT public."' + call + '"();'
        cursor = self.pg.cursor()
        cursor.execute(sql)
        self.pg.commit()
        cursor.close()
