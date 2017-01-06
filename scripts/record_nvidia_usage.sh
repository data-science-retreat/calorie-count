#!/usr/bin/env/ bash

# How many seconds to wait
INTERVAL=$1
OUTPUT_FILE=$2

if [ -f $OUTPUT_FILE ]
then
   rm $OUTPUT_FILE
fi

while true
do
    nvidia-smi | grep % | cut -c 62-63 >> $OUTPUT_FILE
    sleep $INTERVAL
done

