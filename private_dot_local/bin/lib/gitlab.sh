#!/usr/bin/env bash
source "${BASH_SOURCE%/*}/log.sh"

function gitlab_api::setup() {
  export GITLAB_URL="${GITLAB_URL:-https://gitlab.com}"

  if [[ -z ${GITLAB_TOKEN:-} && -f ${HOME}/.gitlab_access_token ]]; then
    GITLAB_TOKEN="$(<"${HOME}/.gitlab_access_token")"
    export GITLAB_TOKEN
  fi

  if [[ -z ${GITLAB_TOKEN:-} ]]; then
    log::err "GITLAB_TOKEN is not set and ~/.gitlab_access_token was not found"
    return 1
  fi
}

function gitlab_api::urlencode() {
  jq -nr --arg value "${1}" '$value|@uri'
}

function gitlab_api::curl() {
  local url=$1
  shift
  gitlab_api::setup || return 1
  curl \
    -fsSL \
    -H "Authorization: Bearer ${GITLAB_TOKEN}" \
    "${url}"
}

function gitlab_api::put() {
  local url=$1
  local data=$2
  gitlab_api::setup || return 1
  response="$(curl \
    -s \
    -w ",,,%{http_code}" \
    -H "Authorization: Bearer ${GITLAB_TOKEN}" \
    -H "Content-Type: application/json" \
    --request PUT "${url}" \
    --data "${data}")"
  code="$(echo "${response}" | awk -F',,,' '{print $2}')"
  err="$(echo "${response}" | awk -F',,,' '{print $1}')"

  if [[ $code -ne 200 ]]; then
    log::err "${err}"
    return 1
  fi
}

function gitlab_api::page() {
  local url=$1
  local attr=$2
  local page=${3:-1}
  existing_query="$(echo "${url}" | awk -F'?' '{print $2}')"
  local per_page=100
  local query="per_page=${per_page}&order_by=name&sort=asc"
  if [[ -n $existing_query ]]; then
    query="${existing_query}&${query}"
    url="$(echo "${url}" | awk -F'?' '{print $1}')"
  fi

  this_page="$(gitlab_api::curl "${url}?${query}&page=${page}" | jq --arg a "${attr}" -r '.[].[$a]')"
  count="$(echo "${this_page}" | wc -l)"
  if [[ ${count} -eq ${per_page} ]]; then
    next_page="$(gitlab_api::page "${url}" "${attr}" $((page + 1)))"
    echo -e "${this_page}\n${next_page}"
  else
    echo "${this_page}"
  fi
}
