#!/usr/bin/env bash

# How many seconds to wait
INTERVAL=$1
OUTPUT_FILE=$2

if [ -f $OUTPUT_FILE ]
then
   rm $OUTPUT_FILE
fi

while true
do
    # Need to get the second frame from `top`
    IDLE=$(top -b -n 2 -d 0,1 | grep '^%Cpu(s)' | cut -c 37-38 | tail -n 1)
    bc <<< "100 - $IDLE" >> "$OUTPUT_FILE"
    TIME_TO_SLEEP=$(bc <<< "$INTERVAL - 0.1")
    sleep $TIME_TO_SLEEP
done

