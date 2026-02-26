# gdone — Git commit-and-push in one step
#
# Usage:  gdone "commit message"
#         gdone                     # defaults to "updates"
#
# What it does:
#   1. Stages all changes (new, modified, deleted files)
#   2. Shows a summary of what's being committed
#   3. Commits with the provided message
#   4. Pushes to the remote (GitHub, GitLab, etc.)
#
# Setup:
#   Add this function to your ~/.zshrc (or ~/.bashrc), then restart your shell
#   or run: source ~/.zshrc
#
#   The project must already be a git repo with a remote configured:
#     git init
#     git remote add origin <your-repo-url>
#     git push -u origin main

gdone() {
    local commit_msg="${1:-updates}"

    # Check for changes
    if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
        echo "  ✅ Nothing to commit, working tree clean"
        return 0
    fi

    # Stage everything
    git add .

    # Show what's being committed
    local staged=$(git diff --cached --name-status)
    if [ -n "$staged" ]; then
        echo "  📦 Staging changes:"
        echo "$staged" | while IFS=$'\t' read -r chg file; do
            case "$chg" in
                A) echo "      ✨ $file (new)" ;;
                M) echo "      📝 $file (modified)" ;;
                D) echo "      🗑  $file (deleted)" ;;
                R*) echo "      📎 $file (renamed)" ;;
                *) echo "      📄 $file" ;;
            esac
        done
    fi

    # Commit
    commit_output=$(git commit -m "$commit_msg" 2>&1)
    if [ $? -eq 0 ]; then
        echo "  💾 Committed: \"$commit_msg\""
    else
        echo "  ❌ Commit failed:"
        echo "$commit_output" | sed 's/^/      /'
        return 1
    fi

    # Push
    push_output=$(git push 2>&1)
    if [ $? -eq 0 ]; then
        echo "  🚀 Pushed to GitHub"
    else
        echo "  ❌ Push failed:"
        echo "$push_output" | sed 's/^/      /'
        return 1
    fi

    echo "  ✅ Done!"
}
