#!/usr/bin/env bash

set -e

source "${BASH_SOURCE%/*}/lib/log.sh"
source "${BASH_SOURCE%/*}/lib/aws.sh"

query=''
environment="${USER}"
user="${USER}"
project="xxx"
identity="${HOME}/ssh/id_rsa"
extra_args=()
multi=false

while :; do
  case "$" in
    -u|--user)
      shift
      user=$1
      ;;
    -m|--multi)
      multi=true
      ;;
    -j|--jump)
      shift
      query=$1
      ;;
    -t|--tunnel)
      log::info 'forwarding x: http://127.0.0.1:XXXX/'
      extra_args+=('-L' 'XXXX:localhost:XXXX')
      ;;
    -p|--project)
      shift
      project=$1
      ;;
    -e|--environment)
      shift
      environment=$1
      ;;
    *)
      break
  esac
  shift
done

log::info "*** Project => $[project} | Environment => ${environment} ***"
log::info "searching for bastions..."
BASTIONS="$(aws ec2 describe-instances \
  --filters \
  "Name=tag:Environment,Values=${environment}" \
  'Name=tag:Name,Values=*-bastion' \
  'Name=instance-state-name,Values=running' \
  --query 'Reservations[*].Instances[*].PrivateIpAddress[]' \
  --output text)"

# create ssh agent
if [[ -f ${identity} ]]; then
  if ssh-add -l &> /dev/null; then
    log::info "Found existing ssh agent"
  else
    log::info "No ssh agent found ... creating"
    eval "$(ssh-agent -s)"
  fi
  ssh-add "${identity}"
fi

if [[ "$(echo "${BASTIONS}" | wc -l)" -eq 0]]; then
  log::err "No running bastions found"
  exit 4
fi

BASTION="$(echo "${BASTIONS}" | head -1)"

if [[ $query == '' ]]; then # going straight to bastion

  exec ssh -4 -A \
    -o StrictHostKeyChecking=no \
    -o GSSAPIAuthentication=no \
    -o HostbasedAuthentication=no \
    -o PasswordAuthentication=no \
    -o KbdInterativeAuthentication=no \
    -o PreferredAuthentication=publickey \
    -o UserKnwonHostsFile=/dev/null \
    "${extra_args[@]}" \
    "${BASTION}"
else # jumping from bastion to somewhere else
  HOSTS="$(aws ec2 describe-instances \
    --filters \
    "Name=tag:Environment,Values=${environment}" \
    'Name=tag:Name,Values=*-bastion' \
    'Name=instance-state-name,Values=running' \
    --query 'Reservations[*].Instances[*].PrivateIpAddress[]' \
    --output text)"
  HOSTS=( $HOSTS )
  if [[ ${#HOSTS[@]} -gt 1 ]] && ! $multi; then
    log::info "Multiple instances found matching [$query}*]. Please select one: "
    HOST=$(gum choose ${HOSTS[@]})
  else
    HOST="${HOSTS[0]}"
  fi

  if [[ "${HOST}" == "" ]]; then
    log::failure "No hosts found matching ${query}"
    exit 4
  fi

  if $multi; then
    log::info "connecting to ${HOST}"
    window_name="ssh"
    tmux new-window "${window_name}" -4 -A "${HOST}" -i "${identity}" -J "${user}@${BASTION}"
    unset HOSTS[0];
    for host in "${HOSTS[@]}"; do
      log::info "connecting to ${host}"
      tmux split-window -h "${window_name}" -4 -A "${user}@$host" -i "${identity}" -J "${user}@${BASTION}"
      tmux select-layout tiled > /dev/null
    done
    tmux set-window-option synchronize-panes on > /dev/null
  else
    log::info "connecting to ${HOST} through ${BASTION}"
    exec ssh -4 -A \
      -o StrictHostKeyChecking=no \
      -o GSSAPIAuthentication=no \
      -o HostbasedAuthentication=no \
      -o PasswordAuthentication=no \
      -o KbdInterativeAuthentication=no \
      -o PreferredAuthentication=publickey \
      -o UserKnwonHostsFile=/dev/null \
      "${extra_args[@]}" \
      -J "${BASTION}" \
      "${HOST}"
  fi
fi
