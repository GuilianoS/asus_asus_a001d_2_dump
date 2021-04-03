#!/bin/sh

#MODEM_LOG
MODEM_LOG=/data/media/0/ASUS/LogUploader/modem
#TCP_DUMP_LOG
TCP_DUMP_LOG=/data/media/0/ASUS/LogUploader/TCPdump
#GENERAL_LOG
GENERAL_LOG=/data/media/0/ASUS/LogUploader/general/sdcard
#LOG_PATH
LOG_PATH=/data/media/0/ASUS/LogUploader

#Dumpsys folder
DUMPSYS_DIR=/data/media/0/ASUS/LogUploader/dumpsys

#BUSYBOX=busybox

Log(){
    log -p d -t jltUI_asus_savelog $1
}

savelogs_prop=`getprop persist.asus.savelogs`
savelogs_local_prop=`getprop sys.asus.savelogs.local`


Log "savelogs  start  "

save_general_log() {
	Log "save_general_log start ... "
        cp -r /sys/fs/pstore/ $GENERAL_LOG
	############################################################################################
	# save cmdline
	cat /proc/cmdline > $GENERAL_LOG/cmdline.txt
	echo "cat /proc/cmdline > $GENERAL_LOG/cmdline.txt"
	############################################################################################
	# save mount table
	cat /proc/mounts > $GENERAL_LOG/mounts.txt
	echo "cat /proc/mounts > $GENERAL_LOG/mounts.txt"
	############################################################################################
	getenforce > $GENERAL_LOG/getenforce.txt
	echo "getenforce > $GENERAL_LOG/getenforce.txt"
	############################################################################################
	# save property
	getprop > $GENERAL_LOG/getprop.txt
	echo "getprop > $GENERAL_LOG/getprop.txt"
	############################################################################################
	# save network info
	cat /proc/net/route > $GENERAL_LOG/route.txt
	echo "cat /proc/net/route > $GENERAL_LOG/route.txt"
	############################################################################################
	# save software version
	echo "AP_VER: `getprop ro.build.display.id`" > $GENERAL_LOG/version.txt
	echo "CP_VER: `getprop gsm.version.baseband`" >> $GENERAL_LOG/version.txt
	echo "BT_VER: `getprop bt.version.driver`" >> $GENERAL_LOG/version.txt
	echo "WIFI_VER: `getprop wifi.version.driver`" >> $GENERAL_LOG/version.txt
	echo "GPS_VER: `getprop gps.version.driver`" >> $GENERAL_LOG/version.txt
	echo "BUILD_DATE: `getprop ro.build.date`" >> $GENERAL_LOG/version.txt
	############################################################################################
	# save load kernel modules
	lsmod > $GENERAL_LOG/lsmod.txt
	echo "lsmod > $GENERAL_LOG/lsmod.txt"
	############################################################################################
	# save process now
	setprop sys.asus.savelogs.ps $GENERAL_LOG
	############################################################################################
	# save kernel message
	dmesg > $GENERAL_LOG/dmesg.txt
	echo "dmesg > $GENERAL_LOG/dmesg.txt"
	############################################################################################
	# copy data/tombstones to data/media
	ls -R -l /data/tombstones/ > $GENERAL_LOG/ls_data_tombstones.txt
	mkdir $GENERAL_LOG/tombstones
	cp /data/tombstones/* $GENERAL_LOG/tombstones/
	echo "cp /data/tombstones $GENERAL_LOG"
	############################################################################################
	# copy Debug Ion information to data/media
	mkdir $GENERAL_LOG/ION_Debug
	#cp -r /d/ion/* $GENERAL_LOG/ION_Debug/
	############################################################################################
	mkdir $GENERAL_LOG/logcat_log
	#stop services
	#clear buffer then start services
	echo "mv general log to the logcat_log file"
	setprop ctl.stop mainlog_big
	setprop ctl.stop radiolog_big
	setprop ctl.stop eventslog_big
	setprop ctl.stop kernellog
	mv /data/local/newlog/aplog/logcats/* $GENERAL_LOG/logcat_log/

	Log "save log asus_ontim logcats start"

	if [ -d "/data/media/0/ASUS/LogUploader/general/sdcard/" ]; then
		echo "save log asus_ontim logcats 1"
	    for x in /data/media/0/ASUS/LogUploader/general/sdcard/logcat_log/*
	    do

	echo "save log asus_ontim logcats 2 $x"
		mv $x $x"_"$(date +%Y-%m-%d__%H-%M-%S).log
	    done
	fi
	############################################################################################
	ls -R -l /data/misc/wifi/ > $GENERAL_LOG/ls_wifi_asus_log.txt
	cp -r /data/misc/wifi/wpa_supplicant.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/wpa_supplicant.conf $GENERAL_LOG"
	cp -r /data/misc/wifi/hostapd.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/hostapd.conf $GENERAL_LOG"
	cp -r /data/misc/wifi/p2p_supplicant.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/p2p_supplicant.conf $GENERAL_LOG"
	############################################################################################
	# mv /data/anr to data/media
	ls -R -l /data/anr > $GENERAL_LOG/ls_data_anr.txt
	mkdir $GENERAL_LOG/anr
	cp /data/anr/* $GENERAL_LOG/anr/
	echo "cp /data/anr $GENERAL_LOG"
        rm -rf /data/anr/*
	############################################################################################
        date > $GENERAL_LOG/date.txt
	echo "date > $GENERAL_LOG/date.txt"
            micropTest=`cat /sys/class/switch/pfs_pad_ec/state`
	if [ "${micropTest}" = "1" ]; then
	    date > $GENERAL_LOG/microp_dump.txt
	    cat /d/gpio >> $GENERAL_LOG/microp_dump.txt
        echo "cat /d/gpio > $GENERAL_LOG/microp_dump.txt"
        cat /d/microp >> $GENERAL_LOG/microp_dump.txt
        echo "cat /d/microp > $GENERAL_LOG/microp_dump.txt"
	fi
	############################################################################################
	df > $GENERAL_LOG/df.txt
	echo "df > $GENERAL_LOG/df.txt"

        #lsof > $GENERAL_LOG/lsof.txt

        mkdir $GENERAL_LOG/ap_ramdump
        mv /data/media/ap_ramdump/* $GENERAL_LOG/ap_ramdump/

        mkdir $GENERAL_LOG/recovery
        cp -r /cache/recovery/* $GENERAL_LOG/recovery/
	Log "save_general_log end ... "
}

save_modem_log() {
	setprop ctl.stop modemlog

	Log "save_modem_log start"
	#/data/media/0/ASUS/LogUploader/modem
	mv /sdcard/mdlog/* $MODEM_LOG
	Log "save_modem_log end"
	echo "save_modem_log"
}

save_tcpdump_log() {
	setprop ctl.stop dumptcp
	Log "save_tcpdump_log start"
	#TCP_DUMP_LOG=/data/media/0/ASUS/LogUploader/TCPdump
	mv /data/local/newlog/aplog/tcps/* $TCP_DUMP_LOG
	Log "save_tcpdump_log end"
	echo "dump tcpdump log"
}

remove_folder() {
	# remove folder
	if [ -e $GENERAL_LOG ]; then
		rm -r $GENERAL_LOG
	fi

	if [ -e $MODEM_LOG ]; then
		rm -r $MODEM_LOG
	fi

	if [ -e $TCP_DUMP_LOG ]; then
		rm -r $TCP_DUMP_LOG
	fi

	if [ -e $DUMPSYS_DIR ]; then
		rm -r $DUMPSYS_DIR
	fi
}

create_folder() {
	# create folder
	mkdir -p $GENERAL_LOG
	echo "mkdir -p $GENERAL_LOG"

	mkdir -p $MODEM_LOG
	echo "mkdir -p $MODEM_LOG"

	mkdir -p $TCP_DUMP_LOG
	echo "mkdir -p $GENERAL_LOG"
}

stop_vendor_logcat() {
	# If log service running, should stop them.
	for svc in mainlog_big radiolog_big eventslog_big; do
	    eval ${svc}=$(getprop init.svc.${svc})
	    if eval [ "\$$svc" = "running" ]; then
		stop $svc
	    fi
	done
}

if [ ".$savelogs_local_prop" == ".5" ]; then
	# check mount file
	Log "savelogs_local start  "
	setprop sys.collectlog.state 0
	Log "savelogs_local start  setprop sys.collectlog.state 0 "
	mkdir /storage/emulated/0/ontimlog/
	chmod -R 777 /storage/emulated/0/ontimlog/
	umask 0;
	sync
	############################################################################################
	# remove folder
	Log "savelogs_local remove_folder"
	remove_folder

	# create folder
	Log "savelogs_local create_folder"
	create_folder

	# save_general_log
	Log "savelogs_local save_general_log"
	save_general_log

	# save_modem_log
	Log "savelogs_local save_modem_log"
	save_modem_log

	# save_tcpdump_log
	Log "savelogs_local save_tcpdump_log"
	save_tcpdump_log

	############################################################################################
	# sync data to disk
	# 1015 sdcard_rw

	chmod -R 777 $LOG_PATH

	#tar all log local
	Log "savelogs_local start  setprop sys.collectlog.state 1 "
        setprop sys.collectlog.state 1
	Log "savelogs_local start Finished ..... "

elif [ ".$savelogs_prop" == ".0" ]; then
	remove_folder
	Log "savelogs_prop finished 0 "

elif [ ".$savelogs_prop" == ".1" ]; then
	# check mount file
	umask 0;
	sync
	############################################################################################
	# remove folder
	remove_folder

	# create folder
	create_folder

	# save_general_log
	save_general_log

	############################################################################################
	# sync data to disk
	# 1015 sdcard_rw
	chmod -R 777 $LOG_PATH
	sync

	setprop sys.asus.savelogs.complete 1
  setprop sys.asus.savelogs.dumpstate 1

	Log "savelogs_prop finished 1 "
	echo "Done"
elif [ ".$savelogs_prop" == ".2" ]; then
	# check mount file
	umask 0;
	sync
	############################################################################################
	# remove folder
	remove_folder

	# create folder
	create_folder

	save_modem_log
  save_general_log
	############################################################################################
	# sync data to disk
	# 1015 sdcard_rw
	chmod -R 777 $LOG_PATH
	sync

	setprop sys.asus.savelogs.complete 1
	Log "savelogs_prop finished 2 "
	echo "Done"
elif [ ".$savelogs_prop" == ".3" ]; then
	# check mount file
	umask 0;
	sync
	############################################################################################
	# remove folder
	remove_folder

	# create folder
	create_folder

  save_general_log
	save_tcpdump_log
	############################################################################################
	# sync data to disk
	# 1015 sdcard_rw
	chmod -R 777 $LOG_PATH
	sync

	setprop sys.asus.savelogs.complete 1
	Log "savelogs_prop finished 3 "
	echo "Done"
elif [ ".$savelogs_prop" == ".4" ]; then
	# check mount file
	umask 0;
	sync
	############################################################################################
	# remove folder
	remove_folder

	# create folder
	create_folder

	# save_general_log
	save_general_log

	# save_modem_log
	save_modem_log

	# save_tcpdump_log
	save_tcpdump_log

	############################################################################################
	# sync data to disk
	# 1015 sdcard_rw
  setprop sys.asus.savelogs.dumpstate 1
	chmod -R 777 $LOG_PATH

	setprop sys.asus.savelogs.complete 1
	Log "savelogs_prop finished 4 "

fi
