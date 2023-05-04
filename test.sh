#!/bin/bash
echo "---------------Test Started---------------"
input=$1
output=$(/bin/bash $input)
if [ "$output" == "dos13" ]
    then
        echo "Test Passed"
        echo "---------------Test Finished---------------"
        exit 0
else
    echo "Test Failed"
    exit 1
    echo "---------------Test Finished---------------"
fi
