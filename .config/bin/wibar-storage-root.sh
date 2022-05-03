#!/bin/bash
df -H --output='target,used,size,pcent' | awk '/^\/ / { print $2 + 0 "/" $3, "(" $4 ")" }'
