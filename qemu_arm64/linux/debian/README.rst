.. _loading_linux_image_and_rootfs_separately_on_qemu:

Loading Linux Image and Rootfs Separately on QEMU
=================================================

Files:
------

- **linux-qemu-virt.dtb**: Linux dtb file
- **xaa** & **xbb**: Debian filesystem

  The `debian.cpio.gz` file is divided into two parts: `xaa` and `xbb`.
  You should use `merge.sh` to merge them back together.

Usage:
------

To load the Linux image and rootfs separately on QEMU, follow these steps:

1. Ensure all required files are present: `Image_rfss`, `linux-qemu-virt.dtb`, `xaa`, and `xbb`.
2. Use the `merge.sh` script to combine `xaa` and `xbb` into the original `debian.cpio.gz`.
3. Note: When loading file system separately, use the dtb file in the debian directory because it specifies the filesystem loading address.
