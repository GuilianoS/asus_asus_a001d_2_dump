#!/bin/bash

cat system/app/Photos/Photos.apk.* 2>/dev/null >> system/app/Photos/Photos.apk
rm -f system/app/Photos/Photos.apk.* 2>/dev/null
cat system/app/YouTube/YouTube.apk.* 2>/dev/null >> system/app/YouTube/YouTube.apk
rm -f system/app/YouTube/YouTube.apk.* 2>/dev/null
cat system/app/Chrome/Chrome.apk.* 2>/dev/null >> system/app/Chrome/Chrome.apk
rm -f system/app/Chrome/Chrome.apk.* 2>/dev/null
cat system/app/LatinImeGoogle/LatinImeGoogle.apk.* 2>/dev/null >> system/app/LatinImeGoogle/LatinImeGoogle.apk
rm -f system/app/LatinImeGoogle/LatinImeGoogle.apk.* 2>/dev/null
cat system/priv-app/GmsCore/GmsCore.apk.* 2>/dev/null >> system/priv-app/GmsCore/GmsCore.apk
rm -f system/priv-app/GmsCore/GmsCore.apk.* 2>/dev/null
cat system/priv-app/Settings/Settings.apk.* 2>/dev/null >> system/priv-app/Settings/Settings.apk
rm -f system/priv-app/Settings/Settings.apk.* 2>/dev/null
cat system/priv-app/Velvet/Velvet.apk.* 2>/dev/null >> system/priv-app/Velvet/Velvet.apk
rm -f system/priv-app/Velvet/Velvet.apk.* 2>/dev/null
