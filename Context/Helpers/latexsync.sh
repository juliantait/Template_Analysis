# latexsync — Sync the LaTeX/ folder to/from Overleaf via Git
#
# Usage:  latexsync "commit message"
#         latexsync                     # defaults to "changes from laptop"
#
# Run from the PROJECT ROOT (the folder containing LaTeX/), not from inside LaTeX/.
#
# What it does:
#   1. Enters the LaTeX/ folder
#   2. Stages and commits any local changes
#   3. Pulls from Overleaf (and flags merge conflicts if any)
#   4. Pushes to Overleaf
#   5. Returns to the original directory
#
# How it works:
#   The LaTeX/ folder is its own git repository, separate from the main project
#   repo. Its `origin` remote points to an Overleaf project via Overleaf's
#   built-in Git integration. This gives you two-way sync: edit locally or in
#   Overleaf, and latexsync keeps them aligned.
#
# Setup:
#   Add this function to your ~/.zshrc (or ~/.bashrc), then restart your shell
#   or run: source ~/.zshrc
#
#   Then set up the LaTeX/ folder as described below.
#
# ─── OVERLEAF SETUP (one-time, must be done by the user in a browser) ───
#
#   1. Create or open an Overleaf project at https://www.overleaf.com
#      - New project: New Project → Blank Project (or upload a zip of LaTeX/)
#      - Existing project: just open it
#
#   2. Enable the Git integration in Overleaf:
#      - Click the Menu button (top-left hamburger icon)
#      - Scroll down to the "Sync" section
#      - Click "Git"
#      - Overleaf will display a Git URL like:
#            https://git@git.overleaf.com/<project-id>
#      - Copy this URL
#
#      IMPORTANT: This is Overleaf's GIT integration, NOT the GitHub integration.
#      They are separate features. You want the one that gives you a
#      git.overleaf.com URL.
#
#   3. Initialise the LaTeX/ folder as a git repo linked to Overleaf:
#
#      If LaTeX/ is NOT yet a git repo:
#        cd LaTeX
#        git init
#        git remote add origin https://git@git.overleaf.com/<project-id>
#        git add .
#        git commit -m "Initial commit from local"
#        git pull origin master --allow-unrelated-histories --no-rebase
#        git push -u origin master
#
#      If LaTeX/ IS already a git repo but has no Overleaf remote:
#        cd LaTeX
#        git remote add origin https://git@git.overleaf.com/<project-id>
#        git pull origin master --allow-unrelated-histories --no-rebase
#        git push -u origin master
#
#   4. Overleaf will prompt for credentials on first push/pull.
#      Use your Overleaf email and the password shown in the Git modal
#      (this is an Overleaf-generated token, NOT your Overleaf login password).
#
#   5. Verify: run `cd LaTeX && git remote -v` and confirm origin points to
#      git.overleaf.com. You're ready to use latexsync.
#
# ─── VERIFICATION ───
#
#   To check if Overleaf sync is configured:
#     cd LaTeX && git remote -v
#   If origin points to https://git@git.overleaf.com/<id>, it's ready.
#   If there's no .git or no remote, follow the setup steps above.
#
# ────────────────────────────────────────────────────────────────────────

latexsync() {
    local commit_msg="${1:-changes from laptop}"
    local start_dir=$(pwd)

    # Go to LaTeX folder
    if [ ! -d "LaTeX" ]; then
        echo "  ❌ No LaTeX folder found in $start_dir"
        return 1
    fi
    cd LaTeX || return 1

    # Stage & commit local changes first
    git add .
    if git diff-index --quiet HEAD --; then
        echo "  ✅ No local changes to commit"
    else
        echo "  📦 Staging changes:"
        git diff --cached --name-only | sed 's/^/      📄 /'
        git commit -m "$commit_msg" >/dev/null 2>&1
        echo "  💾 Committed: \"$commit_msg\""
    fi

    # Pull from Overleaf
    echo "  📥 Pulling from Overleaf..."
    git_output=$(git pull origin master --allow-unrelated-histories --no-rebase 2>&1)

    if echo "$git_output" | grep -q "CONFLICT"; then
        echo "  ❗ Merge conflicts from Overleaf:"
        echo "$git_output" | grep "CONFLICT" | sed 's/^/      ❗ /'
        echo "  ❗ Fix conflicts, then run latexsync again"
        cd "$start_dir" || return 1
        echo "  📂 Returned to $start_dir"
        return 1
    elif echo "$git_output" | grep -q "Already up to date"; then
        echo "  ✅ Already up to date with Overleaf"
    else
        echo "  📥 Pulled from Overleaf:"
        echo "$git_output" | grep "|" | awk '{print "      📄 " $1}'
    fi

    # Push
    push_output=$(git push -u origin master 2>&1)
    if [ $? -eq 0 ]; then
        echo "  🚀 Pushed to Overleaf"
    else
        echo "  ❌ Push failed:"
        echo "$push_output" | sed 's/^/      /'
    fi

    # Return to original folder
    cd "$start_dir" || return 1
    echo "  📂 Returned to $start_dir"
}
