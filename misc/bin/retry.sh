#!/bin/bash

FLAKY_COMMAND="$@"

# Retry logic
while true; do
    echo "Attempting flaky command..."

    timeout 10s $FLAKY_COMMAND

    # Check the exit status
    if [ $? -eq 0 ]; then
        echo "Successful!"
        break
    else
        echo "Failed. Retrying in 10 seconds..."
        sleep 10
    fi
done
