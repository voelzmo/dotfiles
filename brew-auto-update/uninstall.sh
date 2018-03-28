#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLIST_PATH=~/Library/LaunchAgents/com.cloudfoundry.bosheurope.brewautoupdate.plist
LOG_PATH=~/Library/Logs/com.cloudfoundry.bosheurope.brewautoupdate.log

if [ -f "$PLIST_PATH" ]; then
  if launchctl list | grep --quiet "com.cloudfoundry.bosheurope.brewautoupdate"; then
    echo "Unloading existing launch agent"
    launchctl unload "$PLIST_PATH"
  fi
  
  if [ -f "$PLIST_PATH" ]; then
    echo "Removing log file $LOG_PATH"
    rm "$LOG_PATH"
  fi

  echo "Removing launch agent $PLIST_PATH"
  rm "$PLIST_PATH" 
fi

echo ""
echo "Done"