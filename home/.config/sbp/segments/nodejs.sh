#!/usr/bin/env bash

segments::nodejs() {
  if [[ -z "$NODEVERSION" ]] && [[ -f "${PWD}/package.json" ]]; then
    if type node &> /dev/null; then
      NODEVERSION="$(node --version)"
      export NODEVERSION="${NODEVERSION##*v}"
    fi
  fi
  if [[ -n "$NODEVERSION" ]]; then
    print_themed_segment 'normal' "$NODEVERSION"
  fi
}
