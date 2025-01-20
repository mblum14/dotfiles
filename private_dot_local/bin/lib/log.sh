#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/colors.sh"

function echo2 {
  echo >&2 -e "$*"
}

function log::debug() {
  if [[ ${DEBUG:-} =~ ^(true|on)$ ]]; then
    echo2 "[DEBUG] $*"
  fi
}

function log::err {
  echo2 "${c_red_b}[ERR]${c_clear}${c_red} ${*}${c_clear}"
}

function log::warn {
  echo2 "${c_yellow_b}[WARN]${c_clear}${c_yellow} ${*}${c_clear}"
}

function log::header {
  echo -e "\n${c_violet_b}---------- $* ----------${c_clear}"
}

function log::info {
  echo -e "${c_cyan}[INFO]${c_clear} $*${c_clear}"
}

function log::success {
  echo -e "${c_green_b}[Success]${c_clear} ${c_green}${*}${c_clear}"
}

function log::failure {
  echo -e "${c_red_b}[Failure]${c_clear} ${c_red}${*}${c_clear}"
}
