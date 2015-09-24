#!/system/bin/sh

mount -t ext2 /dev/block/sda3 /mnt/shared

cd /data/local/tmp
rm -rf ramdisk_patch
mkdir ramdisk_patch
cd ramdisk_patch
gunzip -c /mnt/shared/ramdisk | cpio -i

patch -p0 < /system/init.vbox86.rc.patch
#cat /system/init.vbox86.rc > init.vbox86.rc
cat /system/fstab.vbox86.patch >> fstab.vbox86

find . | cpio -o -H newc | gzip > ../ramdisk

cat /data/local/tmp/ramdisk > /mnt/shared/ramdisk

umount /mnt/shared

if [ ! -f /system/framework/framework-res.apk.orig ]; then
  mv /system/framework/framework-res.apk /system/framework/framework-res.apk.orig
fi
cp /system/framework-res.apk /system/framework/framework-res.apk

echo -e "n\np\n1\n\n\nt\nc\nw" | fdisk /dev/block/sdc
mkfs.vfat  /dev/block/sdc1

