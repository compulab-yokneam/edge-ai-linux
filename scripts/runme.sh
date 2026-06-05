#!/bin/bash
set -euo pipefail

EDGE_AI_SDK="edgeai-compulab-bsp"
SRCREV="devel"
SRC_URI="https://github.com/compulab-yokneam/edge-ai-linux/archive/refs/heads/${SRCREV}.tar.gz"

mkdir ${EDGE_AI_SDK}
curl -fsSL ${SRC_URI} | tar -C ${EDGE_AI_SDK} --strip-components=1 -xz
cd ${EDGE_AI_SDK}/scripts
exec bash ./build.sh all
