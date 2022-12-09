# Auth   : Freeman
# Email  : flo@radford.edu
# DESC   : Silent Installer for MAC_OSX python installer
#        : for version 3.10.6
# Date   : 2022.12.09
################################

################################
# Change Directory
cd $HOME/Downloads
################################

################################
# Download this file for MAC_OSX
curl -C - -O https://www.python.org/ftp/python/3.10.6/python-3.10.6-macos11.pkg 
################################

###############################
# install Python Software
echo "Enter in your normal login password, when prompted !"
sudo installer -verboseR -pkg python-3.10.6-macos11.pkg -target /Applications
###############################

###############################
# Install Certificates
/Applications/Python\ 3.10/Install\ Certificates.command
###############################

##############################
# Update pip
/Library/Frameworks/Python.framework/Versions/3.10/bin/python3 -m pip install --upgrade pip
##############################

#***NOTE***#
##############################
# Python3 and pip3 are both installed in the /Library/Frameworks/Python.framework location and not in /usr/bin
# probably not going to create an alias, since it might over write the native MacOS pythonv2.7 software which can be a bad thing. 
##############################

#############################
# Download custom .bashrc file from Repo
cd $HOME
curl -C - -O https://raw.githubusercontent.com/freemanbach/Python/master/python3/installscript/.profile
curl -C - -O https://raw.githubusercontent.com/freemanbach/Python/master/python3/installscript/.bashrc
############################

#############################
# install Finance Packages
#############################
/Library/Frameworks/Python.framework/Versions/3.10/bin/python3 -m pip install --user wheel scrapy
/Library/Frameworks/Python.framework/Versions/3.10/bin/python3 -m pip install --user pandas_datareader requests ta scipy numpy plotly
/Library/Frameworks/Python.framework/Versions/3.10/bin/python3 -m pip install --user pandas matplotlib
/Library/Frameworks/Python.framework/Versions/3.10/bin/python3 -m pip install --user wikipedia wordcloud
#
##############################
# Cant get some of these installed without XCode
# python3 -m pip install --user SOFTWARE
# /usr/local/bin/pip3 install --user pymc3 scikit-learn yfinance statsmodels zipline pyfolio
# /usr/local/bin/pip3 install --user pyfin vollib quantpy ffn tia pynance mplfinance plotly yahoo_fin 
# /usr/local/bin/pip3 install --user vaderSentiment xlsxwriter xlrd openpyxl
# /usr/local/bin/pip3 install --user quandl tqdm
##############################

#############################
# Creating directories
#############################
# mkdir -p ~/itec109/{labs,hws}
/Library/Frameworks/Python.framework/Versions/3.10/bin/python3 -V
echo "DONE."
