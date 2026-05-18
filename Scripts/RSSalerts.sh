#!/bin/bash
# This script checks for new RSS feed items and sends alerts to a specified email address.
THRESHOLD=$1
PID=$2
# Check if the threshold and PID are provided
if [ -z "$THRESHOLD" ] || [ -z "$PID" ]; then
    echo "Usage: $0 <threshold> <pid>"
    exit 1
fi