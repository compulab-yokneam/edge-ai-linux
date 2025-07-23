#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/set_env.sh"

download() {
    mkdir -p "${DL_DIR}"
    wget -nc -P "${DL_DIR}" "${RELEASE_URL}/${L4T_RELEASE_PACKAGE}"
    wget -nc -P "${DL_DIR}" "${RELEASE_URL}/${SAMPLE_FS_PACKAGE}"
    wget -nc -P "${DL_DIR}" "${TOOLS_URL}/${TOOLS_PACKAGE}"
}

unpack_bsp() {
    tar -C "${WORKDIR}" -xpf "${DL_DIR}/${L4T_RELEASE_PACKAGE}"
    sudo tar -C "${ROOTFS_DIR}" -xpf "${DL_DIR}/${SAMPLE_FS_PACKAGE}"
}

init() {
    cd "${L4T_SRC_DIR}" && ./source_sync.sh -t "jetson_${VERSION_MAJOR}.${VERSION_MINOR}"
    cd "${L4T_DIR}"
    sudo ./tools/l4t_flash_prerequisites.sh
    sudo ./apply_binaries.sh
}

unpack_toolchain() {
    tar -xpf "${DL_DIR}/${TOOLS_PACKAGE}" -C "${WORKDIR}"
}

customize() {
    chmod +x ${COMPULAB_DIR}/scripts/customize.sh
    ${COMPULAB_DIR}/scripts/customize.sh
}

make_kernel() {
    cd "${L4T_SRC_DIR}"
    make -C kernel -j"$(nproc)" -s
    make -j"$(nproc)" modules -s
    make -j"$(nproc)" dtbs -s
}

install() {
    sudo mkdir -p "${ROOTFS_DIR}/boot" "${ROOTFS_DIR}/lib"
    cd "${L4T_SRC_DIR}"
    export INSTALL_MOD_PATH=${ROOTFS_DIR}
    sudo -E make -C kernel install -s -j`nproc`
    sudo -E make modules_install -s -j`nproc`
    sudo cp -a kernel-devicetree/generic-dts/dtbs/* "${L4T_DIR}/kernel/dtb/"
}

clean() {
    sudo rm -rf "${L4T_DIR}"
}

all() {
    download
    unpack_bsp
    init
    unpack_toolchain
    customize
    make_kernel
    install
}

# === Entry Point ===
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <target>"
    echo "Targets: all download unpack_bsp init unpack_toolchain customize make_kernel install clean"
    exit 1
fi

"$@"
