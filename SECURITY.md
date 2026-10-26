# Security policy

## Supported versions

Only the latest release (and `master`) receives security fixes.

## Reporting a vulnerability

Please report vulnerabilities privately through GitHub's
[private vulnerability reporting](https://github.com/jean1880/nuvek-agent-config/security/advisories/new),
not in a public issue. Only the maintainers see the report.

Include the version, the steps to reproduce and the impact you expect. Leave out real secrets,
tokens and hostnames: a placeholder shows the problem just as well.

You should get an acknowledgement within a week. Once a fix is released, the advisory is published
with credit to the reporter unless you prefer otherwise.

## Scope

This repository holds instructions that coding agents follow, and sources that `agent-sync` renders into
their configuration. Of particular interest:

- an instruction, skill or agent that leads an agent to expose, print or exfiltrate secrets;
- a permission or hook example that grants more access than it says;
- text that makes an agent bypass a safety gate (`--no-verify`, a scanner, branch protection);
- a committed credential or private deployment detail.

Vulnerabilities in the agent CLIs themselves (Claude Code, agy, Codex) belong with their vendors, and
issues in `agent-sync` belong in its own repository.
