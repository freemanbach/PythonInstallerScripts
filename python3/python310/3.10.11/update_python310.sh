#!/bin/sh

# Auth   : Freeman
# Email  : flo@radford.edu
# DESC   : Silent updating Tool for MAC_OSX Python
#        : 
# Date   : 2023.05.04
################################

# Uninstall Python 3.10 for Mac
echo "Updating Python 3.10.x for Mac..."

cd
# updating pip
/Library/Frameworks/Python.framework/Versions/3.10/bin/python3 -m pip install --upgrade pip
# write out the python packages to a file then upgrade them individually
/Library/Frameworks/Python.framework/Versions/3.10/bin/pip3 freeze > req.txt
/Library/Frameworks/Python.framework/Versions/3.10/bin/pip3 install -r req.txt --upgrade

# delete the req file
rm -f req.txt

echo "Finished Updating python Tools."
