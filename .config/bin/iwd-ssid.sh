#!/bin/bash
set -euo pipefail

iwctl station "$@" show | grep 'Connected network' | cut -c 33- | sed 's/ *$//'
