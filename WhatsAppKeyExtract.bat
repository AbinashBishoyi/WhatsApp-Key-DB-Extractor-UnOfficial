@echo off
color 1b
title WhatsApp Key/DB Extractor v2
echo =========================================================================
echo = This script will extract the WhatsApp Key file and DB on Android 4.0+ =
echo = You DO NOT need root for this to work, but you DO need Java installed =
echo = Base Script by: TripCode                                              =
echo = Thanks to: Nikolay Elenkov for abe.jar / David Fraser                 =
echo = Updated By: Abinash Bishoyi (Added support for 4.4.3 devices)         =
echo = Version: v2.0 (19th Jun 2014)                                         =
echo =========================================================================
echo.
for /f %%j in ("java.exe") do (
set JAVA_HOME=%%~dp$PATH:j
)
if %JAVA_HOME%.==. (
echo Please install Java first and then re-run this bat script.
@start bin\jxpiinstall.exe
echo.
echo Exiting ...
timeout /t 5
exit
) else (
echo Please connect your Android device with USB Debugging enabled:
echo.
)
bin\adb.exe wait-for-device
bin\adb.exe backup -f tmp\whatsapp.ab -noapk com.whatsapp
if exist tmp\whatsapp.ab (
echo.
java -jar bin\abe.jar unpack tmp\whatsapp.ab tmp\whatsapp.tar
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
) else (
echo Operation Failed!
)
timeout /t 15
