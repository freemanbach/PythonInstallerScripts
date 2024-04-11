#!/usr/bin/env bash
# -----------------------------------------------------------------------------------
# Auth   : Freeman
# Email  : flo@radford.edu
# DESC   : Silent updating Tool for MAC_OSX Python
#        : 
# Date   : 2024.04.10
# -----------------------------------------------------------------------------------

# Update Python 3.11 on Mac
echo "Updating Python 3.11.x for Mac..."
echo "\n"

# send user back to $HOME first
cd

echo "Required Administrator Password for the following updates. "
echo "\n"
DATA=/Library/Frameworks/Python.framework/Versions/3.11/bin/python3
if [[ -f "$DATA" ]]; then
    echo "Starting to update to new version of pip.\n "
    sudo /Library/Frameworks/Python.framework/Versions/3.11/bin/python3 -m pip install --upgrade pip
    # write out the python packages to a file then upgrade them individually
    sudo /Library/Frameworks/Python.framework/Versions/3.11/bin/pip3 freeze > req.txt
    sudo /Library/Frameworks/Python.framework/Versions/3.11/bin/pip3 install -r req.txt --upgrade
    # Delete req.txt file
    echo "deleting the req file. \n"
    sudo rm -f req.txt
else
    echo "python3 file was not found in the data location.\n"
    exit 1
fi

echo "Finished Updating python Tools. \n\n"
