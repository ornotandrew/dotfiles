#!/bin/bash
# This script iterates through all open sessions and resets the working-dir.  I
# use this mainly because tmux-resurrect tends to set the cd to the cwd of the
# first shell when restoring. I prefer the cwd to remain ~.
DESIRED_CWD="~"

SESSIONS=$(tmux list-sessions | sed 's/:.*//')

for SESSION in $SESSIONS; do
    tmux attach -c $DESIRED_CWD -t "=${SESSION}" 2> /dev/null &
done

tmux display-message -d 2000 "  ✓ Reset all session working dirs to $DESIRED_CWD"
