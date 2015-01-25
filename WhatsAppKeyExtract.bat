@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
color 1b
title WhatsApp Key/DB Extractor v3
echo =========================================================================
echo = This script will extract the WhatsApp Key file and DB on Android 4.0+ =
echo = You DO NOT need root for this to work, but you DO need Java installed =
echo = Base Script by: TripCode                                              =
echo = Thanks to: Nikolay Elenkov for abe.jar                                =
echo = Thanks to: David Fraser, Joel Purra                                   =
echo = Updated By: Abinash Bishoyi (Added support for 4.4.X/L devices)       =
echo = Version: v3 (26th Jan 2015)                                           =
echo =========================================================================
echo.

call FindJava.bat
if "!JAVA_HOME!" == "" (
echo Please install Java first and then re-run this bat script.
@start bin\jxpiinstall.exe
echo.
echo Exiting ...
timeout /t 5
exit
) else (
set "JAVA=!JAVA_HOME!\bin\java.exe"
"!JAVA!" -version
call ADBPatchV2.bat
echo.
echo Please connect your Android device with USB Debugging enabled:
echo.
)
bin\adb.exe wait-for-device
if exist WhatsApp_Patched.apk (bin/adb.exe install WhatsApp_Patched.apk)
bin\adb.exe backup -f tmp\whatsapp.ab -noapk com.whatsapp
if exist tmp\whatsapp.ab (
echo.
"%JAVA%" -jar bin\abe.jar unpack tmp\whatsapp.ab tmp\whatsapp.tar
bin\tar xvf tmp\whatsapp.tar -C tmp\ apps/com.whatsapp/f/key
bin\tar xvf tmp\whatsapp.tar -C tmp\ apps/com.whatsapp/db/msgstore.db
bin\tar xvf tmp\whatsapp.tar -C tmp\ apps/com.whatsapp/db/wa.db
echo.
echo Extracting whatsapp.key ...
xcopy tmp\apps\com.whatsapp\f\key extracted\whatsapp.key\
echo.
echo Extracting msgstore.db ...
copy tmp\apps\com.whatsapp\db\msgstore.db extracted\msgstore.db
echo.
echo Extracting wa.db ...
copy tmp\apps\com.whatsapp\db\wa.db extracted\wa.db
echo.
echo Pushing cipher key to: /sdcard/WhatsApp/Databases/.nomedia
bin\adb.exe push tmp\apps\com.whatsapp\f\key /sdcard/WhatsApp/Databases/.nomedia
echo.
echo Cleaning up temporary files ...
echo.
del tmp\whatsapp.ab /s /q
del tmp\whatsapp.tar /s /q
rmdir tmp\apps /s /q
echo.
echo Done!
echo Consider a Paypal donation to abinashbishoyi@gmail.com
) else (
echo Operation Failed!
)
pause
