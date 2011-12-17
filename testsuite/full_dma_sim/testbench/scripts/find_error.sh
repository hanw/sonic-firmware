#!/bin/bash
# This is the main script that tries to find errors in simulation output.
# script name: find_errneous_signals.sh
# Author: Han Wang

echo "Find errneous signals..."

if (($# < 1))
then
	echo "Usage: find_error.sh [file name]"
else
	#make sure all signal names are in one line
	echo "clean $1"
	#awk -f clean_header.awk -v OUTPUT="log.out" $1
	#Get the fisrt 5 lines from modelsim lst file, which contains the signal name
	awk -f sort.awk -v n=5 -v temp="name.out" $1

	#sort the signal name, so that it matches to the recorded data
	sort +2 -3 -n name.out > sorted.out

	#put all signal names in one line in merged.out
	awk -f merge.awk sorted.out
	
	#put all signal data into sorted.out
	awk -f copy_file.awk -v n=5 -v OUTPUT="merged.out" $1

	#find out which signals are not initialized properly
	awk -f find_xxx.awk -v RESULT="log.result" merged.out

	#generate .do files for simulation
	awk -f write_do.awk -v OUTPUT="wave.do" log.result
	exit
fi
