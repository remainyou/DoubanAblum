#!/bin/sh
version=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $PRODUCT_SETTINGS_PATH`
version=`expr $version + 1`
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $version" $PRODUCT_SETTINGS_PATH

currentDate=`date +"%F %R"`
/usr/libexec/PlistBuddy -c "Set :CompileDate $currentDate" $PRODUCT_SETTINGS_PATH

