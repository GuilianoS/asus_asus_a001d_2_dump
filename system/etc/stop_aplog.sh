#!/bin/sh

# Add by wangwq14 for stop aplog services.

# Let /vendor/bin/sh can use tools in '/system/bin'
export PATH=$PATH:/system/bin

umask 022

APLOG_DIR=/data/local/newlog/aplog

Log(){
    log -p d -t jltUI_aplog_STOP $1
}

Log "Start stop_aplog"

# If log service running, should stop them.

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

rm -f $APLOG_DIR/!(aplogsetting.enable)
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

wait
Log "clean anr, recovery, tombstones history files done"
Log "stop_aplog done"

