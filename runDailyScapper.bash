#!/bin/bash

export DISPLAY=:0
source ../../env/bin/activate

#sudo ../kill_vpn.bash
../kill_chrome.bash

#echo "*** Connecting to London..."
#nohup sudo ../config/connect_gb.sudo > ./logs/gb_vpn.log  2>&1 &
#echo $! > config/gb_vpn.pid
#grep -q "Initialization Sequence Completed" logs/gb_vpn.log
#while [ $? != 0 ];
#do
    #sleep 1
    #grep -q "Initialization Sequence Completed" logs/gb_vpn.log
#done;
#echo "*** Connected to London."

echo "*** Running Daily Scrapper Stats..."
python -u ./DailyScrapper.py $* 2>&1 | tee -a logs/daily_scrapper.log 
echo "*** Daily Scapper Finished."

#kill `cat ../config/gb_vpn.pid`
#rm -f ../config/gb_vpn.pid
#sudo ../kill_vpn.bash
../kill_chrome.bash
