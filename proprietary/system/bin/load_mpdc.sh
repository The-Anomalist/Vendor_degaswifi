#! /system/bin/sh

# try to load drivers
unload_mpdc.sh

# try to load drivers
echo "Loading Marvell Code Performance Analyzer Drivers ..."

PWD=`pwd`

PARAM_KALLSYMS_LOOKUP_NAME_ADDR=0

PARAM_KALLSYMS_LOOKUP_NAME_ADDR=`/system/bin/pxksymaddr kallsyms_lookup_name`

cd ${PWD}

DRVS="mpdc_cm.ko mpdc_hs.ko mpdc_css.ko mpdc_tp.ko"

ret=0

for drv in $DRVS; do
	insmod /lib/modules/$drv param_kallsyms_lookup_name_addr=${PARAM_KALLSYMS_LOOKUP_NAME_ADDR}
	
	case "$?" in
		0) 
		;;
		*) ret=$?
		;;
	esac
done

case $ret in
	0) echo "Succeeded to load the drivers!"
	;;
	*) echo "Failed to load the drivers!"
	;;
esac

exit $ret
