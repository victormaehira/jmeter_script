#!/bin/bash

echo "Testing..."

echo TARGET_URL=$TARGET_URL
echo TARGET_PORT=$TARGET_PORT
echo LOOPS=$LOOPS
echo NUM_THREADS=$NUM_THREADS
echo RAMP_TIME=$RAMP_TIME

cd $JMETER_HOME/bin
jmeter -n -t liveness2d.jmx -l results.jtl

cat results.jtl

tail -f /etc/hosts
          