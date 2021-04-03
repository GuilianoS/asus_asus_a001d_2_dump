#!vendor/bin/sh

vendor/bin/climax -l /vendor/firmware/mono.cnt -d sysfs --resetMtpEx

check_results=`vendor/bin/climax -l /vendor/firmware/mono.cnt -d sysfs --calibrate=once | grep 'Calibration value'`

echo $check_results

setprop sys.climax_calib.val "$check_results"
