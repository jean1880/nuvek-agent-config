#!/usr/bin/env bash
# Fails when tracked files carry details that identify a private deployment: private-range
# addresses, absolute home-directory paths and credential-shaped strings. Generic detectors only.
# Run from anywhere inside the repository.
set -euo pipefail

root=$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel)

patterns=(
  # RFC 1918 private IPv4 ranges
  '\b10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b'
  '\b172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3}\b'
  '\b192\.168\.[0-9]{1,3}\.[0-9]{1,3}\b'
  # Absolute home-directory paths naming a real user
  '[/]home[/][A-Za-z_][A-Za-z0-9_-]*[/]'
  '[/]Users[/][A-Za-z_][A-Za-z0-9_-]*[/]'
  # Credential shapes
  'ghp_[A-Za-z0-9]{20,}'
  'sk-[A-Za-z0-9_-]{20,}'
  'AIza[0-9A-Za-z_-]{35}'
  '[-]{5}BEGIN [A-Z ]*PRIVATE KEY[-]{5}'
)
regex=$(IFS='|'; echo "${patterns[*]}")

if hits=$(git -C "$root" grep -nIE -e "$regex" -- .); then
  printf '%s\n' "$hits"
  echo "check-public: private deployment details or credential shapes found (see above)" >&2
  exit 1
fi
echo "check-public: clean"
