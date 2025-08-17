# Auth   : Freeman
# Email  : flo@radford.edu
# DESC   : Silent Installer for MAC_OSX python installer
#        : for version 3.13.7
# Date   : 20250817
################################

################################
# Change Directory
cd $HOME/Downloads
################################

################################
# Download this file for MAC_OSX
curl -C - -O https://www.python.org/ftp/python/3.13.7/python-3.13.7-macos11.pkg 
################################

################################
# There isnt a pkg installer file for *JUST* M1/M2/M3 CPUs from the Python Community
# They provided a UNIVERSAL package installer for both Intel/AMD (x86_64/x86) + ARM(M1/M2)
# https://www.python.org/downloads/release/python-3121/
################################

###############################
# install Python Software
echo "Enter in your normal login password, when prompted !"
sudo installer -verboseR -pkg python-3.13.7-macos11.pkg -target /Applications
###############################

###############################
# Install Certificates
/Applications/Python\ 3.13/Install\ Certificates.command
###############################

##############################
# Update pip
/Library/Frameworks/Python.framework/Versions/3.13/bin/python3 -m pip install --upgrade pip
##############################

#***NOTE***#
##############################
# Python3 and pip3 are both installed in the /Library/Frameworks/Python.framework location and not in /usr/bin
# probably not going to create an alias, since it might over write the native MacOS pythonv2.7 software which can be a bad thing. 
##############################

#############################
# Download custom .bashrc file from Repo
cd $HOME
#curl -C - -O https://raw.githubusercontent.com/freemanbach/Python/master/python3/installscript/.profile
#curl -C - -O https://raw.githubusercontent.com/freemanbach/Python/master/python3/installscript/.bashrc
############################

#############################
# install Packages
#############################
/Library/Frameworks/Python.framework/Versions/3.13/bin/python3 -m pip install --user wheel scrapy
/Library/Frameworks/Python.framework/Versions/3.13/bin/python3 -m pip install --user pipx
/Library/Frameworks/Python.framework/Versions/3.13/bin/python3 -m pip install --user pandas polars matplotlib
/Library/Frameworks/Python.framework/Versions/3.13/bin/python3 -m pip install --user scikit-learn
##############################

#############################
# Printing version
#############################
/Library/Frameworks/Python.framework/Versions/3.13/bin/python3 -c "import sys; print(sys.executable)"
/Library/Frameworks/Python.framework/Versions/3.13/bin/python3 -V
echo "DONE."
