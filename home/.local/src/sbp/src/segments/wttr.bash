#!/usr/bin/env bash

location=${SEGMENTS_WTTR_LOCATION:-'Oslo'}
format=${SEGMENTS_WTTR_FORMAT:-'%p;%t;%w'}
refresh_rate="${SEGMENTS_WTTR_REFRESH_RATE:-600}"

segments::wttr_fetch_changes() {
  curl \
    -H "Accept-Language: ${LANG%_*}" \
    --compressed "wttr.in/${location}?format=${format}" | tr -d '\n' | tr ';' '\n'
}

segments::wttr_refresh() {
  if [[ ! -f $SEGMENT_CACHE ]]; then
    debug::log "No cache folder"
  fi

  if [[ -f $SEGMENT_CACHE ]]; then
    if [[ $OSTYPE =~ darwin || $(uname) == Darwin ]]; then
      last_update=$(stat -f "%m" "$SEGMENT_CACHE")
    else
      last_update=$(stat -c "%Y" "$SEGMENT_CACHE")
    fi
  else
    last_update=0
  fi

  local current_time
  _sbp_get_current_time current_time
  time_since_update=$((current_time - last_update))

  if [[ $time_since_update -lt $refresh_rate ]]; then
    return 0
  fi

  weather_data=$(segments::wttr_fetch_changes)

  if [[ -n $weather_data ]]; then
    echo "$weather_data" >"$SEGMENT_CACHE"
  fi
}

segments::wttr() {
  if [[ -f $SEGMENT_CACHE ]]; then
    mapfile -t result <"$SEGMENT_CACHE"
    print_themed_segment 'normal' "${result[@]}"
  fi
  execute::execute_nohup_function segments::wttr_refresh
}
