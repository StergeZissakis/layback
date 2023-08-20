#!/bin/bash

export DISPLAY=:0
source ./env/bin/activate


echo "*** Running Daily Scraper Stats..."
python -u ./DailyScraper.py $* 2>&1 | tee -a logs/daily_scraper.log 
echo "*** Daily Scapper Finished."

