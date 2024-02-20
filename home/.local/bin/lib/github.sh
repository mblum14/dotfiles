#!/usr/bin/env bash

export GITHUB_BASE_URL="https://git.opensource.gov/api/v3"

function __hub_curl() {
	local url=$1
	curl -s \
		-H 'Accept:application/vnd.github+json' \
		-H "Authorization: Bearer ${GITHUB_TOKEN}" \
		"${url}"
}
