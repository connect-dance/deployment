#!/usr/bin/env fish

# Parse the JSON file using jq
for pair in (jq -r '. | to_entries | .[] | @uri "\(.key) \(.value)"' secrets.env.json)
    set -x $(string split " " $pair)
end
