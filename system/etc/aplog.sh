#!/bin/sh
savelogs_prop=`getprop persist.asus.savelogs.source`
open_main_prop=`getprop persist.asus.open.log.main`
open_events_prop=`getprop persist.asus.open.log.events`
open_radio_prop=`getprop persist.asus.open.log.radio`
open_kernel_prop=`getprop persist.asus.open.log.kernel`
open_modem_prop=`getprop persist.asus.open.log.modem`
open_tcp_prop=`getprop persist.asus.open.log.tcp`

Log(){
    log -p d -t jltUI_aplog_START $1
}

setprop persist.sys.aplogfiles  1000

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


#close all logs
if [ ".$savelogs_prop" == ".0" ]; then
	Log "aplogsh close all logs and clean all file"	
	setprop ctl.start stopaplog
elif [ ".$savelogs_prop" == ".1" ]; then
	Log "start/adjust log service through checking the prop state ."
	set_log_state
elif [ ".$savelogs_prop" == ".2" ]; then
	Log "aplogsh only stop all logs"	
	setprop ctl.stop mainlog_big
	setprop ctl.stop radiolog_big
	setprop ctl.stop eventslog_big
	setprop ctl.stop kernellog
	setprop ctl.stop modemlog
	setprop ctl.stop dumptcp

fi

