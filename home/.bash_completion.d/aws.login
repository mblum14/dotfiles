#!/usr/bin/env bash

PROFILES="$(cat ~/.aws/config | grep -oP '(?<=profile )[^] ]*')"

function _profile_completion() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=($(compgen -W "${PROFILES}" -- "$word"))
}

complete -F _profile_completion aws.login
