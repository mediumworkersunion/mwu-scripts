#!/bin/bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
BLUE="\033[34m"
PLAIN="\033[0m"

function cur_branch() {
  git branch --show-current
}

function main_branch() {
  echo "main"
}
function error() {
  echo -e "${RED}ERROR: ${PLAIN}${@}"
  exit 1
}
function warn() {
  echo -e "${YELLOW}WARN: ${PLAIN}${@}"
}
