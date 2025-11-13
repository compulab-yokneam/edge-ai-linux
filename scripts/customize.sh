#!/usr/bin/env bash
set -euo pipefail

PATCH_DIR="${COMPULAB_DIR}/patches"
BRANCH_NAME="compulab_$(date +%Y-%m-%d_%H-%M-%S)"
SRC_TAG="jetson_${VERSION_MAJOR}.${VERSION_MINOR}"

l4t_init() {
    git -C ${L4T_DIR} init 2>/dev/null
    git -C ${L4T_DIR} commit --allow-empty -m"Init"
}

l4t_clean_up() {
    pushd ${L4T_DIR}
    if [[ -d .git ]];then
        local files_to_remove=$(git diff $(git log --oneline | awk '(/Init/)&&($0=$1)').. --name-only)
        [[ -z ${files_to_remove:-""} ]] || rm -rf ${files_to_remove}
        rm -rf .git
    fi
    popd
    rm -rf ${L4T_DIR}/bootloader/uefi_jetson*
}

l4t_patch() {
    git -C ${L4T_DIR} am "${PATCH_DIR}/Linux_for_Tegra/"*
}

# root node
l4t() {
    l4t_clean_up
    l4t_init
    l4t_patch
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
