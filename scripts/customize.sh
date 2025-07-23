#!/usr/bin/env bash
set -euo pipefail

PATCH_DIR="${COMPULAB_DIR}/patches"

cp -v "${COMPULAB_DIR}/edge-ai.conf" "${L4T_DIR}/"

# kernel
cd "${L4T_SRC_DIR}/kernel/kernel-jammy-src"
git am "${PATCH_DIR}/kernel/"*
make defconfig

# bootloader
cd "${L4T_DIR}/bootloader"
patch -p1 < "${PATCH_DIR}/bl/0001-support-for-Orin-edge-ai.patch"
gzip --decompress uefi_jetson.bin.gz
cp -v bootloader/uefi_jetson.bin "${L4T_DIR}/bootloader/"

# device tree
cd "${L4T_SRC_DIR}/hardware/nvidia/t23x/nv-public"
git am "${PATCH_DIR}/dts/"*