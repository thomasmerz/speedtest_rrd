#!/bin/bash

cd ~/dev/speedtest_rrd || exit 1

# https://jyge.fi/2015/08/13/howto-speedtest-cli-with-rrd/

MYRRD="speedtest.rrd"

rrdtool create "$MYRRD" \
--start now-3y \
DS:MY-PING:GAUGE:7200:0:6000 \
DS:MY-DOWNLINK:GAUGE:7200:0:3000 \
DS:MY-UPLINK:GAUGE:7200:0:3000 \
RRA:MIN:0.5:60:8785 \
RRA:MAX:0.5:60:8785 \
RRA:AVERAGE:0.5:1:8785

