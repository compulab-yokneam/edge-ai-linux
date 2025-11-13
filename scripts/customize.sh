#!/usr/bin/env bash
set -euo pipefail

PATCH_DIR="${COMPULAB_DIR}/patches"
BRANCH_NAME="compulab_$(date +%Y-%m-%d_%H-%M-%S)"
SRC_TAG="jetson_${VERSION_MAJOR}.${VERSION_MINOR}"
# CompuLab Resources
L4T_COMPULAB="https://github.com/compulab-yokneam/compulab-l4t/archive/refs/heads/Linux_for_Tegra.tar.gz"

# root node
l4t() {
    curl -fsSL ${L4T_COMPULAB} | tar -C ${L4T_DIR} --strip-components=1 -xvz
}

# kernel
kernel() {
    git -C ${L4T_SRC_DIR}/kernel/kernel-jammy-src checkout -b ${BRANCH_NAME} ${SRC_TAG}
    git -C ${L4T_SRC_DIR}/kernel/kernel-jammy-src am  "${PATCH_DIR}/kernel/"*
    make -C ${L4T_SRC_DIR}/kernel/kernel-jammy-src defconfig
}

# device tree
device_tree() {
    git -C ${L4T_SRC_DIR}/hardware/nvidia/t23x/nv-public checkout -b ${BRANCH_NAME} ${SRC_TAG}
    git -C ${L4T_SRC_DIR}/hardware/nvidia/t23x/nv-public am "${PATCH_DIR}/dts/"*
}

l4t
kernel
device_tree
