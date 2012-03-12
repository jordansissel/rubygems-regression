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

use() {
  rubyver=$1
  gemver=$2

  rvm use $rubyver
  rvm gemset create $(gemset)
  rvm gemset use $(gemset)
  rvm --force gemset empty $(gemset)
  rvm install rubygems $gemver
}

gemset() {
  echo "temp-$$"
}

build() {
  gemspec=$1
  gem build $gemspec
}

clean() {
  rvm --force gemset delete $(gemset)
}


(cd fixtures; sh fpm.sh)

use 1.9.3 1.8.17
build fixtures/fpm/fpm.gemspec
clean

# Ubuntu 11.10
use 1.8.7 1.7.2
#rvm install rubygems 1.7.2
#
# Try installing it
#gem install --ignore-dependencies fpm.gemspec

# Test it
#ruby -rubygems -e 'gem "fpm"' 
#result=$?
#rvm --force gemset delete $gemset

# Make sure it installed.
#if [ $? -ne 0 ] ; then
  #echo "FAILED"
#else
  #echo "OK"
#fi


