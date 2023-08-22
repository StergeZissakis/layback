from itertools import islice
from collections import defaultdict

class DBRow:

    data = defaultdict(dict)
    table_name = str()

    def __str__(self):
        ret = ""
        for key, value in self.data.items():
            ret += f"{key} = '{value}'\n"
        return ret

    def set(self, key, value):
        self.data[key] = value

    def get(self, key):
        if key in self.data.keys():
            return self.data[key]
        return None

    def generate_sql_insert_into_values(self):
        sql = 'INSERT INTO ' + self.table_name + ' ('
        for k in self.data.keys():
            sql += '"' + k + '",'
        sql = sql[0:-1] + ') VALUES ( ' + '%s, ' * (len(self.data.keys()) - 1) + '%s) '
        return sql

    def generate_do_update_set(self):
        ret = ""

        for k in islice(self.data.keys(), 3, None):  
            ret += ' ' + k + ' = EXCLUDED.' + k + ', '

        return ret[0:-2]

    def generate_sql_insert_values(self):
        vals = []
        for v in self.data.values():
            if isinstance(v, list) and len(v) == 0: 
                pass
            else:
                vals.append( v )

        return vals

    def generate_select(self, columns = []):
        cols = ','.join(columns)
        if not (cols and len(cols)):
            cols = '*' 
        ret = 'SELECT ' + cols + ' FROM "' + self.table_name + '" where ' 
        for k, v in self.data:
            ret = ret + ' ' + k + '="' + v + '" and'
        ret = ret[:-4] + ';'
        return ret

    def generate_delete(self, where=''):
        ret = 'DELETE FROM ' + self.table_name
        if len(where):
            ret += ' ' + where
        ret += ";"
        return ret

