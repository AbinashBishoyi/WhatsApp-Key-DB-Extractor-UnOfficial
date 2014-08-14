#!/bin/bash
##########################################################################
##                  WhatsApp Key/DB Extractor v2.2                       #
## This script will extract the WhatsApp Key file and DB on Android 4.0+ #
## You DO NOT need root for this to work, but you DO need Java installed #
## Base Script by: TripCode                                              #
## Thanks to: Nikolay Elenkov for abe.jar and David Fraser               #
## Updated By: Abinash Bishoyi (Added support for 4.4.X/L devices)       #
## Version: v2.2 (15th Aug 2014)                                         #
##########################################################################
d="`mktemp -d`"
(
  cd "$d"
  [ -f whatsapp.ab ] || adb backup -f whatsapp.ab -noapk com.whatsapp
  dd if=whatsapp.ab bs=1 skip=24 | python -c "import zlib,sys;sys.stdout.write(zlib.decompress(sys.stdin.read()))" | tar x
  adb push apps/com.whatsapp/f/key /sdcard/WhatsApp/Databases/.nomedia
)
rm -r "$d"
