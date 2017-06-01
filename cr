#!/bin/sh

cmd="$*"

# Run command once immediately.
$cmd

exclude=${CR_EXCLUDE:-^\./\.git}
rate=${CR_RATE:-1}

last=$(date +%s)

inotifywait -mqr --exclude "$exclude" -e create -e delete -e modify -e move . |
  while read path action file
    do
      now=$(date +%s)
      echo "$action $path$file"

      # Throttling: wait $rate seconds between runs.
      delta=$((now - last))
      if [ $delta -lt $rate ]; then continue; fi
      last=$now

      # Background command in subshell to return control to the loop.
      (sleep $rate && $cmd) &
    done
