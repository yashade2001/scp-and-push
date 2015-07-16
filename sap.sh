#!/bin/bash
set -e

SERVER_USERNAME="yashar"
SERVER_HOSTNAME="example.org"
SERVER_PORT="22"
ROM_SOURCE="~/aosp/"
SYSTEMUI_OUT=$ROM_SOURCE"out/target/product/hammerhead/system/priv-app/SystemUI/SystemUI.apk"
SETTINGS_OUT=$ROM_SOURCE"out/target/product/hammerhead/system/priv-app/Settings/Settings.apk"
SETTINGSPROVIDER_OUT=$ROM_SOURCE"out/target/product/hammerhead/system/priv-app/SettingsProvider/SettingsProvider.apk"
FRAMEWORK_OUT=$ROM_SOURCE"out/target/product/hammerhead/system/framework/framework.jar"
FRAMEWORKRES_OUT=$ROM_SOURCE"out/target/product/hammerhead/system/framework/framework-res.apk"
OUT_FILES_DIR="outfiles"

rm -rf /home/$USER/$OUT_FILES_DIR
mkdir /home/$USER/$OUT_FILES_DIR

scp -P $SERVER_PORT $SERVER_USERNAME@$SERVER_HOSTNAME:"$SYSTEMUI_OUT $SETTINGS_OUT $SETTINGSPROVIDER_OUT $FRAMEWORK_OUT $FRAMEWORKRES_OUT" /home/$USER/$OUT_FILES_DIR

adb start-server
adb remount

adb push /home/$USER/$OUT_FILES_DIR/SystemUI.apk /system/priv-app/SystemUI/SystemUI.apk
adb shell chmod 0644 /system/priv-app/SystemUI/SystemUI.apk
sleep 2

adb push /home/$USER/$OUT_FILES_DIR/Settings.apk /system/priv-app/Settings/Settings.apk
adb shell chmod 0644 /system/priv-app/Settings/Settings.apk
sleep 2

adb push /home/$USER/$OUT_FILES_DIR/framework-res.apk /system/framework/framework-res.apk
adb shell chmod 0644 /system/framework/framework-res.apk
sleep 2
adb push /home/$USER/$OUT_FILES_DIR/framework.jar /system/framework/framework.jar
adb shell chmod 0644 /system/framework/framework.jar
sleep 2

adb push /home/$USER/$OUT_FILES_DIR/SettingsProvider.apk /system/priv-app/SettingsProvider/SettingsProvider.apk
adb shell chmod 0644 /system/priv-app/SettingsProvider/SettingsProvider.apk
sleep 2

adb reboot
