#!/usr/bin/env bash
# -----------------------------------------------------------------------------------
# Auth   : Freeman
# Email  : flo@radford.edu
# DESC   : Silent delete Tool for MAC_OSX Python
#        : 
# Date   : 2023.10.02
# -----------------------------------------------------------------------------------

# Uninstall Python 3.11 for Mac
echo "Uninstalling Python 3.11.x for Mac... \n"

cd
rm -fr ./Library/Python
echo "Required Administrator Password for the following. \n"
sudo rm -fr /Library/Frameworks/Python.framework/
sudo rm -fr /Applications/Python\ 3.11/

echo "Finished python Uninstallation process.\n\n"
