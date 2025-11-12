#!/usr/bin/env bash
set -euo pipefail

PATCH_DIR="${COMPULAB_DIR}/patches"

# Apply edgeai configurations,
# bootloader and prebuild binaries
git -C ${L4T_DIR} init 2>/dev/null
git -C ${L4T_DIR} apply "${PATCH_DIR}/Linux_for_Tegra/"*

# kernel
git -C ${L4T_SRC_DIR}/kernel/kernel-jammy-src apply  "${PATCH_DIR}/kernel/"*
make -C ${L4T_SRC_DIR}/kernel/kernel-jammy-src defconfig

# device tree
git -C ${L4T_SRC_DIR}/hardware/nvidia/t23x/nv-public apply "${PATCH_DIR}/dts/"*
