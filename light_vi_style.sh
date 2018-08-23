#!/bin/sh
set -e

sed -i '' -e 's/export VISTYLE=dark/export VISTYLE=light/g' ./bash_profile
