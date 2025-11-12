#!/bin/bash
set -e

EDGE_AI_SDK="edgeai-compulab-bsp"
REPO_URL="https://github.com/compulab-yokneam/edge-ai-linux"
SNAPSHOT_URL="$REPO_URL/archive/refs/heads/devel.tar.gz"
mkdir ${EDGE_AI_SDK}
curl -fsSL "$SNAPSHOT_URL" | tar -C ${EDGE_AI_SDK} --strip-components=1 -xz
cd "${EDGE_AI_SDK}/scripts"
exec bash ./build.sh all
