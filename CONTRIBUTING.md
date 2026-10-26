# Contributing to nuvek-agent-config

Thanks for taking the time to help. Bug reports, ideas, documentation fixes and new generic skills are
all welcome.

Everyone taking part is expected to follow the [Code of Conduct](CODE_OF_CONDUCT.md). Security problems
are not reported in issues: follow [SECURITY.md](SECURITY.md).

## Before you write anything

Open an issue first for a new skill, a new agent or a change to `rules/core.md`. Typo fixes and obvious
corrections can go straight to a pull request.

Then read [AGENTS.md](AGENTS.md). It holds the rules that decide most reviews: neutral wording,
present-state facts, one skill with one job, strict YAML frontmatter, and no private facts.

## Setting up

```bash
git clone https://github.com/jean1880/nuvek-agent-config.git
cd nuvek-agent-config
git config core.hooksPath .githooks
```

The pre-commit hook runs [gitleaks](https://github.com/gitleaks/gitleaks) and `scripts/check-public.sh`.
Install gitleaks first. Never use `--no-verify`.

To check that your change still renders, install `nuvek-agent-sync` and run, against a scratch home:

```bash
HOME="$(mktemp -d)" agent-sync check --dir "$PWD"
```

It reports drift on an empty home. What matters is that it parses every source without an error.

## Commits and pull requests

- Commits follow [Conventional Commits](https://www.conventionalcommits.org/), for example
  `feat(skills): add a database-migrations skill`.
- Every commit carries a `Signed-off-by:` line (`git commit -s`), certifying the
  [Developer Certificate of Origin](https://developercertificate.org/).
- Open the pull request against `master`. CI runs markdownlint, a TOML parse check, gitleaks and the
  private-details check; all four must pass.
- Write prose in Canadian English. Code identifiers keep their own spelling.
- Commit messages, pull request text and comments state facts about the change. They do not point to
  notes or documents a reader cannot open.

## AI-assisted contributions

Using AI in a contribution is fine. The responsibility stays with you: say which tools you used, understand
every line, and edit what you post.

## Licence

This project is released under the [MIT Licence](LICENSE). By contributing, you agree that your
contribution is licensed under the same terms, and that you have the right to submit it.
