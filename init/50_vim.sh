# path settings
sPluginBasePath=$HOME/.vim/bundle # for pathogen plugin management
sVimSourceUrl=https://github.com/vim/vim.git




#
## install vim from source
#

# only install if not already installed
#if [[ ! "$(type -P vim)" ]]; then

    e_header "Installing Vim from source"

    # get the necessary packages
    sudo apt-get install libncurses5-dev python-dev -y

    # remove already existing packages if present
    sudo apt-get remove vim vim-tiny vim-common vim-runtime

    # get the sources
    cd /tmp
    git clone $sVimSourceUrl
    cd vim

    # configure and compile any newest version into general folder
    ./configure --with-features=huge --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config --prefix=/usr
    #make VIMRUNTIMEDIR=/usr/share/vim/vim74
    make VIMRUNTIME=/usr/share/vim
    sudo make install

#fi




#
## get plugins
#

e_header "Installing Vim Plugins"

# define plugin locations
lstPluginUrl=(
  https://github.com/xolox/vim-misc.git
  https://github.com/MarcWeber/vim-addon-mw-utils.git
  https://github.com/vim-airline/vim-airline.git
  https://github.com/pseewald/vim-anyfold
  https://github.com/wincent/command-t.git
  https://github.com/tpope/vim-fugitive.git
  https://github.com/fidian/hexmode.git
  https://github.com/scrooloose/nerdcommenter.git
  https://github.com/scrooloose/nerdtree.git
  https://github.com/xolox/vim-session.git
  https://github.com/ycm-core/YouCompleteMe.git
)
#https://github.com/tmhedberg/simpylfold.git
#https://github.com/klen/python-mode.git

# strip plugin names from path
lstPluginName=""
for item in "${lstPluginUrl[@]}"; do
    sPluginName=$(basename $item)
    lstPluginName=(${lstPluginName[@]} "${sPluginName%%.*}")
done

# determine names of installed plugins if plugin folder already exists
if [[ -d $sPluginBasePath ]]; then

    # get path of plugins which have already been installed
    lstPluginPath_installed="$sPluginBasePath"/*

    # filter plugin names from path list
    lstPluginName_installed=""
    for item in ${lstPluginPath_installed[@]}; do

        sPluginName=$(basename $item)
        lstPluginName_installed=(${lstPluginName_installed[@]} "${sPluginName}")

    done

    # get only plugin names which are not already installed
    lstPluginName=($(setdiff "${lstPluginName[*]}" "${lstPluginName_installed[*]}"))

fi

## using each plugin name...
for sName in ${lstPluginName[@]}; do

    # for each listed url...
    for sUrl in ${lstPluginUrl[@]}; do

        # check if name is contained in url
        if [[ "$sUrl" == *"$sName"* ]]; then

            e_header "... " $sName

            # do the download
            git clone $sUrl $sPluginBasePath/$sName

            # proceed with next plugin name
            break

        fi

    done

done




#
## set configurations
#

e_header "Configuring Vim"

# python mode
#... deactivate...

