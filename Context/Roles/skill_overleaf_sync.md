# Overleaf Sync Guide

Overleaf sync is an **optional** feature. The `LaTeX/` folder can be its own git repository with an `origin` remote pointing to an Overleaf project via Overleaf's built-in Git integration. This gives two-way sync: edit locally or in Overleaf, and `latexsync` keeps them aligned.

---

## Status gate

Before attempting any Overleaf sync, check whether it is configured:

```bash
cd LaTeX && git remote -v
```

- If `origin` points to `https://git@git.overleaf.com/<id>` → configured, proceed.
- If there is no `.git` directory or no remote → not configured, skip silently.

**Never prompt, warn, or mention Overleaf sync if it is not configured.** The feature simply does not exist for that project.

---

## Core principles

- **Optional** — Overleaf sync is a convenience, not a requirement. If it is not set up, the agent ignores it entirely.
- **Never block on it** — if `latexsync` fails (network error, conflict), log the failure and move on. Do not retry in a loop.
- **Always ask before syncing** — never run `latexsync` without explicit user confirmation, even if permissions are set to auto-approve.
- **Separate repository** — `LaTeX/` is its own git repo, independent of the main project repo. Do not confuse the two.

---

## Setup instructions (user-facing)

These steps are performed once by the user, not by the agent. A reference blueprint of the `latexsync` function is stored in `Context/Helpers/latexsync.sh`.

1. **Add the `latexsync` function to your shell.** Copy the function from `Context/Helpers/latexsync.sh` into `~/.zshrc` (or `~/.bashrc`), then restart your shell or run `source ~/.zshrc`.

2. **Create or open an Overleaf project** at https://www.overleaf.com.
   - New project: *New Project → Blank Project* (or upload a zip of `LaTeX/`).
   - Existing project: just open it.

3. **Enable the Git integration in Overleaf:**
   - Click the Menu button (top-left hamburger icon).
   - Scroll down to the "Sync" section.
   - Click "Git".
   - Overleaf will display a Git URL like: `https://git@git.overleaf.com/<project-id>`
   - Copy this URL.

   **Important:** This is Overleaf's **Git** integration, NOT the GitHub integration. They are separate features. You want the one that gives you a `git.overleaf.com` URL.

4. **Initialise the `LaTeX/` folder as a linked repo:**

   If `LaTeX/` is NOT yet a git repo:
   ```bash
   cd LaTeX
   git init
   git remote add origin https://git@git.overleaf.com/<project-id>
   git add .
   git commit -m "Initial commit from local"
   git pull origin master --allow-unrelated-histories --no-rebase
   git push -u origin master
   ```

   If `LaTeX/` IS already a git repo but has no Overleaf remote:
   ```bash
   cd LaTeX
   git remote add origin https://git@git.overleaf.com/<project-id>
   git pull origin master --allow-unrelated-histories --no-rebase
   git push -u origin master
   ```

5. **Authenticate.** Overleaf will prompt for credentials on first push/pull. Use your Overleaf email and the password shown in the Git modal (this is an Overleaf-generated token, NOT your Overleaf login password).

6. **Verify:** run `cd LaTeX && git remote -v` and confirm origin points to `git.overleaf.com`.

---

## Usage

Run from the **project root** (the folder containing `LaTeX/`), not from inside `LaTeX/`:

```bash
latexsync "commit message"
```

What it does:
1. Enters the `LaTeX/` folder.
2. Stages and commits any local changes.
3. Pulls from Overleaf (and flags merge conflicts if any).
4. Pushes to Overleaf.
5. Returns to the original directory.

If merge conflicts are detected, the function stops and reports them. The user must resolve conflicts manually, then run `latexsync` again.

---

## End-of-session mandatory prompt

At the end of every agent session that changed `.tex` files, **after** taking the draft snapshot and adding the sticky note:

1. Run the status gate check. If not configured, skip — do not mention Overleaf at all.
2. If configured, use `AskUserQuestion` with:
   - A proposed commit message summarising what changed in this session.
   - Options: "Yes, sync with this message" / "No, don't sync" (the user can also choose "Other" to supply a custom message).
3. If the user confirms, run `latexsync "<confirmed message>"`.
4. If the user declines, move on without syncing.

**This prompt is mandatory every time**, even if the user approved sync in a previous session. Each sync requires fresh confirmation.

---

**Rule of thumb:** if Overleaf sync is configured and you changed `.tex` files, ask. If it is not configured, stay silent.
