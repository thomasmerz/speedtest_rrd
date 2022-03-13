# Purpose of this project
This project implement a nice speedtest-monitoring of your ISP and your home network in RRD databases and simple HTML pages with PNG graphs. With these information you know when your ISP (or your network/router/wifi/…) has its "highs" or "lows".  

![image](https://user-images.githubusercontent.com/18568381/158084777-b1d23058-012f-442b-91b6-186eb293fba4.png)
(Downlink speed Last month - higher is better)  

## There are the following scripts that are doing the following:

```
00_get_my_speedtest_status.sh
01_update_my_speedtest_rrd.sh
02_graph_speedtest_rrd.sh
98_create_my_speedtest_rrd.sh
```

## 00_get_my_speedtest_status.sh
This script is executed by 01_update_my_speedtest_rrd.sh - the one and only need or sense to run it manually might be if you want to speedtest without updating RRD database.

## 01_update_my_speedtest_rrd.sh
Run this script periodically (for example every 10 minutes) via crontab to update RRD database(s) for daily/weekly/monthly/yearly charts.

## 02_graph_speedtest_rrd.sh
Run this script periodically (for example hourly) via crontab to create PNG-chart(s) from results RRD database(s) for daily/weekly/monthly/yearly charts.


## 98_create_my_speedtest_rrd.sh
Run this script once to create rrd-database-file.

## Crontab
```
# this is my speedtest:
5,15,25,35,45,55 * * * * ~/dev/speedtest_rrd/01_update_my_speedtest_rrd.sh >/dev/null 2>&1
0                * * * * ~/dev/speedtest_rrt/02_graph_speedtest_rrd.sh >/dev/null 2>&1
```

## Examples
I've uploaded some real-world [examples](examples) from my home-network monitored via Wifi.

Have fun!

