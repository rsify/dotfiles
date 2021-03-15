#!/usr/bin/env python3

# this is meant to be refreshed manually by the api (see .config/yabai/yabairc)
# (https://github.com/matryer/xbar/blob/cdfab602362617b4991f6bac1176950c4cf3a7b4/README.md#xbar-control-api)

from collections import Counter
import subprocess
import json

spaces = json.loads(
    subprocess.run(["/usr/local/bin/yabai", "-m", "query", "--spaces"], capture_output=True).stdout
)

windows = json.loads(
    subprocess.run(["/usr/local/bin/yabai", "-m", "query", "--windows"], capture_output=True).stdout
)

def space_format(index, space, windows):
    focused = space["focused"]

    space_windows = [window for window in windows if window["space"] == space["index"]]

    apps = list(map(lambda w: w["app"], space_windows))

    # create a list with frequencies
    freqs = zip(Counter(apps.copy()).values(), Counter(apps.copy()).keys())

    freq_mapped = map(lambda freq: freq[1] + ((" x" + str(freq[0])) if freq[0] > 1 else ""), freqs)

    window_str = ", ".join(freq_mapped)

    index_str = str(index + 1) + "/"

    return " " + index_str + ("[" if focused else "") + window_str + ("] " if focused else " ")

    # return ("[" if focused else " ") + str(space["index"]) + ("]" if focused else "᾽")

res = "".join(
    map(lambda ix: space_format(ix[0], ix[1], windows), enumerate(spaces))
)

print(res + "| font=\"Menlo\" trim=false")
