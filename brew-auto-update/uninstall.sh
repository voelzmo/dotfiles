#!/usr/bin/env bash

set -euo pipefail

DOMAIN="gui/$(id -u)"

# remove the current agent and the one it was called before
for LABEL in com.voelzmo.brewautoupdate com.cloudfoundry.bosheurope.brewautoupdate; do
  PLIST_PATH=~/Library/LaunchAgents/${LABEL}.plist
  LOG_PATH=~/Library/Logs/${LABEL}.log

  if [ -f "$PLIST_PATH" ]; then
    echo "Unloading launch agent $LABEL"
    launchctl bootout "${DOMAIN}/${LABEL}" 2>/dev/null || true

    echo "Removing launch agent $PLIST_PATH"
    rm "$PLIST_PATH"
  fi

  if [ -f "$LOG_PATH" ]; then
    echo "Removing log file $LOG_PATH"
    rm "$LOG_PATH"
  fi
done

echo ""
echo "Done"
