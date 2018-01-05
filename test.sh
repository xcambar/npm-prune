#!/usr/bin/env bash

red() {
  echo -e "\033[31m$1\033[0m"
}

green() {
  echo -e "\033[32m$1\033[0m"
}

blue() {
  echo -e "\033[34m$1\033[0m"
}

terminate() {
  red "$1"
  exit 1
}

export NVM_DIR=${NVM_DIR:-"$HOME/.nvm"}

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

command -v nvm > /dev/null || terminate "nvm is mandatory to run this script. See https://github.com/creationix/nvm"

CURRENT_VERSION=`nvm current`

node_versions="8.0 8.2 8.7 8.9"

exit_code=0

for version in $node_versions; do
  nvm install "$version"
  nvm use "$version"
  rm -f package-lock.json
  ./single-test.sh || exit_code=1
  echo
done

nvm use "$CURRENT_VERSION"

exit $exit_code
