#!/bin/bash

sudo systemctl restart php82-fpm
sudo systemctl restart nginx

endpoints3=("http://alebedev.devhands.cloud/index.php?cpu=0.000001" "http://alebedev.devhands.cloud/index.php?cpu=0.000002" "http://alebedev.devhands.cloud/index.php?cpu=0.000004" "http://alebedev.devhands.cloud/index.php?cpu=0.000006" "http://alebedev.devhands.cloud/index.php?cpu=0.000008" "http://alebedev.devhands.cloud/index.php?cpu=0.00001" "http://alebedev.devhands.cloud/index.php?cpu=0.000012")

# Iterate through endpoints
for endpoint in "${endpoints3[@]}"; do
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
