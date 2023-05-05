#!/bin/sh

# Auth   : Freeman
# Email  : flo@radford.edu
# DESC   : Silent delete Tool for MAC_OSX Python
#        : 
# Date   : 2023.05.04
################################

# Uninstall Python 3.10 for Mac
echo "Uninstalling Python 3.x.x for Mac..."

cd
rm -fr ./Library/Python
echo "Required Administrator Password for the following. "
sudo rm -fr /Library/Frameworks/Python.framework/
sudo rm -fr /Applications/Python\ 3.10/

echo "Finished python Uninstallation process."
