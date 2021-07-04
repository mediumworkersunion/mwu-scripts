#!/bin/bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
BLUE="\033[34m"
PLAIN="\033[0m"

function cur_branch() {
  git branch --show-current
}

function is_git_tree() {
  [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]] || fatal "Must be run inside a git work tree"
}

function have_gh {
  command -v gh >/dev/null || fatal "gh cli is required"
}

function get_gh_username() {
  gh api user --cache 168h -q '.login'
}

function main_branch() {
  is_git_tree
  #attempt to get default branch from git config
  stored_branch="$(git config --get mwu.defaultbranch)"
  if [[ ! $? || $stored_branch == "" ]]; then
    stored_branch=$(get_default_branch)
    git config mwu.defaultbranch "${stored_branch}"
  fi
  echo "${stored_branch}"
}

function get_default_branch() {
  # make sure we're inside a git repo and have the gh cli
  is_git_tree
  command -v gh >/dev/null || fatal "gh cli is required"
  gh repo view --json 'defaultBranchRef' --template '{{.defaultBranchRef.name}}'
}
  
function fatal() {
  echo -e "⛔️ ${@}" 2>&1
  exit 1
}
function error() {
  echo -e "⛔️ ${@}" 2>&1
}
function warn() {
  echo -e "⚠️  ${@}" 2>&1
}
function info() {
  echo -e "${GREEN}▶︎${PLAIN} ${@}" 
}
