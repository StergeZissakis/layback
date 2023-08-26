#!/bin/bash

echo "Cleaning up chrome leftovers..."
killall -r "chrom.*"
killall python
killall python3
killall chrome
killall chromium
