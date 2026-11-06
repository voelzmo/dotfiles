#!/usr/bin/env bash
# Installs a launch agent that runs brew-auto-update.sh every monday at 10:00.
# If the mac is asleep at that time, launchd runs the job when it wakes up.

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LABEL=com.voelzmo.brewautoupdate
PLIST_PATH=~/Library/LaunchAgents/${LABEL}.plist
LOG_PATH=~/Library/Logs/${LABEL}.log
DOMAIN="gui/$(id -u)"

# the agent was called like this before, remove it so there are not two of them
OLD_LABEL=com.cloudfoundry.bosheurope.brewautoupdate
OLD_PLIST_PATH=~/Library/LaunchAgents/${OLD_LABEL}.plist

if [ -f "$OLD_PLIST_PATH" ]; then
  echo "Removing old launch agent $OLD_PLIST_PATH"
  launchctl bootout "${DOMAIN}/${OLD_LABEL}" 2>/dev/null || true
  rm "$OLD_PLIST_PATH"
fi

if [ -f "$PLIST_PATH" ]; then
  echo "Unloading existing launch agent"
  launchctl bootout "${DOMAIN}/${LABEL}" 2>/dev/null || true
fi

mkdir -p "$(dirname "$PLIST_PATH")" "$(dirname "$LOG_PATH")"
echo "Creating launch agent $PLIST_PATH"
cat > "$PLIST_PATH" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>${LABEL}</string>

  <key>ProgramArguments</key>
  <array>
    <string>${DIR}/brew-auto-update.sh</string>
  </array>

  <key>Nice</key>
  <integer>1</integer>

  <!-- every monday at 10:00 -->
  <key>StartCalendarInterval</key>
  <dict>
    <key>Weekday</key>
    <integer>1</integer>
    <key>Hour</key>
    <integer>10</integer>
    <key>Minute</key>
    <integer>0</integer>
  </dict>

  <key>StandardErrorPath</key>
  <string>${LOG_PATH}</string>

  <key>StandardOutPath</key>
  <string>${LOG_PATH}</string>
</dict>
</plist>
EOF

plutil -lint "$PLIST_PATH"

echo "Loading launch agent $PLIST_PATH"
launchctl bootstrap "$DOMAIN" "$PLIST_PATH"

echo "Logs: $LOG_PATH"

echo ""
echo "Done"
