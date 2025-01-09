Supported Platforms
==============================
- qemu-max

1. qemu-system-aarch64 Precompiled QEMU Binary
------------------------------------------------------

Two additional serial ports are added to display the terminal of the VM console. For details, see the README.rst file in the qemu directory.

2. Virtual Machine Image Running on qemu-max Platform
------------------------------------------------------

Linux
~~~~~~~~~~~~~~~~~~~~~~~~~

Running a Linux virtual machine usually requires three files: the kernel, the device tree, and the file system. The kernel is the Image, the device tree is the dtb file, and the file system is the FS.
There are two types of kernels in this repository: one with the file system compiled into the kernel, and the other with the file system loaded separately. The kernel with the file system compiled in only requires loading the Image and the dtb file, while the kernel with the file system loaded separately requires loading the file system additionally.
The differences between the two types of kernels are as follows:

- Image_withFS: The file system is compiled into the kernel, with the suffix 'withFS'.
- Image_withoutFS: The file system is not compiled into the kernel and needs to be loaded separately, with the suffix 'withoutFS'.

For the device tree, the main device tree file is:

- linux-qemu-virt.dtb: dtb file with:
    - uart

The file system compiled into the kernel is a minimal file system compiled with busybox. The separately loaded file system is a Debian file system. Detailed descriptions can be found in the README.rst file in the debian directory.

Zephyr
~~~~~~~~~~~~~~~~~~~~~~~~~

- zephyr.bin: Zephyr image.

3. auto_zvm.sh Script
------------------------------------------------------

The script contains commands to run ZVM using the precompiled QEMU binary, including commands to load Linux and Zephyr images.

Place zvm_host.elf in the qemu_arm64 directory, then run the auto_zvm.sh script to start the ZVM hypervisor.

.. note::
    You can use zvm_host_test.elf instead of zvm_host.elf for early testing.