#!/bin/bash

echo "Monthly totals from October 2021 through September 2022"

for MONTH in 10 11 12 01 02 03 04 05 06 07 08 09
do
        NUM_DAYS=30
        YEAR=2022

        # If from last year, change the year
        if [ $MONTH = '10' ] || [ $MONTH = '11' ] || [ $MONTH = '12' ]
        then
                YEAR=2021
        fi

        # Months with 31 days: January, March, May, July, August, October, and December.
        if [ $MONTH = '01' ] || [ $MONTH = '03' ] || [ $MONTH = '05' ] || [ $MONTH = '07' ] || [ $MONTH = '08' ] || [ $MONTH = '10' ] || [ $MONTH = '12' ]
        then
                NUM_DAYS=31
        fi

        # Months with 28 days: February.
        if [ $MONTH = '02' ]
        then
                NUM_DAYS=28
        fi

        echo $YEAR $MONTH $NUM_DAYS

        vault read -format=json \
                sys/internal/counters/activity \
                start_time="$YEAR-$MONTH-01T00:00:00Z" \
                end_time="$YEAR-$MONTH-${NUM_DAYS}T23:59:59Z"

done

echo "Last 12-month total"

vault read -format=json \
        sys/internal/counters/activity \
        start_time="2021-10-01T00:00:00Z" \
        end_time="2022-09-30T23:59:59Z"

echo "Completed client counting"
