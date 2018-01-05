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

test_module()
{
  [[ -d "node_modules/$1" ]] && \
    green "==> $1 is available" || \
    terminate "==> $1 should be available"
}

npm_command()
{
  blue "# npm $*"
  npm $*> /dev/null 2>&1 && \
    echo "\`npm $*\` succeeded" || \
    terminate "\`npm $*\` failed"
}

rm -fr node_modules
blue "=== Testing with npm `npm --version` and node `node --version` ==="

npm_command install
test_module ember-one-way-controls
test_module lodash

npm_command prune
test_module ember-one-way-controls
test_module lodash

npm_command prune --no-shrinkwrap
test_module ember-one-way-controls
test_module lodash

