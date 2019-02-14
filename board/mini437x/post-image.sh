#!/bin/sh

BOARD_DIR="$(dirname $0)"

# copy the uEnv.txt to the output/images directory
mkdir -p $BINARIES_DIR/uEnv
cp board/mini437x/uEnv.txt $BINARIES_DIR/uEnv.txt
cp board/mini437x/uEnv_ramdisk.txt $BINARIES_DIR/uEnv_ramdisk.txt
cp board/mini437x/uEnv.txt $BINARIES_DIR/uEnv/uEnv.txt
cp board/mini437x/uEnv_ramdisk.txt $BINARIES_DIR/uEnv/uEnv_ramdisk.txt
mkimage -A arm -O linux -T ramdisk -C none -a 0x88080000 -n "ramdisk" -d $BINARIES_DIR/rootfs.cpio.gz $BINARIES_DIR/ramdisk.gz

GENIMAGE_CFG="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

rm -rf "${GENIMAGE_TMP}"

genimage \
    --rootpath "${TARGET_DIR}" \
    --tmppath "${GENIMAGE_TMP}" \
    --inputpath "${BINARIES_DIR}" \
    --outputpath "${BINARIES_DIR}" \
    --config "${GENIMAGE_CFG}"
