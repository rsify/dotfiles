#!/bin/bash
set -euo pipefail

iwctl station wlan0 show | grep 'Connected network' | cut -c 33- | sed 's/ *$//'
