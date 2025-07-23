VERSION_MAJOR=36
VERSION_MINOR=4.4
RELEASE="r${VERSION_MAJOR}.${VERSION_MINOR}"
RELEASE_URL="https://developer.nvidia.com/downloads/embedded/l4t/r${VERSION_MAJOR}_release_v${VERSION_MINOR}/release"
TOOLS_URL="https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v3.0/toolchain"

export COMPULAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKDIR="${COMPULAB_DIR}/.."
DL_DIR="${WORKDIR}/downloads"
export L4T_DIR="${WORKDIR}/Linux_for_Tegra"
export L4T_SRC_DIR="${L4T_DIR}/source"
ROOTFS_DIR="${L4T_DIR}/rootfs"

L4T_RELEASE_PACKAGE="Jetson_Linux_${RELEASE}_aarch64.tbz2"
SAMPLE_FS_PACKAGE="Tegra_Linux_Sample-Root-Filesystem_${RELEASE}_aarch64.tbz2"
TOOLS_PACKAGE="aarch64--glibc--stable-2022.08-1.tar.bz2"
CROSS_COMPILE="${WORKDIR}/aarch64--glibc--stable-2022.08-1/bin/aarch64-buildroot-linux-gnu-"

export CROSS_COMPILE="${CROSS_COMPILE}"
export ARCH="arm64"
export KERNEL_HEADERS="${L4T_SRC_DIR}/kernel/kernel-jammy-src"
