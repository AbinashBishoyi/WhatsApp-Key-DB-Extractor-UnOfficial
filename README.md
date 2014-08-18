# Download

https://github.com/AbinashBishoyi/WhatsApp-Key-DB-Extractor/archive/master.zip

# WhatsApp Key/DB Extractor v2.2

The purpose of this script is to provide a method for WhatsApp users to extract their cipher key on NON-ROOTED
Android devices. The cipher key is required to decrypt WhatsApp CRYPT6 and CRYPT7 backup files. This script
works by hooking into the USB backup feature on Android 4.0 or higher. It will NOT work with earlier Android
versions or on devices where this feature has been deliberately disabled by the manufacturer. The cipher key
can be used with WhatCrypt (www.whatcrypt.com), both on the website (online decryption / exportation) and with
the Android App (offline decryption / recryption). Other apps and websites may also support WhatsApp cipher keys.
It should be noted that WhatsApp cipher keys can roll (update) periodically. If this happens then you will need
to repeat the instructions contained within this file in order to extract the latest cipher key. This script will
also extract the latest UNENCRYPTED WhatsApp Message Database (`msgstore.db`) and Contacts Database (`wa.db`).

In addition to the above. A copy of the cipher key will also be pushed to the WhatsApp Database directory on the
device itself and contained within a file called `.nomedia`. The reason for this is to allow Android Developers
a unified method in which they can offer their app users WhatsApp Decryption for those willing to run this script.


# Prerequisites

1. O/S: Windows Vista, Windows 7 or Windows 8, or Linux
2. Java (will start installation procedure if not already present on your system)
3. ADB (Android Debug Bridge) Drivers - If not installed: http://forum.xda-developers.com/showthread.php?t=2588979
4. USB Debugging must be enabled on the target device. Settings -> Developer Options -> (Debugging) USB debugging
   If you cannot find Developer Options then please go to: Settings -> About phone/device and tap the Build number
   multiple times until you're finally declared a developer.

# Windows Instructions

1. Extract `master.zip` on your computer maintaining the directory structure.
2. Browse to the extracted folder and click on `WhatsAppKeyExtract.bat`. If it is unable to find Java installation in your system, then it will start installation. Rerun the script again after Java installation.
3. Few have complained that the script keep on asking to install Java though Java is already installed, then you can click on `WhatsAppKeyExtractNoJavaCheck.bat`.
4. Connect your device via USB, unlock your screen and wait for "Full backup" to appear. (If you have never used USB Debugging before, you may also need to verify the fingerprint.)
5. Leave the password field blank and tap on "Back up my data".
6. The "extracted" folder will now contain your "whatsapp.key", "msgstore.db" and "wa.db".

# Linux/Mac OS X/Unix Instructions
 
1. Extract `master.zip` on your computer maintaining the directory structure.
2. Browse to the extracted folder and run `./WhatsAppKeyExtract.sh`
3. Wait for "Full backup" to appear on your phone. (If you have never used USB Debugging before, you may also need to verify the fingerprint.)
4. Leave the password field blank and tap on "Back up my data".
5. The key will be copied back onto your machine in such a way that WhatsApp TriCrypt will work.
6. The "extracted" folder will now contain your "whatsapp.key", "msgstore.db" and "wa.db".

# Install/Run TriCrypt

Get TriCrypt from here: https://play.google.com/store/apps/details?id=com.tricrypt

## Run TriCrypt
1. Click "Enable crypt6/7 (Root Required)" in TriCrypt. *After running the key fixes/scripts in this folder, root isn't actually required.*

### Auto Mode
1. Click "Service Running - Tap To Enable", this will run a background service that will run each 15 mins to detect the WhatsApp Backup DB, and will automatically do the Decrypt/Recrypt DB.
2. Sit back and enjoy.

### Manual Mode
1. Click "Decrypt WhatsApp Database".
2. Click "Recrypt WhatsApp Database".
3. (Optional) Click "Trigger SMS Backup+".

Make sure you have enable the "3rd party integration" from the Auto backup setting menu at SMS Backup+, so that TriCrypt can trigger it once it is done with Decrypt/Recrypt.

# Authors

* Author: Abinash Bishoyi
* Initial Work: TripCode
* THANKS: Nikolay Elenkov for ade.jar and Snoop05 for ADB Installer. David Fraser for scriptify Linux version. [Joel Purra](http://joelpurra.com/) for Mac OS X fixes, some script improvements.
