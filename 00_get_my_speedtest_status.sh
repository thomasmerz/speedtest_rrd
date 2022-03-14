#!/bin/bash

cd ~/dev/speedtest_rrd || exit 1

# https://jyge.fi/2015/08/13/howto-speedtest-cli-with-rrd/

# This is 'what speedtest-cli -server XXXXX -share' typically gives:
#
# Retrieving speedtest.net configuration…
# Retrieving speedtest.net server list…
# Testing from Masternet Inc (185.9.12.1)…
# Hosted by Masternet Inc (Eastwesttown) [1.41 km]: 15.286 ms
# Testing download speed………………………………….
# Download: 98.56 Mbit/s
# Testing upload speed…………………………………………..
# Upload: 1.91 Mbit/s
# Share results: https://www.speedtest.net/result/076719.png

#this a regexp to figure out numbers most of the kind

re='^-?[0-9]+([.][0-9]+)?$'

MYPING=0
MYUPLOAD=0
MYDOWNLOAD=0

# Use this or replace this with your known city
MYSERVER=$(speedtest --list | grep -v 'Retrieving' | awk '{print $1}'|sed -e 's#)##g'|head -1)
if [[ $MYSERVER =~ $re ]] ;
then
  MYRETURN=$(speedtest --server "$MYSERVER")
  echo "$MYRETURN">tmp
  MYPING=$(grep -i "^Hosted by" tmp|awk '{print $(NF-1)}')
  #       echo "ping=$MYPING"
  MYUPLOAD=$(grep -i "^Download" tmp|awk '{print $(NF-1)}')
  #       echo "uplink=$MYUPLOAD"
  MYDOWNLOAD=$(grep -i "^Upload" tmp|awk '{print $(NF-1)}')
  #       echo "downlink=$MYDOWNLOAD"
  #MYLINK=$(grep -i "^Share results" tmp|awk '{print $(NF)}')
  #       echo "piclink=$MYLINK"
fi
### added by me:
###rm -f tmp
###
if [[ $MYPING =~ $re ]] && [[ $MYUPLOAD =~ $re ]] && [[ $MYDOWNLOAD =~ $re ]] ;
then
  #       echo "Got values:"
  echo "$MYPING"
  echo "$MYUPLOAD"
  echo "$MYDOWNLOAD"
  else
  #       echo "NO values:"
  echo "0"
  echo "0"
  echo "0"
fi

