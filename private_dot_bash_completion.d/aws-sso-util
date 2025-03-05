#!/usr/bin/env bash

#_aws_sso_util_completion() {
#  local IFS=$'\n'
#  local response
#
#  response=$(env COMP_WORDS="${COMP_WORDS[*]}" COMP_CWORD=$COMP_CWORD _AWS_SSO_UTIL_COMPLETE=bash_complete $1)
#
#  for completion in $response; do
#    IFS=',' read type value <<<"$completion"
#
#    if [[ $type == 'dir' ]]; then
#      COMPREPLY=()
#      compopt -o dirnames
#    elif [[ $type == 'file' ]]; then
#      COMPREPLY=()
#      compopt -o default
#    elif [[ $type == 'plain' ]]; then
#      COMPREPLY+=($value)
#    fi
#  done
#
#  return 0
#}
#
#_aws_sso_util_completion_setup() {
# FIXME: sort out the "nosort" issue
#  complete -o nosort -F _aws_sso_util_completion aws-sso-util
#}
#
#_aws_sso_util_completion_setup
