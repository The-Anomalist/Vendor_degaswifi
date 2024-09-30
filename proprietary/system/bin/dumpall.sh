#!/system/bin/sh
if [ -e "/sdcard/dmesg" ]
then
    rm /sdcard/dmesg
fi
if [ -e "/sdcard/dumpstate" ]
then
    rm /sdcard/dumpstate
fi

dmesg > /sdcard/dmesg
dumpstate > /sdcard/dumpstate

