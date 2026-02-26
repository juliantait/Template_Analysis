# GitHub Sync Guide

GitHub sync is an **optional** feature. The main project repository can have a remote origin pointing to a GitHub (or GitLab, Bitbucket, etc.) repository. Two shell helper functions — `gdone` and `gsync` — provide quick commit-and-push workflows.

---

## Status gate

Before attempting any GitHub sync, check whether a remote is configured:

```bash
git remote -v
```

- If `origin` points to a GitHub (or similar) URL → configured, proceed.
- If there is no remote → not configured, skip silently.

**Never prompt, warn, or mention GitHub sync if it is not configured.** The feature simply does not exist for that project.

---

## Core principles

- **Separate from Overleaf sync** — Overleaf sync operates on the `LaTeX/` sub-repo; GitHub sync operates on the main project repo. They are independent.
- **Never sync automatically** — always wait for the user to request a push, or ask explicitly before pushing.
- **No force pushes** — never use `--force` or `--force-with-lease` unless the user explicitly requests it.
- **Respect uncommitted work** — if there are unstaged changes the user hasn't reviewed, flag them before syncing.

---

## Setup instructions (user-facing)

These steps are performed once by the user, not by the agent. Reference blueprints are stored in `Context/Helpers/gdone.sh` and `Context/Helpers/gsync.sh`.

1. **Add the functions to your shell.** Copy the functions from `Context/Helpers/gdone.sh` and `Context/Helpers/gsync.sh` into `~/.zshrc` (or `~/.bashrc`), then restart your shell or run `source ~/.zshrc`.

2. **Create a GitHub repository** (public or private) for the project.

3. **Add the remote and push:**
   ```bash
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

4. **Verify:** run `git remote -v` and confirm origin points to your repository.

---

## Two functions

### `gdone` — commit and push (no pull)

```bash
gdone "commit message"
```

What it does:
1. Stages all changes (new, modified, deleted files).
2. Shows a summary of what is being committed.
3. Commits with the provided message (defaults to "updates").
4. Pushes to the remote.

Use `gdone` when you are the **sole contributor** and there are no remote changes to pull.

### `gsync` — commit, pull, then push

```bash
gsync "commit message"
```

What it does:
1. Stages and commits any local changes (defaults to "updates").
2. Pulls from the remote (and flags merge conflicts if any).
3. Updates submodules if present.
4. Pushes to the remote.

Use `gsync` when **remote changes might exist** — collaborators pushing, edits via the GitHub web interface, or after a long gap since the last sync.

---

## When to use which

| Scenario | Function | Why |
|---|---|---|
| Solo researcher, regular sessions | `gdone` | No remote changes expected; skip the pull |
| Collaborators pushing to the repo | `gsync` | Pull first to avoid rejected pushes |
| Long gap since last sync | `gsync` | Remote may have diverged; pull catches you up |
| After resolving merge conflicts | `gdone` | Conflicts already resolved locally; just push |
| CI/CD or GitHub Actions modifying the repo | `gsync` | Automated commits may exist on remote |

---

## When to sync

GitHub sync is **not** a mandatory end-of-session step (unlike the Overleaf sync prompt). Push when:

- The user explicitly asks to push.
- A significant milestone is reached (e.g. a to-do part is completed).
- The user is about to share the repo with someone.
- Before switching to a different machine.

Do not push after every small change. Batch related work into meaningful commits.

---

**Rule of thumb:** `gdone` for solo work, `gsync` when others might have pushed.
