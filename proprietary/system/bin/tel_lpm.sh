#!/system/bin/sh
#/system/bin/logging.sh &
sleep 2
/system/bin/tel_launch_no_gui.sh

ret="$?"

case "$ret" in
            "-1")
		echo "Fail to load CP" > /dev/kmsg
       ;;
            "1")
		echo "AP only mode starts" > /dev/kmsg
       ;;
            "0")
		echo "CP load success" > /dev/kmsg
		sleep 5
		echo "CP sleep" > /dev/kmsg
		/system/bin/serial_cfun0 > /dev/kmsg
		sleep 2
       ;;
       *)
       ;;
esac

echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 312000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
cur_gov=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
cur_freq=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq`
echo "Current gov : $cur_gov" > /dev/kmsg
echo "Current freq : $cur_freq" > /dev/kmsg
sleep 5
# echo `ls -l /sys/class/graphics/fb0/` > /dev/kmsg
# echo `ls -l /sys/class/graphics/fb0/device/power/` > /dev/kmsg
echo "Turn off LCD" > /dev/kmsg
cur_lcd=`cat /sys/class/graphics/fb0/device/power/control`
echo "Current LCD : $cur_lcd" > /dev/kmsg
echo auto > /sys/class/graphics/fb0/device/power/control
cur_lcd=`cat /sys/class/graphics/fb0/device/power/control`
echo "After auto Current LCD : $cur_lcd" > /dev/kmsg
#echo 1 > /sys/class/graphics/fb0/blank
#echo auto > /sys/bus/platform/drivers/mmp-disp/mmp-disp/power/control
#echo auto > /sys/devices/platform/soc.2/d4000000.apb/pxa2xx-i2c.1/i2c-1/1-0020/input/input0/device/power/control 

