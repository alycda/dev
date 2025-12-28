#!/usr/bin/env bash
set -e

# Set USER if not already set (common in containers)
export USER=${USER:-root}
export HOME=${HOME:-/root}

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"

# Add Nix channels
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Install home-manager
nix-shell '<home-manager>' -A install

# Apply the configuration from this repo
home-manager switch -b backup -f "${SCRIPT_DIR}/home.nix"

# Allow direnv for this template repo (if it has .envrc)
if [ -f "${WORKSPACE_DIR}/.envrc" ]; then
    cd "${WORKSPACE_DIR}"
    direnv allow
fi