#!/usr/bin/env python3

import subprocess
import json

# spaces = json.loads(os.system("/usr/local/bin/yabai -m query --spaces"))
spaces = json.loads(
    subprocess.run(["/usr/local/bin/yabai", "-m", "query", "--spaces"], capture_output=True).stdout
)

def space_format(space):
    focused = space["focused"]
    return ("[" if focused else " ") + str(space["index"]) + ("]" if focused else "᾽")

res = "".join(
    map(lambda x: space_format(x), spaces)
)

print(res + "| font=\"Menlo\" trim=false")
