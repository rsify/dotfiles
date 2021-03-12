#!/usr/bin/env python3

# this is meant to be refreshed manually by the api (see .config/yabai/yabairc)
# (https://github.com/matryer/xbar/blob/cdfab602362617b4991f6bac1176950c4cf3a7b4/README.md#xbar-control-api)

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

    window_str = ", ".join(map(lambda w: w["app"], space_windows))

    index_str = str(index + 1) + "/"

    return " " + index_str + ("[" if focused else "") + window_str + ("] " if focused else " ")

    # return ("[" if focused else " ") + str(space["index"]) + ("]" if focused else "᾽")

res = "".join(
    map(lambda ix: space_format(ix[0], ix[1], windows), enumerate(spaces))
)

print(res + "| font=\"Menlo\" trim=false")
