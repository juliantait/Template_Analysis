# gsync — Git sync: commit, pull, push
#
# Usage:  gsync "commit message"
#         gsync                     # defaults to "updates"
#
# What it does:
#   1. Stages and commits any local changes
#   2. Pulls from the remote (and flags merge conflicts if any)
#   3. Updates submodules if present
#   4. Pushes to the remote
#
# Use gsync instead of gdone when you expect there may be remote changes
# (e.g. collaborators pushing, or edits made via GitHub web interface).
#
# Setup:
#   Add this function to your ~/.zshrc (or ~/.bashrc), then restart your shell
#   or run: source ~/.zshrc
#
#   The project must already be a git repo with a remote configured:
#     git init
#     git remote add origin <your-repo-url>
#     git push -u origin main

gsync() {
    local commit_msg="${1:-updates}"

    # Stage & commit local changes first
    git add .
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
        commit_output=$(git commit -m "$commit_msg" 2>&1)
        if [ $? -eq 0 ]; then
            echo "  💾 Committed: \"$commit_msg\""
        else
            echo "  ❌ Commit failed:"
            echo "$commit_output" | sed 's/^/      /'
            return 1
        fi
    else
        echo "  ✅ No local changes to commit"
    fi

    # Pull from remote
    echo "  📥 Pulling from GitHub..."
    pull_output=$(git pull 2>&1)
    pull_exit=$?

    if echo "$pull_output" | grep -q "CONFLICT"; then
        echo "  ❗ Merge conflicts:"
        echo "$pull_output" | grep "CONFLICT" | sed 's/^/      ❗ /'
        echo "  ❗ Fix conflicts, then run gdone to finish"
        return 1
    elif echo "$pull_output" | grep -q "Already up to date"; then
        echo "  ✅ Already up to date"
    elif [ $pull_exit -ne 0 ]; then
        echo "  ❌ Pull failed:"
        echo "$pull_output" | sed 's/^/      /'
        return 1
    else
        echo "  📥 Pulled from GitHub:"
        echo "$pull_output" | grep "|" | awk '{print "      📄 " $1}'
    fi

    # Update submodules if any
    if [ -f ".gitmodules" ]; then
        echo "  🔄 Updating submodules..."
        sub_output=$(git submodule update --init --recursive 2>&1)
        if [ $? -ne 0 ]; then
            echo "  ❌ Submodule update failed:"
            echo "$sub_output" | sed 's/^/      /'
            return 1
        fi
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
