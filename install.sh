#!/bin/sh

# clean up
if [ -d _f ]; then
  rm -rf _f
fi

rm -f framework-res.apk.orig framework-res.apk

adb -e pull /system/framework/framework-res.apk.orig
adb -e pull /system/framework/framework-res.apk

# extract framework-res.apk
if [ -f framework-res.apk.orig ]; then
  apktool d framework-res.apk.orig -o _f
else
  apktool d framework-res.apk -o _f
fi

# set corresponded xml setting
cp assets/storage_list.xml _f/res/xml/storage_list.xml

# repack (copy original AndroidManifest.xml and META-INF)
apktool b -c _f

# push files to VM
adb -e remount
adb -e push assets/fstab.vbox86.patch /system
adb -e push assets/init.vbox86.rc.patch /system
adb -e push sdcard_patcher.sh /data/local/tmp
adb -e push _f/dist/framework-res.apk /system

# do the real change
adb -e shell "chmod 755 /data/local/tmp/sdcard_patcher.sh"
adb -e shell "/data/local/tmp/sdcard_patcher.sh"

# clean up
rm -f framework-res.apk.orig framework-res.apk
rm -rf _f

