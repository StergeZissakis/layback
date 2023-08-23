#!/bin/bash

echo "Cleaning up chrome leftovers..."
killall -r "chrom.*"
killall python
killall chrome
killall chromium
