#!/usr/bin/env bash
# Lightweight but real CI subset for the merge-guard trial:
#   1. the repo's own tidy + fmt suite (./x.py test tidy), the same check
#      rust-lang runs first on every PR
#   2. compile + run each trial binary with the system rustc
# Intentionally NOT a compiler build or test run, which does not fit
# GitHub-hosted runner limits.
set -euo pipefail

./x.py test tidy

if [ -d merge-guard-trial ]; then
  rustc --edition 2021 --crate-type lib merge-guard-trial/a.rs -o /tmp/merge-guard-a.rlib
  for f in merge-guard-trial/*_main.rs; do
    [ -e "$f" ] || continue
    bin="/tmp/$(basename "$f" .rs)"
    rustc --edition 2021 "$f" -o "$bin"
    "$bin"
  done
fi
