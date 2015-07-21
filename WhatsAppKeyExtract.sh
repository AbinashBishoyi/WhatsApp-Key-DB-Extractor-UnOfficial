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

  # Check that (some) dependencies are available on the path.
  [[ -z $(which adb) ]] && { echo "adb is required" 1>&2; exit 1; }
  [[ -z $(which python) ]] && { echo "python is required" 1>&2; exit 1; }

  # Create a temporary directory based on the script name and a random pattern.
  TEMPORARY=$(mktemp -d "$(basename "${BASH_SOURCE}").XXXXXXXX")
  mkdir -p tmp

  # Remove the temporary directory upon script exit (for any reason).
  trap 'rm -rf "$TEMPORARY"' EXIT

  outputDirectory="$PWD/extracted/"
  whatsappFile="whatsapp.ab"
  whatsappNamespace="com.whatsapp"
  LegacyFile="$PWD/LegacyWhatsApp.apk"
  NewFile="$PWD/WhatsApp.apk"

  (
    [[ -f "WhatsApp.apk" ]] || curl -o WhatsApp.apk http://www.whatsapp.com/android/current/WhatsApp.apk

    echo "Installing legacy WhatsApp 2.11.431"
    adb install -r -d "$LegacyFile"

    # Perform commands in the temporary directory.
    cd "$TEMPORARY"
    #cd tmp

    # Get backup file.
    [[ -f "$whatsappFile" ]] || adb backup -f "$whatsappFile" -noapk "$whatsappNamespace"

    # Uncompress, unpack backup file.
    dd if="$whatsappFile" bs=1 skip=24 | python -c "import zlib,sys;sys.stdout.write(zlib.decompress(sys.stdin.read()))" | tar x

    # Create an output directory for unencrypted databases.
    mkdir -p "$outputDirectory"

    # Extract key, unencrypted message and contacts databases.
    cp "apps/$whatsappNamespace/f/key" "$outputDirectory/whatsapp.key"
    cp "apps/$whatsappNamespace/db/msgstore.db" "$outputDirectory"
    cp "apps/$whatsappNamespace/db/wa.db" "$outputDirectory"

    # Push the decryption key to the device.
    adb push "apps/$whatsappNamespace/f/key" "/sdcard/WhatsApp/Databases/.nomedia"

    echo Updating WhatsApp
    adb install -r -d "$NewFile"

    echo Consider a Paypal donation to abinashbishoyi@gmail.com
  )
)
