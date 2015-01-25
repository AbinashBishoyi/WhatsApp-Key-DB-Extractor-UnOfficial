@echo off
if exist "WhatsApp" (rmdir "WhatsApp" /s /q)
if exist WhatsApp_Patched.apk del /F WhatsApp_Patched.apk
if not exist WhatsApp.apk (
echo Downloading latest WhatsApp
bin\curl -o WhatsApp.apk http://www.whatsapp.com/android/current/WhatsApp.apk
)
echo I: Decompiling APK
java -jar bin\apktool.jar d WhatsApp.apk
echo I: Patching AndroidManifest.xml
bin\fart.exe -q WhatsApp\AndroidManifest.xml allowBackup=\"false allowBackup=\"true
echo I: Recompiling APK
java -jar bin\apktool.jar b WhatsApp
echo I: Signing APK
java -jar bin\signapk.jar crt\wa.pem crt\wa.pk8 WhatsApp\dist\WhatsApp.apk WhatsApp_Patched.apk
echo I: Patching Done!