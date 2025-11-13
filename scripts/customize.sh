#!/usr/bin/env bash
set -euo pipefail

PATCH_DIR="${COMPULAB_DIR}/patches"
FILES_DIR="${COMPULAB_DIR}/files"

cp -v ${FILES_DIR}/conf/* ${L4T_DIR}/

# kernel
cd "${L4T_SRC_DIR}/kernel/kernel-jammy-src"
patch -p1 < "${PATCH_DIR}/kernel/"*
make defconfig

# bootloader
cd "${L4T_DIR}/bootloader"
patch -p1 < "${PATCH_DIR}/bl/"*

# Deploy precompiled files
tar -C "${L4T_DIR}/bootloader" -xvf "${FILES_DIR}/bl/bootloader.tar.bz2"

# device tree
cd "${L4T_SRC_DIR}/hardware/nvidia/t23x/nv-public"
git apply "${PATCH_DIR}/dts/"*
