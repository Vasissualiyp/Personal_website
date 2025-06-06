#!/usr/bin/env bash
#WAIT_SEC=3600 # Updates every hour
WAIT_SEC=14400 # Updates every 4 hours
#WAIT_SEC=86400 # Updates every day

while true; do
    git pull origin master
	sleep $WAIT_SEC
done
