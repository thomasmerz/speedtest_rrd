# Speedtest Monitoring
This project implement a nice speedtest-monitoring of your ISP and your home network in RRD databases and simple HTML pages with PNG graphs. With these information you know when your ISP (or your network/router/wifi/…) has its "highs" or "lows".  

![image](https://user-images.githubusercontent.com/18568381/158084777-b1d23058-012f-442b-91b6-186eb293fba4.png)
(Downlink speed Last month - higher is better)  

## Requirements
🚧 You have to install `speedtest` from your linux-distro (or somewhere else from [GitHub](https://github.com/search?q=speedtest)).  
🚧 You may need to update [speedtest-executable](00_get_my_speedtest_status.sh#L28) in `00_get_my_speedtest_status.sh`.

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

## Alternatives
If you like docker you could do this also with [Speedtest-Tracker](https://github.com/henrywhitaker3/Speedtest-Tracker).

Which gives you this for example:

<img width="1143" alt="image" src="https://user-images.githubusercontent.com/18568381/158085639-e0c26c0b-fc99-4f3e-89b2-faa955fbce7c.png">

Have fun!

