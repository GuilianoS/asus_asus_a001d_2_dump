#!/bin/sh

# Add by wangwq14 for Clean aplogs

# Let /vendor/bin/sh can use tools in '/system/bin'
savelogs_prop=`getprop persist.asus.savelogs.source`
open_main_prop=`getprop persist.asus.open.log.main`
open_events_prop=`getprop persist.asus.open.log.events`
open_radio_prop=`getprop persist.asus.open.log.radio`
open_kernel_prop=`getprop persist.asus.open.log.kernel`
open_modem_prop=`getprop persist.asus.open.log.modem`
open_tcp_prop=`getprop persist.asus.open.log.tcp`
export PATH=$PATH:/system/bin

umask 022

APLOG_DIR=/data/local/newlog/aplog

Log(){
    log -p d -t jltUI_aplog_CLEAN $1
}
set_log_state(){
	Log "aplogsh set_log_state"
	#mainlog_big log switch
	if [ ".$open_main_prop" == ".1" ]; then
		Log "aplogsh open mainlog_big log"
		setprop ctl.start mainlog_big

	elif [ ".$open_main_prop" == ".0" ]; then
		Log "aplogsh stop mainlog_big log"
		setprop ctl.stop mainlog_big
	fi

	#eventslog_big log switch
	if [ ".$open_events_prop" == ".1" ]; then
		Log "aplogsh open eventslog_big log"
		setprop ctl.start eventslog_big

	elif [ ".$open_events_prop" == ".0" ]; then
		Log "aplogsh stop eventslog_big log"
		setprop ctl.stop eventslog_big
	fi


	#radiolog_big log switch
	if [ ".$open_radio_prop" == ".1" ]; then
		Log "aplogsh open radiolog_big log"
		setprop ctl.start radiolog_big

	elif [ ".$open_radio_prop" == ".0" ]; then
		Log "aplogsh stop radiolog_big log"
		setprop ctl.stop radiolog_big
	fi


	#kernellog log switch
	if [ ".$open_kernel_prop" == ".1" ]; then
		Log "aplogsh open kernellog log"
		setprop ctl.start kernellog

	elif [ ".$open_kernel_prop" == ".0" ]; then
		Log "aplogsh stop kernellog log"
		setprop ctl.stop kernellog
	fi


	#modemlog log switch
	if [ ".$open_modem_prop" == ".1" ]; then
		Log "aplogsh open modemlog log"
		setprop ctl.start modemlog

	elif [ ".$open_modem_prop" == ".0" ]; then
		Log "aplogsh stop modemlog log"
		setprop ctl.stop modemlog
	fi


	#dumptcp log switch
	if [ ".$open_tcp_prop" == ".1" ]; then
		Log "aplogsh open dumptcp log"
		setprop ctl.start dumptcp

	elif [ ".$open_tcp_prop" == ".0" ]; then
		Log "aplogsh stop dumptcp log"
		setprop ctl.stop dumptcp
	fi

}

Log "Start clean_aplog ======"

setprop ctl.stop mainlog_big
setprop ctl.stop radiolog_big
setprop ctl.stop eventslog_big
setprop ctl.stop kernellog
setprop ctl.stop modemlog
setprop ctl.stop dumptcp

# wait for stop services done.
wait
Log "Stop log services done"

# remove history log.
rm -rf $APLOG_DIR/tombstones/*
rm -rf $APLOG_DIR/bluetooth/*
rm -rf $APLOG_DIR/anr/*
rm -rf $APLOG_DIR/gps/*
rm -rf $APLOG_DIR/recovery/*
rm -rf $APLOG_DIR/wlan/*
rm -rf $APLOG_DIR/tcps/*
rm -rf $APLOG_DIR/logcats/*
rm -rf $APLOG_DIR/dumpsys/*
rm -rf /sdcard/log/mdlog/*

# remove files except '*.enable'
rm -f $APLOG_DIR/!(*.enable)
Log "Remove history logs done"

# clean logcat system buffer
vendor_logcat -c
vendor_logcat -b radio -c
vendor_logcat -b events -c
Log "clean logcat buffer done"


#clean anr, recovery, tombstones history files
#rm -f /cache/recovery/*
rm -f /data/anr/*
rm -f /data/tombstones/*
rm -rf /data/tombstones/dsps/*
rm -rf /data/tombstones/lpass/*
rm -rf /data/tombstones/modem/*
rm -rf /data/tombstones/wcnss/*
Log "clean anr, recovery, tombstones history files done"

set_log_state

# wait for start services done
wait
Log "Restart log services done"
Log "clean_aplog done ----------"

