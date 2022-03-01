#!/usr/bin/env bash

segments::rust() {
  if [[ -z "$RUSTVERSION" ]] && [[ -f "${PWD}/Cargo.toml" ]]; then
    if type rustc &> /dev/null; then
      export RUSTVERSION="$(rustc --version | awk '{print $2}')"
    fi
  fi
  if [[ -n "$RUSTVERSION" ]]; then
    print_themed_segment 'normal' "$RUSTVERSION"
  fi
}
