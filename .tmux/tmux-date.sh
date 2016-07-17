#!/bin/bash

# adapted from https://gist.github.com/bryanburgers/55b05686b7fc4ee3c3f6

# Format the current date in a way that clearly shows local time and UTC time,
# for use in a tmux status bar.

# Examples:
# tmux-date  (with computer set to America/Chicago timezone)
#   2016-01-11 / 08:55 -06:00 / 14:55Z
# TZ="Australia/Victoria" tmux-date
#   2016-01-12 / 01:55 +11:00 / 2016-01-11T14:55Z

localdate=$(gdate +"%d %b %Y")
localtime=$(gdate +"%H:%M")
localoffset=$(gdate +"%:z")
utcdate=$(gdate +"%d %b %Y" --utc)
utctime=$(gdate +"%H:%MZ" --utc)

# If the date in the UTC timezone is the same as it is in the current timezone,
# then displaying the UTC date is just adding clutter. However, if the dates
# differ, then display the date. Having the date displayed will call attention
# to itself that the UTC date and the local date are currently different.
if [[ $utcdate == $localdate ]]; then
  utcdatedisplay=""
else
  utcdatedisplay="${utcdate}T"
fi

echo "$localtime $localoffset  ${utcdatedisplay}${utctime}"
