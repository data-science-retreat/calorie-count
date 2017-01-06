#!/usr/bin/env bash


cleanup() {
    # Kill the background processes
    kill $GPU_JOB
    kill $CPU_JOB
}

trap cleanup SIGHUP SIGINT SIGTERM

SBT_EXPR=$1
REGEX="time: ([0-9]+) s, completed"




# Start recording in background
SCRIPTS_PATH=$( cd "$(dirname "$0")" ; pwd -P )
"${SCRIPTS_PATH}/record_nvidia_usage.sh" 1 gpu &
GPU_JOB=$!
"${SCRIPTS_PATH}/record_cpu_usage.sh" 1 cpu &
CPU_JOB=$!

# Change the IFS temporarily to split only on newlines:
# http://unix.stackexchange.com/questions/39473/command-substitution-splitting-on-newline-but-not-space
IFS=$'\n'
for line in $(sbt "${SBT_EXPR}");
do
    echo $line # Don't silence sbt

    # =~ is the bash regex match operator:
    if [[ $line =~ $REGEX ]]
    then
	TIME="${BASH_REMATCH[1]}"
	SUM_USAGE_GPU=$(tail -n $TIME gpu | paste -s -d+ | bc)
	SUM_USAGE_CPU=$(tail -n $TIME cpu | paste -s -d+ | bc)	
	AVG_USAGE_GPU=$(expr $SUM_USAGE_GPU / $TIME)
	AVG_USAGE_CPU=$(expr $SUM_USAGE_CPU / $TIME)
	echo "This run took $TIME seconds with an average GPU % utilization of $AVG_USAGE_GPU and CPU % $AVG_USAGE_CPU"
    fi
done

cleanup
