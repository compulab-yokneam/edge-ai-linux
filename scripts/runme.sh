#!/bin/bash
set -e

REPO_URL="https://github.com/compulab-yokneam/edge-ai-linux"
SNAPSHOT_URL="$REPO_URL/archive/refs/heads/master.tar.gz"
curl -fsSL "$SNAPSHOT_URL" | tar -xz
cd "edge-ai-linux-master/scripts"
exec bash ./build.sh all