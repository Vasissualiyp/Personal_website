#!/usr/bin/env bash
# Convenience script to run Hugo development server

set -e

cd "$(dirname "$0")/hugo-site"

if command -v hugo &> /dev/null; then
    echo "Starting Hugo server with system Hugo..."
    hugo server -D
elif command -v nix &> /dev/null; then
    echo "Starting Hugo server with Nix Hugo..."
    nix-shell -p hugo --run "hugo server -D"
else
    echo "Error: Neither Hugo nor Nix found. Please install one of them."
    exit 1
fi
