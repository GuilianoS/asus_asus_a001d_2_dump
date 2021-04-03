#!/bin/sh
export PATH=$PATH:/system/bin
Log(){
    log -p d -t jltUI_aplog_TAR $1
}

setprop sys.asus.tarlog.complete 0

mkdir -p /sdcard/ontimlog
Log "make tar package start"
FILENAME=curlog_$(date +%Y_%m_%d_%H_%M_%S)
tar zcf /sdcard/ontimlog/${FILENAME}.tgz -C /sdcard/ASUS/LogUploader/ .
wait
Log "make tar package done ___ tar package is ${FILENAME}.tgz"

setprop sys.asus.tarlog.complete 1

Log "tar log finished ... now clean log and restart log-service"
setprop sys.asus.savelogs.complete 1
setprop sys.asus.savelogs.local 0
#add proprety
