#!/usr/bin/env bash
##########################################################################
##                  WhatsApp Key/DB Extractor v2.2                       #
## This script will extract the WhatsApp Key file and DB on Android 4.0+ #
## You DO NOT need root for this to work, but you DO need Java installed #
## Base Script by: TripCode                                              #
## Thanks to: Nikolay Elenkov for abe.jar and David Fraser               #
## Updated By: Abinash Bishoyi (Added support for 4.4.X/L devices)       #
## Version: v2.2 (15th Aug 2014)                                         #
##########################################################################

# Using a subshell because the (old?) instructions used `source` as `. ./WhatsAppKeyExtract.sh`.
(
  # Exit on error
  set -e

  # Create a temporary directory based on the script name and a random pattern.
  TEMPORARY=$(mktemp -d "$(basename "${BASH_SOURCE}").XXXXXXXX")

  # Remove the temporary directory upon script exit (for any reason).
  trap 'rm -rf "$TEMPORARY"' EXIT

  whatsappFile="whatsapp.ab"
  whatsappNamespace="com.whatsapp"

  (
  	# Perform commands in the temporary directory.
    cd "$TEMPORARY"

    # Get backup file.
    [[ -f "$whatsappFile" ]] || adb backup -f "$whatsappFile" -noapk "$whatsappNamespace"

    # Uncompress, unpack backup file.
    dd if="$whatsappFile" bs=1 skip=24 | python -c "import zlib,sys;sys.stdout.write(zlib.decompress(sys.stdin.read()))" | tar x

    # Push the decryption key to the device.
    adb push "apps/$whatsappNamespace/f/key" "/sdcard/WhatsApp/Databases/.nomedia"
  )
)
