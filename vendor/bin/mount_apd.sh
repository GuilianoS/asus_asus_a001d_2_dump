#!/system/bin/sh
# This service is for ASUS Product Demo
# mount -t ext4 /dev/block/by-name/APD /APD
# We chown/chmod ADF/ADF again so because mount is run as root + defaults
mount -t vfat -o shortname=lower,uid=1000,gid=1000,dmask=0002,fmask=0002 /dev/block/bootdevice/by-name/APD /APD
chown -R system:system /APD
chmod -R 0775 /APD
chown -R system:system /ADF
chmod -R 0775 /ADF
