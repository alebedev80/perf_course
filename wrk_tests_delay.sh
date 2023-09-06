#!/bin/bash

endpoints2=("http://alebedev.devhands.cloud/index.php" "http://alebedev.devhands.cloud/index.php?delay=500" "http://alebedev.devhands.cloud/index.php?delay=1000" "http://alebedev.devhands.cloud/index.php?delay=2000" "http://alebedev.devhands.cloud/index.php?delay=4000" "http://alebedev.devhands.cloud/index.php?delay=6000" "http://alebedev.devhands.cloud/index.php?delay=8000" "http://alebedev.devhands.cloud/index.php?delay=10000" "http://alebedev.devhands.cloud/index.php?delay=12000")

# Iterate through endpoints
for endpoint in "${endpoints2[@]}"; do
    # Iterate through max_rates
    for max_rate in {1000..17000..1000}; do
        echo "Testing endpoint: $endpoint at rate: $max_rate"

        # Get the request start time
        request_start_time=$(date +"%Y-%m-%d %H:%M:%S")

        # Execute wrk command
        wrk_output=$(wrk -R$max_rate -t4 -c100 -d60s "$endpoint")

        # Extract real rate and average latency from wrk output
        real_rate=$(echo "$wrk_output" | grep "Requests/sec" | awk '{print $2}')
        avg_latency=$(echo "$wrk_output" | grep "Latency" | awk '{print $2}')

        # Count HTTP response codes
        count_200=$(echo "$wrk_output" | grep -o "HTTP/1.1 200 OK" | wc -l)
        count_non_200=$((max_rate - count_200))

        # Store results in CSV format
        echo "$request_start_time, $endpoint, $max_rate, $real_rate, $avg_latency, $count_200, $count_non_200" >> results.csv

        # Pause for 60 seconds
        sleep 60
    done
    sleep 120
done

