#!/bin/bash
# operation string and platform string
OPS=$1
PLAT=$2

ops_array=("debugserver" "test")
plat_array=("qemu_max_smp")

ops_found=false
for i in "${ops_array[@]}"
do
    if [ "$1" = "$i" ]; then
        ops_found=true
        break
    fi
done

if [ "$ops_found" = false ]; then
    echo "Invalid operation. Please use one of the following:"
    for index in "${!ops_array[@]}"; do
        echo "Argument $(($index+1)): ${ops_array[$index]}"
    done
    echo "For example: ./auto_zvm.sh ${ops_array[0]} ${plat_array[0]}"
    exit 1
fi

plat_found=false
for i in "${plat_array[@]}"
do
    if [ "$2" = "$i" ]; then
        plat_found=true
        break
    fi
done

# test system
if [ "$OPS" = "${ops_array[1]}" ]; then
    qemu-system-aarch64 -cpu max -m 4G -nographic -machine virt,virtualization=on,gic-version=3 \
    -net none -pidfile qemu.pid -chardev stdio,id=con,mux=on \
    -serial chardev:con -mon chardev=con,mode=readline -smp cpus=4 \
    -device loader,file=/home/proctor-a/xiong/zephyrproject/zephyr/build/zephyr/zephyr.bin,addr=0xe0000000,force-raw=on \
    -device loader,file=./linux/Image_withFS,addr=0xe4000000,force-raw=on \
    -device loader,file=./linux/linux-qemu-virt.dtb,addr=0xec000000 \
    -kernel ./zvm_host_test.elf
fi

if [ "$plat_found" = false ]; then
    echo "Invalid platform. Please use one of the following:"
    for index in "${!plat_array[@]}"; do
        echo "Argument $(($index+1)): ${plat_array[$index]}"
    done
    echo "For example: ./auto_zvm.sh ${ops_array[0]} ${plat_array[0]}"
    exit 1
fi

# debug system
if [ "$OPS" = "${ops_array[0]}" ]; then
    if [ "$PLAT" = "${plat_array[0]}" ]; then
        qemu-system-aarch64 -cpu max -m 4G -nographic -machine virt,virtualization=on,gic-version=3 \
        -net none -pidfile qemu.pid -chardev stdio,id=con,mux=on \
        -serial chardev:con -mon chardev=con,mode=readline -smp cpus=4 \
        -device loader,file=/home/proctor-a/xiong/zephyrproject/zephyr/build/zephyr/zephyr.bin,addr=0xe0000000,force-raw=on \
        -device loader,file=./linux/Image_withFS,addr=0xe4000000,force-raw=on \
        -device loader,file=./linux/linux-qemu-virt.dtb,addr=0xec000000 \
        -kernel ./zvm_host.elf
### using gdb to connect it:
# gdb-multiarch -q -ex 'file ./build/zephyr/zvm_host.elf' -ex 'target remote localhost:1234'
    else
        echo "Error arguments for this auto.sh! \n Please input command like: ./z_auto.sh build qemu. "
    fi
fi
