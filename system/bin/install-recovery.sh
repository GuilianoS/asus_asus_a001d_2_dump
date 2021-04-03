#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:22213932:8c4a351fa19365959707edbcaab93f8652b900a8; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:19012904:e8d0d04dbbe0d286c0168bb8260925109bbca296 EMMC:/dev/block/bootdevice/by-name/recovery 8c4a351fa19365959707edbcaab93f8652b900a8 22213932 e8d0d04dbbe0d286c0168bb8260925109bbca296:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
