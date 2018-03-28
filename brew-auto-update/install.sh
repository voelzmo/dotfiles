#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLIST_PATH=~/Library/LaunchAgents/com.cloudfoundry.bosheurope.brewautoupdate.plist
LOG_PATH=~/Library/Logs/com.cloudfoundry.bosheurope.brewautoupdate.log

if [ -f "$PLIST_PATH" ] && launchctl list | grep --quiet "com.cloudfoundry.bosheurope.brewautoupdate"; then
  echo "Unloading existing launch agent"
  launchctl unload "$PLIST_PATH"
fi

echo "Creating launch agent $PLIST_PATH"
cat > $PLIST_PATH <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.cloudfoundry.bosheurope.brewautoupdate</string>

  <key>ProgramArguments</key>
  <array>
    <string>${DIR}/brew-auto-update.sh</string>
  </array>

  <key>Nice</key>
  <integer>1</integer>

  <key>StartInterval</key>
  <integer>600</integer>

  <key>RunAtLoad</key>
  <true/>

  <key>StandardErrorPath</key>
  <string>${LOG_PATH}</string>

  <key>StandardOutPath</key>
  <string>${LOG_PATH}</string>
</dict>
</plist>
EOF

echo "Loading launch agent $PLIST_PATH"
launchctl load "$PLIST_PATH"

echo "Logs: $LOG_PATH"

echo ""
echo "Done"
