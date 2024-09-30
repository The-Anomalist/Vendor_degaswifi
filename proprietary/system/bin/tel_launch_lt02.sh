#!/system/bin/sh

#move NVM_ROOT_DIR to init.rc so other applications and services also use it.
#export  NVM_ROOT_DIR="/data/Linux/Marvell/NVM"

setprop marvell.ril.ppp.enabled 0
setprop log.tag.Mms:transaction V
setprop log.tag.Mms:app V
setprop log.tag.Mms:threadcache V
setprop android.telephony.apn-restore 600000
setprop sys.usb.diagmodem 1

setprop ro.marvell.platform.type TTC_TD

#copy default calibration xml to /NVM/ if dest not exist.
src_file="/etc/audio_swvol_calibration_def.xml"
dst_file="${NVM_ROOT_DIR}/audio_swvol_calibration.xml"

if [ -f "${dst_file}" ]; then
	echo "existing ${dst_file}";
else
	if [ -f "${src_file}" ]; then
		cp ${src_file} ${dst_file}
		chmod 666 ${dst_file}
		chown system.system ${dst_file}
		echo "cp: ${src_file} -> ${dst_file}"
	fi
fi

#backup log files
/system/bin/backup_log.sh

# $1 src file
# $2 dst file
function copy_if_not_exist()
{
if [ -f "${2}" ]; then
	echo "existing ${2}";
else
	if [ -f "${1}" ]; then
		cp ${1} ${2}
		chmod 666 ${2}
		chown system.system ${2}
		echo "cp: ${1} -> ${2}"
	fi
fi
}

rfcfg_src="kunlun/LyraConfig.nvm"
	rfcfg_dst="LyraConfig.nvm"
copy_if_not_exist "/etc/tel/${rfcfg_src}" "${NVM_ROOT_DIR}/${rfcfg_dst}"
chown system system $NVM_ROOT_DIR/$rfcfg_dst
chmod 0666 $NVM_ROOT_DIR/$rfcfg_dst

rfcfg_src="kunlun/TTPCom_NRAM2_ABMM_WRITEABLE_DATA.gki"
rfcfg_dst="TTPCom_NRAM2_ABMM_WRITEABLE_DATA.gki"
copy_if_not_exist "/etc/tel/${rfcfg_src}" "${NVM_ROOT_DIR}/${rfcfg_dst}"
chown system system $NVM_ROOT_DIR/$rfcfg_dst
chmod 0666 $NVM_ROOT_DIR/$rfcfg_dst

rfcfg_src="kunlun/COMCfg.csv"
rfcfg_dst="COMCfg.csv"
copy_if_not_exist "/etc/tel/${rfcfg_src}" "${NVM_ROOT_DIR}/${rfcfg_dst}"
chown system system $NVM_ROOT_DIR/$rfcfg_dst
chmod 0666 $NVM_ROOT_DIR/$rfcfg_dst

rfcfg_src="kunlun/RFPmaxReductionConfig.nvm"
rfcfg_dst="RFPmaxReductionConfig.nvm"
copy_if_not_exist "/etc/tel/${rfcfg_src}" "${NVM_ROOT_DIR}/${rfcfg_dst}"
chown system system $NVM_ROOT_DIR/$rfcfg_dst
chmod 0666 $NVM_ROOT_DIR/$rfcfg_dst
rfcfg_src="kunlun/DipChannelChange.nvm"
rfcfg_dst="DipChannelChange.nvm"
copy_if_not_exist "/etc/tel/${rfcfg_src}" "${NVM_ROOT_DIR}/${rfcfg_dst}"
chown system system $NVM_ROOT_DIR/$rfcfg_dst
chmod 0666 $NVM_ROOT_DIR/$rfcfg_dst
/system/bin/run_composite_lt02.sh;

