#!/bin/bash

source ./env/bin/activate

python3 -u ./DailyScheduler.py $* 2>&1 | tee -a logs/daily_scheduler.log 

