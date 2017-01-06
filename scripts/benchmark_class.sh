#!/usr/bin/env bash

SBT_EXPR=$1
REGEX="time: ([0-9]+) s, completed"

# Start recording in background
SCRIPTS_PATH=$( cd "$(dirname "$0")" ; pwd -P )
sh "${SCRIPTS_PATH}/record_nvidia_usage.sh" 1 out &

# Change the IFS temporarily to split only on newlines:
# http://unix.stackexchange.com/questions/39473/command-substitution-splitting-on-newline-but-not-space
IFS=$'\n'
for line in $(sbt "${SBT_EXPR}");
do
    echo $line # Don't silence sbt

    # =~ is the bash regex match operator:
    if [[ $line =~ $REGEX ]]
    then
	echo matched
	echo $line
	TIME="${BASH_REMATCH[1]}"
	echo $TIME
	SUM_USAGE=$(tail -n $TIME out | paste -s -d+ | bc)
	AVG_USAGE=$(expr $SUM_USAGE / $TIME)
	echo "This run took $TIME seconds with an average GPU % utilization of $AVG_USAGE"
    fi
done

# Kill the background process
kill %1
