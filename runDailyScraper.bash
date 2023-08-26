#!/bin/bash

export DISPLAY=:0
source ./env/bin/activate

python3 -u ./DailyScraper.py $* 2>&1 | tee -a logs/daily_scraper.log 
