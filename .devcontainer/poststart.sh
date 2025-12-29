#!/usr/bin/env bash
set -e

# Mark repo as safe, see: https://code.visualstudio.com/docs/sourcecontrol/faq#_why-is-vs-code-warning-me-that-the-git-repository-is-potentially-unsafe (because of nix)
git config --global --add safe.directory ${containerWorkspaceFolder}

# Configure jj from git config (runs after git config is ready)
if command -v jj &> /dev/null; then
    GIT_NAME=$(git config --get user.name 2>/dev/null || echo "")
    GIT_EMAIL=$(git config --get user.email 2>/dev/null || echo "")
    
    if [ -n "$GIT_NAME" ] && [ -n "$GIT_EMAIL" ]; then
        # Only set if not already configured
        if ! jj config list --user 2>/dev/null | grep -q "user.email"; then
            jj config set --user user.name "$GIT_NAME"
            jj config set --user user.email "$GIT_EMAIL"
            echo "✓ Configured jujutsu: $GIT_NAME <$GIT_EMAIL>"
        fi
    fi
fi