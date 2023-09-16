from itertools import islice
from collections import defaultdict
import logging


class DBRow:

    data = defaultdict(dict)
    table_name = str()

    def __str__(self):
        return '{%s-[%s]}' % (self.table_name, self.data)

    def set(self, key, value):
        self.data[key] = value

    def get(self, key):
        if key in self.data.keys():
            return self.data[key]
        return None

    def generate_sql_insert_into_values(self):
        local_data = self.data.copy()
        sql = 'INSERT INTO ' + self.table_name + ' ('
        to_pop = []
        for k in local_data.keys():
            if local_data[k] is not None:
                sql += '"%s", ' % (k,)
            else:
                to_pop.append(k)
        for p in to_pop:
            local_data.pop(p)
        sql = sql[0:-2] + ') VALUES ( ' + '%s, ' * (len(local_data.keys()) - 1) + '%s) '
        logging.debug("sql_insert_into_values: %s" % (sql,))
        return sql

    def generate_do_update_set(self):
        sql = ""
        for k in islice(self.data.keys(), 3, None):  
            if self.data[k] is not None:
                sql += ' %s = EXCLUDED.%s, ' % (k, k)
        sql = sql[0:-2]
        logging.debug("do_update_set: %s" % (sql,))
        return sql

    def generate_sql_insert_values(self):
        vals = []
        for v in self.data.values():
            if isinstance(v, list) and len(v) == 0: 
                pass
            elif v is not None:
                vals.append(v)

        logging.debug("sql_insert_values: %s" % (vals,))
        return vals

    def generate_select(self, columns=None):
        if columns is None:
            columns = []
        cols = ','.join(columns)
        if not (cols and len(cols)):
            cols = '*' 
        sql = 'SELECT %s FROM "%s" ' % (cols, self.table_name)
        where = '    '
        for k, v in self.data.items():
            if v is not None:
                where += ' %s="%s" and' % (k, v)
        if len(where) > 4:
            where = " where " + where
        sql += where[:-4] + ';'
        logging.debug("generate select: %s" % (sql,))
        return sql

    def generate_update(self):
        sets = ''
        for k, v in self.data.items():
            if v is not None and k != 'id':
                sets += " %s = '%s'," % (str(k), str(v))
        if len(sets):
            sets = sets[0:-1]
            return 'UPDATE public."%s" SET %s WHERE id=%s;' % (self.table_name, sets, self.data["id"])
        
        return None

    def generate_delete(self, where=''):
        sql = 'DELETE FROM ' + self.table_name
        if len(where):
            if "where " not in where.lower():
                where = " where " + where
        elif self.data["id"] is not None:
            where = " where id = %s" % self.data["id"]
        sql += where + ";"
        logging.debug("generate delete: %s" % sql)
        return sql
