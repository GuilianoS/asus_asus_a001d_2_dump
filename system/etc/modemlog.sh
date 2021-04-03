#!/bin/sh

umask 022
export PS4='+{$LINENO:${FUNCNAME[0]}} '
set -x
Log(){
    log -p d -t modemlog $1
}

# User can config modem log by file "/sdcard/log_cfg/cs.cfg"
# System default config file is "/vendor/etc/cs.cfg".
if [ -e /sdcard/log_cfg/cs.cfg ]; then
    setprop "persist.sys.ontim.log.qxdmcfg" "/sdcard/log_cfg/cs.cfg"
    Log "setprop persist.sys.ontim.log.qxdmcfg to /sdcard/log_cfg/cs.cfg"
else
    setprop "persist.sys.ontim.log.qxdmcfg" "/system/etc/cs.cfg"
    Log "setprop persist.sys.ontim.log.qxdmcfg to /system/etc/cs.cfg"
fi

mkdir -p /sdcard/mdlog

setprop "persist.sys.ontim.modemlog.path" "/sdcard/mdlog"
Log "setprop persist.sys.ontim.modemlog.path to /sdcard/mdlog"

CFGFILE=$(getprop persist.sys.ontim.log.qxdmcfg)
LOGFILE=$(getprop persist.sys.ontim.modemlog.path)

Log "start diag_mdlog"
Log "CFGFILE=$CFGFILE"
Log "LOGFILE=$LOGFILE"

#kill the diag_mdlog process at first
/system/bin/diag_mdlog_system -k -c
# -s set the single log size in MB
/system/bin/diag_mdlog_system -s 100 -n 20 -f $CFGFILE -o $LOGFILE

# scripty will hold in the last line, should never come here.
Log "start diag_mdlog done, exit scripty"

export PS4='+{$LINENO:${FUNCNAME[0]}} '
set +x
