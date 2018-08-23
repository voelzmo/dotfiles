#!/bin/sh
set -e

if ! grep -q VISTYLE ./bash_profile; then
        echo 'export VISTYLE=dark' >> ./bash_profile
fi

sed -i '' -e 's/export VISTYLE=light/export VISTYLE=dark/g' ./bash_profile
