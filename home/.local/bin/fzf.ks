#!/usr/bin/env bash
# [K]ill [S]erver

pid=$(lsof -Pwni tcp | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header ='[kill:tcp]'" | awk '{print $2}')

if [[ "x$pid" != "x" ]]; then
	echo $pid | xargs kill -${1:-9}
	fzf.ks
fi
