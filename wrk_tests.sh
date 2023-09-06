#!/bin/bash

# Create the CSV file and add headers
#echo "Endpoint, Max Rate, Real Rate, Avg Latency, Count 200, Count Non-200" > results.csv

#/bin/bash ./wrk_tests_static.sh
#sleep 300
#/bin/bash ./wrk_tests_delay.sh
#sleep 300
/bin/bash ./wrk_tests_cpu.sh


echo "Testing completed and results stored in results.csv"
