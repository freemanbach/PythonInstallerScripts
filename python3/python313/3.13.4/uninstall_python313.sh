#!/usr/bin/env bash
# -----------------------------------------------------------------------------------
# Auth   : Freeman
# Email  : flo@radford.edu
# DESC   : Silent Uninstall Tool for MAC_OSX Python
# Date   : 20250604
# -----------------------------------------------------------------------------------
echo "\n"
echo "BECAREFUL: This will delete Python version 3.13.x  "
echo "BECAREFUL: Press CTRL-C NOW when in doubt !!!!     "
echo "BECAREFUL: yet, it will leave some files undeleted."
echo "\n"
# -----------------------------------------------------------------------------------
# Uninstall Python 3.13 for Mac
echo "Uninstalling Python 3.13.x for Mac...\n"
cd
rm -fr ./Library/Python/3.13
echo "Required Administrator Password for the following. \n"
sudo rm -fr /Library/Frameworks/Python.framework/Versions/3.13
sudo rm -fr /Applications/Python\ 3.13
# -----------------------------------------------------------------------------------
echo "\n"
echo "Finished Uninstallation Python 3.13.x\n\n"
