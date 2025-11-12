#!/usr/bin/env bash
set -euo pipefail

PATCH_DIR="${COMPULAB_DIR}/patches"

# Apply edgeai configurations,
# botloader and prebuild binaries
git -C ${L4T_DIR} init 2>/dev/null
git -C ${L4T_DIR} apply "${PATCH_DIR}/Linux_for_Tegra/"*

# kernel
cd "${L4T_SRC_DIR}/kernel/kernel-jammy-src"
patch -p1 < "${PATCH_DIR}/kernel/"*
make defconfig

# device tree
git -C ${L4T_SRC_DIR}/hardware/nvidia/t23x/nv-public apply "${PATCH_DIR}/dts/"*
