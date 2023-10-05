#!/bin/sh

# Auth   : Freeman
# Email  : flo@radford.edu
# DESC   : Silent updating Tool for MAC_OSX Python
#        : 
# Date   : 2023.10.02
################################

# Uninstall Python 3.11 for Mac
echo "Updating Python 3.11.x for Mac..."

# send user back to $HOME first
cd

DATA=/Library/Frameworks/Python.framework/Versions/3.11/bin/python3
if [[ -f "$DATA" ]]; then
    echo "Starting to update to new version of pip.\n "
    /Library/Frameworks/Python.framework/Versions/3.11/bin/python3 -m pip install --upgrade pip
    # write out the python packages to a file then upgrade them individually
    /Library/Frameworks/Python.framework/Versions/3.11/bin/pip3 freeze > req.txt
    /Library/Frameworks/Python.framework/Versions/3.11/bin/pip3 install -r req.txt --upgrade
    # Delete req.txt file
    echo "deleting the req file. \n"
    rm -f req.txt
else
    echo "python3 file was not found in the data location.\n"
    exit 1
fi

echo "Finished Updating python Tools. \n"