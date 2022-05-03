#!/bin/bash
free -h --si | awk '/^Mem:/ { print $3 + 0 "/" $2 }'
