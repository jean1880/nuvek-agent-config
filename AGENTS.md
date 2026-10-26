# AGENTS.md

Contributor rules for this repository. It is the single authored source of instructions for Claude Code,
Antigravity and Codex. A tool's own configuration is a symlink into this repository or a file generated
from it, so edit here and never edit a projection.

## Layout

- `.claude-plugin/plugin.json` and `skills/<name>/SKILL.md`: the plugin and its skills.
- `rules/core.md`: shared mandates, in tool-neutral wording. `rules/claude.md`, `agy.md` and `codex.md`
  are per-tool overlays.
- `sync/`: neutral sources (`agents/`, `commands/`, `mcp.toml`, `permissions.toml`, `hooks.toml`,
  `map.toml`, optional `models.toml`) that `agent-sync apply` renders per tool. `*.example` files are
  templates and are not read by `agent-sync`.

**Never add `agents/`, `commands/` or `hooks/` at the repository root.** The root is also the Claude plugin
root, and Claude loads those directories there as plugin components.

## Rules for editing skills

- **Neutral wording.** Name model tiers (`fast`, `standard`, `deep`), "the interactive question tool",
  MCP tools as `server` → `tool`, and CLIs by their bare name. A passage that only one tool can follow
  goes in its overlay or inside an `<!-- only:claude -->` or `<!-- only:agy -->` block.
- **Present-state facts.** A skill states how things are now: the rule, the failure mode and the fix. No
  dates, no changelog prose, no "used to", "was" or "deprecated". Something that no longer exists gets no
  mention.
- **One skill, one job.** If a skill covers two unrelated jobs, split it. Resolve overlap between skills in
  their descriptions and in the routing section of `rules/core.md`.
- **How, not what.** A skill teaches procedures and failure modes. It never stores facts that change on
  their own (inventories, addresses, versions, file lists).
- **Strict YAML frontmatter.** Quote any `description` that contains `: `. Claude tolerates sloppy
  frontmatter; Antigravity drops the whole skill. `name` equals the folder name.
- **Optional integrations stay optional.** A skill may name `cross-agent`, `hive-board` or another tool,
  but it must still work without it and say what to do instead.
- **No private facts.** No hostnames, domains, addresses, usernames or home paths. Use a placeholder or a
  `<!-- customise: ... -->` marker. CI greps for these and fails on a hit.
- **No agent artefacts.** Plans, reviews, QA notes and investigation notes do not belong in this
  repository, and commit messages and comments do not cite them.
- **Canadian English** in prose. Code identifiers keep their own spelling.

## Before you commit

1. `agent-sync check --dir "$PWD"` against a scratch `HOME` must parse without an error (drift on a clean
   home is expected).
2. `scripts/check-public.sh` finds no private deployment details.
3. The pre-commit hook (`git config core.hooksPath .githooks`) runs gitleaks. Never use `--no-verify`.
4. Conventional Commits, commit straight to `master` in a personal fork, and sign off (`-s`) for a pull
   request.
