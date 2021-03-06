#
## source code path settings
#

prjname="PRJ__PASTOR2GO"
prjpath="pi@192.168.1.49:/home/pi/usbdrv/" $prjname ".git"
libpath_mailbot="pi@192.168.1.49:/home/pi/usbdrv/_python/LIB__mailbot.git"
libpath_freeplane="pi@192.168.1.49:/home/pi/usbdrv/_python/LIB__freeplane_api.git"
apppath_dropbox="https://github.com/andreafabrizi/Dropbox-Uploader.git"

# move into Python v2 virtual environment
workon $sPython2venv




#
## get and prepare project files
#

# get source code
git clone $prjpath $HOME/$prjname

# move into project folder
cd $HOME/$prjname

# prepare executable application (neccessity of click module)
pip install --editable .

# create temporary project folder
mkdir $HOME/.$prjname




#
## get relevant packages
#

# libffi-dev
sudo apt-get -qq install libffi-dev   # required for mailbot module




#
## get and install relevant python modules from source
# other modules are handled from within the project's setup.py

# pyzmail
# click



#
## get mailbot plugin from source
#

# get source
git clone $libpath_mailbot $HOME/LIB__mailbot

# build mailbot into paython packages
cd $HOME/LIB__mailbot
python setup.py install




#
## get freeplane api
#

# get source
git clone $libpath_freeplane $HOME/LIB__freeplane_api

# get dependencies
pip install html2text

# build freeplane api into python packages
cd $HOME/LIB__freeplane_api
python setup.py install




#
## get relevant applications
#

# dropbox uploader
git clone $apppath_dropbox $HOME/APP__dropbox_uploader




# deactivate virtual environment
deactivate

