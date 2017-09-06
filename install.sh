#!/bin/bash -x

# To load unsigned kexts, disable System Integrity Protection
# https://developer.apple.com/library/content/documentation/Security/Conceptual/System_Integrity_Protection_Guide/ConfiguringSystemIntegrityProtection/ConfiguringSystemIntegrityProtection.html#//apple_ref/doc/uid/TP40016462-CH5-SW1
#  To enable or disable System Integrity Protection, you must boot to Recovery OS and run the csrutil(1) command from the Terminal.
# 
# Boot to Recovery OS by restarting your machine and holding down the Command and R keys at startup.
# Launch Terminal from the Utilities menu.
# Enter the following command:
# $ csrutil enable
 

KEXT=IOVideoSample.kext
PLUGIN=Insta360VCam.plugin
MODE=Release
PLIST=com.insta360.cmio.DPA.Assistant.plist

sudo rm -rf /Library/Extensions/$KEXT
sudo cp -a ./BuildResults/$MODE/root/System/Library/Extensions/$KEXT /Library/Extensions/
sudo rm -rf /Library/CoreMediaIO/Plug-Ins/DAL/$PLUGIN 
sudo cp -a ./BuildResults/$MODE/root/Library/CoreMediaIO/Plug-Ins/DAL/$PLUGIN /Library/CoreMediaIO/Plug-Ins/DAL
sudo rm /Library/LaunchDaemons/$PLIST
sudo cp ./BuildResults/$MODE/root/Library/LaunchDaemons/$PLIST /Library/LaunchDaemons/

sudo chown -R root:wheel /Library/Extensions/$KEXT
sudo chown -R root:wheel /Library/CoreMediaIO/Plug-Ins/DAL/$PLUGIN

sudo kextunload /Library/Extensions/$KEXT
sudo kextload /Library/Extensions/$KEXT
