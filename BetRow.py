from DBRow import DBRow

class BetRow(DBRow):

    def __init__(self):
        self.table_name = "over2p5bets"
        self.data = {
                "match_id": None,
                "LayBack": None,
                "OverUnder": None,
                "Goals": None,
                "odds": None,
                "odds_recorded": None,
                "amount": None
                }
