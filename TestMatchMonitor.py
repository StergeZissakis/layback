from  MatchMonitor import *
import unittest 
import logging
from unittest.mock import MagicMock
from Utils import initialise_logger
import sys

if __name__ == '__main__':
    initialise_logger("tester")
    monitorMatch(match_id = 0, url = 'https://www.orbitxch.com/customer/sport/1/market/1.217287404')
