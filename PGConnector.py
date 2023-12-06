import psycopg2
import logging


class PGBase:

    def __init__(self, db, db_host, db_user='postgres', db_pass='postgres', db_port=5432):  # p0stgr35
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

    def select_row(self, row):
        cursor = self.pg.cursor()
        cursor.execute(row.generate_select())
        ret = cursor.fetchall()
        cursor.close()
        return ret

    def insert(self, row):
        sql = row.generate_sql_insert_into_values()
        values = row.generate_sql_insert_values()
        cursor = self.pg.cursor()
        cursor.execute(sql, values)
        self.pg.commit()
        cursor.close()

    def update(self, row):
        sql = row.generate_update()
        if len(sql):
            cursor = self.pg.cursor()
            cursor.execute(sql)
            self.pg.commit()
            cursor.close()
        else:
            logging.error("Row update attempted without data.")

    def insert_or_update(self, row):
        sql = '%s ON CONFLICT ON CONSTRAINT %s_pkey DO UPDATE SET %s RETURNING id' % (row.generate_sql_insert_into_values(), row.table_name, row.generate_do_update_set())
        values = row.generate_sql_insert_values()
        cursor = self.pg.cursor()
        cursor.execute(sql, values)
        self.pg.commit()
        rid = None
        try:
            rid = cursor.fetchone()
            self.pg.commit()
            cursor.close()
        except  Exception as Argument:
            logging.exception("Exception in insert_or_update. Remeding..")
            cursor.close()
            cursor = self.pg.cursor()
            sql = row.generate_select('id')
            cursor.execute(sql)
            rid = cursor.fetchone()
            cursor.close()
        finally:
            cid = rid[0]

        if row.get("id") is not None:
            cid = row.get("id")
        else:
            row.set("id", cid)
        return cid

    def delete(self, row, where=''):
        sql = row.generate_delete(where)
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
