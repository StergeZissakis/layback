#!/bin/bash

source env/bin/activate

#echo "*** Running Daily Scheduler..."
python -u ./DailyScheduler.py  2>&1 | tee -a logs/daily_scheduler.log 

