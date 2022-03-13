#!/bin/bash

cd ~/dev/speedtest_rrd || exit 1

# https://jyge.fi/2015/08/13/howto-speedtest-cli-with-rrd/

MYRRD="speedtest.rrd"
./00_get_my_speedtest_status.sh \
  >raw.txt
# retry if no results:
while grep "Invalid server ID" tmp ; do
  sleep 15s
  ./00_get_my_speedtest_status.sh \
    >raw.txt
done
MYDATA=$(tail raw.txt -n20|gawk 'BEGIN{ORS=":";i=0;}{print;i=i+1;}END{if(i<3) for(;i<3;i++)print "-400";}'|sed -e 's/:$//g')
# exit with error and do NOT update RRD:
grep ^0 raw.txt -q && exit 1
rrdtool update $MYRRD N:"$MYDATA"
# https://forum.syncthing.net/t/why-are-rrd-files-transferred-by-time-and-not-immediately/16391
touch $MYRRD

### added by me:
rm -f raw.txt
###

