#!/usr/bin/env bash
# Runs `agent-sync check` against this checkout with an isolated, throwaway HOME.
# Exit 6 (drift on an empty home) is expected and accepted; any other non-zero exit fails.
# Usage: scripts/agent-sync-compat.sh [path-to-agent-sync]
set -euo pipefail

root=$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel)
bin=${1:-agent-sync}

home=$(mktemp -d)
trap 'rm -rf "$home"' EXIT

# agent-sync reads these tool files even when they are empty, so seed them.
mkdir -p "$home/.claude" "$home/.codex" "$home/.gemini/antigravity-cli"
echo '{}' >"$home/.claude.json"
echo '{}' >"$home/.claude/settings.json"
echo '{}' >"$home/.gemini/antigravity-cli/settings.json"
: >"$home/.codex/config.toml"

rc=0
HOME="$home" XDG_CONFIG_HOME="" "$bin" check --dir "$root" || rc=$?

case $rc in
  0 | 6) echo "agent-sync-compat: sources parsed (exit $rc)" ;;
  *)
    echo "agent-sync-compat: agent-sync exited $rc" >&2
    exit "$rc"
    ;;
esac
