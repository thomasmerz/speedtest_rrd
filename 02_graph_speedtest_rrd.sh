#!/bin/bash

cd ~/dev/speedtest_rrd || exit 1

# https://jyge.fi/2015/08/13/howto-speedtest-cli-with-rrd/

# last 12hours: -end now -start end-43200s
# last 24hours: -end now -start end-86400s
# last week: -end now -start end-604800s
# last month: -end now -start end-2419200s
# last year: -end now -start end-31536000s

PARAMS_ARRAY=("-s e-24h" "-s e-1w" "-s e-1m" "-s e-1y")
TITLE_ARRAY=("Last 24h" "Last week" "Last month" "Last year")
FILENAME_ARRAY=("24h" "week" "month" "year")

#DS:MY-PING:GAUGE:120:0:6000 \
#DS:MY-DOWNLINK:GAUGE:120:0:3000 \
#DS:MY-UPLINK:GAUGE:120:0:3000 \

for N in {0..3}; do

  rrdtool graphv -J speedtest-ping-"${FILENAME_ARRAY[$N]}".png -a PNG --title="Ping ${TITLE_ARRAY[$N]}" \
  --vertical-label "ms" -h 500 -w 1200 \
  "${PARAMS_ARRAY[$N]}" \
  "DEF:T=speedtest.rrd:MY-PING:AVERAGE" \
  "DEF:TMAX=speedtest.rrd:MY-PING:MAX" \
  "AREA:TMAX#ffb6c1:Ping max" \
  "LINE1:T#ff0000:Ping" \
  "GPRINT:T:LAST:Last Ping\: %2.1lf ms" \
  "GPRINT:TMAX:MAX:Max Ping\: %2.1lf ms"

  rrdtool graphv -J speedtest-downlink-"${FILENAME_ARRAY[$N]}".png -a PNG --title="Downlink speed ${TITLE_ARRAY[$N]}" \
  --vertical-label "Mbit/s" -h 500 -w 1200 \
  "${PARAMS_ARRAY[$N]}" \
  "DEF:T=speedtest.rrd:MY-DOWNLINK:AVERAGE" \
  "DEF:TMAX=speedtest.rrd:MY-DOWNLINK:MAX" \
  "AREA:TMAX#ffb6c1:Down max" \
  "LINE1:T#ff0000:Downlink" \
  "GPRINT:T:LAST:Last downlink\: %2.1lf Mbit/s" \
  "GPRINT:TMAX:MAX:Max downlink\: %2.1lf Mbit/s"

  rrdtool graphv -J speedtest-uplink-"${FILENAME_ARRAY[$N]}".png -a PNG --title="Uplink speed ${TITLE_ARRAY[$N]}" \
  --vertical-label "Mbit/s" -h 500 -w 1200 \
  "${PARAMS_ARRAY[$N]}" \
  "DEF:T=speedtest.rrd:MY-UPLINK:AVERAGE" \
  "DEF:TMAX=speedtest.rrd:MY-UPLINK:MAX" \
  "AREA:TMAX#ffb6c1:Up max" \
  "LINE1:T#ff0000:Uplink" \
  "GPRINT:T:LAST:Last uplink\: %2.1lf Mbit/s" \
  "GPRINT:TMAX:MAX:Max uplink\: %2.1lf Mbit/s"

done

