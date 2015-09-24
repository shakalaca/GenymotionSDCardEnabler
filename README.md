# GenymotionSDCardEnabler
Tools for enabling SD card in genymotion, replacing the emulated storage.

### Prerequisite
- [Apktool](http://ibotpeaches.github.io/Apktool/)
- Android 5.x image in genymotion

### Usage
- Execute install.sh with emulator running
- Restart emulator
- adb shell && cp -Rp /data/media/0/* /sdcard/

### What's in assets/extra ?
- For those who want both emulated storage and SD Card..

Reference: http://23pin.logdown.com/posts/301905-genymotion-enable-sd-card
