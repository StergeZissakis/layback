from DBRow import DBRow

class BetRow(DBRow):

    def __init__(self):
        self.table_name = "over2p5bets"
        self.data = {
                "MatchDateTime": None,
                "Home": None,
                "Away": None,
                "LayBack": None,
                "OverUnder": None,
                "Goals": None,
                "Odds": None,
                "OddsRecorded": None,
                "Amount": None
                }
