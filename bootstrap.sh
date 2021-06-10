#!/bin/bash
# determine script dir and whether sourced or run, sanity checks
base_dir="$( cd "$( dirname $(readlink "${BASH_SOURCE[0]}") 2>/dev/null )" &> /dev/null && pwd )"

# check if we found the right dir (this will fail if you use zsh and source the symlink)
if ! [ -x "${base_dir}/bootstrap.sh" -a -d "${base_dir}/scripts" -a -d "${base_dir}/bootstrap.d" ]; then
  echo "FATAL: Could not find all required files. Ask for help"
  #return if we're sourced, exit if not
  return 1 2>/dev/null || exit 1
fi

# Main bootstrap
[[ $0 != "${BASH_SOURCE[0]}" ]] && sourced=true || sourced=false

if [ "$sourced" = "true" ]; then
  # don't output anything because we're being sourced. Just add the scripts to $PATH
  # TODO(dnelson): implement env.d
  path_snippet="${base_dir}/scripts"
  [[ $PATH == *$path_snippet* ]] || export PATH="${PATH}:${path_snippet}"
else
  # we're bootstrapping directly... it's ok to be chatty
  echo 'Welcome to MWU Bootstrap:'

  # Source all bootstrap scripts in alphabetical order
  for file in "${base_dir}/bootstrap.d/"*; do
    echo "Running ${file##*/}..."
    source "$file"
  done
fi
