#!/vendor/bin/sh
vendor=`cat /sys/class/mmc_host/mmc0/mmc0:0001/manfid`
emmc_rev=`cat /sys/class/mmc_host/mmc0/mmc0:0001/rev`
emmc_fw_version=`cat /sys/class/mmc_host/mmc0/mmc0:0001/fw_version`
emmc_sector=`cat /sys/class/mmc_host/mmc0/mmc0:0001/sec_count`
emmc_pre_eol=`cat /sys/class/mmc_host/mmc0/mmc0:0001/pre_eol_info`
emmc_life_time_A=`cat /sys/class/mmc_host/mmc0/mmc0:0001/life_time_A`
emmc_life_time_B=`cat /sys/class/mmc_host/mmc0/mmc0:0001/life_time_B`
setprop sys.emmc.emmc_health vendor:$emmc_vendor-rev:$emmc_rev-fw_version:$emmc_fw_version-sector:$emmc_sector-EOL:$emmc_pre_eol-life_A:$emmc_life_time_A-life_B:$emmc_life_time_B
setprop asus.storage.primary.health $emmc_pre_eol
