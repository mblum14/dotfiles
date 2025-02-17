#!/usr/bin/env bash

function gitlab_api::curl() {
  local url=$1
  curl -s \
    -H "Authorization: Bearer ${GITLAB_TOKEN}" \
    "${url}"
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
