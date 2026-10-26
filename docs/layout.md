# How the source is laid out and rendered

## How one source feeds three CLIs

```text
rules/core.md      ──►  Claude: imported by ~/.claude/CLAUDE.md
  + rules/<tool>.md     AGY:    ~/.gemini/AGENTS.md and GEMINI.md
                        Codex:  generated ~/.codex/AGENTS.md (core + Codex overlay)
skills/<name>/     ──►  Claude plugin link · ~/.gemini/config/skills · per-skill links in ~/.codex/skills
sync/agents/       ──►  rendered per tool (model tier and tool names mapped by sync/map.toml)
sync/mcp.toml      ──►  ~/.claude.json · AGY mcp_config.json · ~/.codex/config.toml
sync/permissions   ──►  Claude and AGY settings.json
sync/hooks.toml    ──►  Claude, AGY and Codex hooks
sync/models.toml   ──►  model capability tags (optional)
```

`agent-sync check` is read-only and exits 6 on drift. `agent-sync apply` writes the projections atomically
and keeps the previous copy as `<file>.agent-sync.bak`.

## Skills

| Skill | Job |
|---|---|
| `delegation` | Fan-out, deliberation, team coordination, cross-harness review |
| `rust-craftsman` | Author and refactor Rust, with the gate and release steps |
| `polyglot-architect` | Language choice, project hygiene and review loops (Rust, TS/Vue, Python, shell, .NET, C++) |
| `skill-creator` | How to write and maintain skills |
| `security-governance` | Secret handling, masking, least privilege, exposure review |
| `git-workflow-expert` | Commits, branches, tags, PR hygiene, release notes |
| `package-release` | SemVer, bump automation, release notes, CI verification |
| `shared-library-review` | Review rubric for shared Vue and Rust libraries |

Agents in `sync/agents/`: `rust-reviewer`, `script-reviewer`, `plan-reviewer`, `skill-auditor`.

Skills that rely on an optional integration say so where it applies: `cross-agent` and
[Agent Terminal](https://github.com/jean1880/nuvek-agent-terminal) for cross-harness spawns, and
[hive-board](https://github.com/jean1880/nuvek-hive-board) for a shared findings board. Everything works without them.
