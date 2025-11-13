# Prerequisites
A Ubuntu 22.04 host machine.

You have installed Git. You can install it with the following command:
```
sudo apt update
sudo apt install git
```

You have installed the Linux kernel build utilities. You can install them with the following command:
```
sudo apt install curl wget build-essential bc flex bison libssl-dev zstd
```

# Building
On the host run:
```
mkdir edge-ai
cd edge-ai
bash <(curl -fsSL https://raw.githubusercontent.com/compulab-yokneam/edge-ai-linux/devel/scripts/runme.sh)
```
# Flashing target
* Connect host to target's recovery USB port
* Connect nvme storage to the M.2 port
* Turn power on
* On the host, run:
```
cd Linux_for_Tegra
sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device nvme0n1p1 -c tools/kernel_flash/flash_l4t_t234_nvme.xml -p "-c bootloader/generic/cfg/flash_t234_qspi.xml" --showlogs --network usb0 edge-ai external
```
# For more information
https://docs.nvidia.com/jetson/archives/r36.4.4/DeveloperGuide/
