#!/bin/bash
# This script checks for new RSS feed items and sends alerts to a specified email address.
THRESHOLD=$1
PID=$2
LOGFILE=/var/log/rss_alerts.log
while true; do
    RSS=$(grep VmRSS /proc/$PID/status | awk '{print $2}')
    if [ "$RSS" -gt "$THRESHOLD" ]; then
        echo "Memory usage exceeded threshold: $RSS KB" >> "$LOGFILE"
        echo "Memory usage exceeded threshold: $RSS KB" | mail -s "RSS Alert" "$ALERT_EMAIL"
    fi
    sleep 3 # Wait for 3 Sec before checking again
done