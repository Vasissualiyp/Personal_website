#!/usr/bin/env bash
# Convenience script to build and serve the Hugo site locally

set -e

cd "$(dirname "$0")/hugo-site"

if command -v hugo &> /dev/null; then
    echo "Using system Hugo..."
    hugo "$@"
elif command -v nix &> /dev/null; then
    echo "Using Nix Hugo..."
    nix-shell -p hugo --run "hugo $*"
else
    echo "Error: Neither Hugo nor Nix found. Please install one of them."
    exit 1
fi
