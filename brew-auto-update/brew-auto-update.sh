#!/usr/bin/env bash
# Updates homebrew and upgrades all outdated formulae and casks. Run weekly by the launch agent
# created in install.sh. Any failing step aborts the script with a non-zero exit code.

set -euo pipefail

# launchd starts jobs with a minimal environment, so don't rely on the user's PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# apple silicon installs to /opt/homebrew, intel to /usr/local
if [ -x /opt/homebrew/bin/brew ]; then
  BREW=/opt/homebrew/bin/brew
elif [ -x /usr/local/bin/brew ]; then
  BREW=/usr/local/bin/brew
else
  echo "$(date): ERROR: could not find brew in /opt/homebrew/bin or /usr/local/bin" >&2
  exit 1
fi

run() {
  echo ""
  echo "$(date): RUNNING: brew $*"
  "$BREW" "$@"
  echo "$(date): FINISHED: brew $*"
}

run update
run upgrade
run cleanup

echo ""
echo "$(date): All done! Enjoy a cold one! 🍺"
