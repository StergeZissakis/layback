import math

from DBRow import DBRow


class BetRow(DBRow):
    def __init__(self):
        self.table_name = "over2p5bets"
        self.data = {
            "id": None,
            "MatchDateTime": None,
            "Home": None,
            "Away": None,
            "BetDateTime": None,
            "LayBack": None,
            "OverUnder": None,
            "Goals": None,
            "Odds": None,
            "OddsRecorded": None,
            "Amount": None,
            "BetResult": None,
            "BetResultTime": None
        }

    def reconcile(self, totalGoals):
        betResultValue = self.get("BetResult")
        if betResultValue is not None and betResultValue == 'Lapsed':
            return False
        layBack = self.get("LayBack")
        overUnder = self.get("OverUnder")
        betGoals = float(self.get("Goals"))
        scoredGoals = int(totalGoals)
        if layBack == 'Lay':
            if overUnder == "Under":
                if scoredGoals > betGoals:
                    self.set("BetResult", "Won")
                else:
                    self.set("BetResult", "Lost")
            elif overUnder == "Over": # it's an Over
                if scoredGoals < betGoals:
                    self.set("BetResult", "Won")
                else:
                    self.set("BetResult", "Lost")
        elif layBack == 'Back':
            if overUnder == "Under":
                if scoredGoals < betGoals:
                    self.set("BetResult", "Won")
                else:
                    self.set("BetResult", "Lost")
            elif overUnder == "Over": # it's an Over
                if scoredGoals > betGoals:
                    self.set("BetResult", "Won")
                else:
                    self.set("BetResult", "Lost")
        return True
