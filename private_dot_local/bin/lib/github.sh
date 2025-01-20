#!/usr/bin/env bash

function github_api::curl() {
  local url=$1
  curl -s \
    -H 'Accept:application/vnd.github+json' \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    "${url}"
}

function github_api::page() {
  local url=$1
  local page=${2:-1}
  local query="per_page=100&sort=full_name&direction=asc"

  this_page="$(github_api::curl "${url}?${query}&page=${page}" | jq -r ".[].full_name")"
  if [[ -n ${this_page} ]]; then
    next_page="$(github_api::page "${url}" "$((page + 1))")"
    echo -e "${this_page}\n${next_page}"
  else
    echo "${this_page}"
  fi
}
