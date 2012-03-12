#!/bin/bash
# uses bash because rvm requires bash or zsh

set -e

# The '$BASH' var is set to the program bash is running as.
# this will be /bin/sh if it is invoked that way.
if [ $(basename "$BASH") != "bash" ] ; then
  echo "Bash not detected, rerunning self through bash."
  exec bash "$0" "$@"
fi

rvmloader="$HOME/.rvm/scripts/rvm"
if [ ! -f $rvmloader ] ; then
  echo "rvm missing, please install? Checked path '$rvmloader'"
  exit 1
fi

. $rvmloader
. $(dirname $0)/test.subr

# Prep
(cd fixtures; sh fpm.sh)

check fpm 1.8.7 1.7.2

