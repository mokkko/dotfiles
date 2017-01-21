# path settings
sPluginBasePath=$HOME/.tmux/plugins
sTmuxConfigPath=$HOME/.tmux.conf




#
## get plugins
#

e_header "Installing and Configuring Tmux Plugins"

# define plugin locations
lstPluginUrl=(
  https://github.com/tmux-plugins/tpm.git
  https://github.com/tmux-plugins/tmux-resurrect.git
  https://github.com/tmux-plugins/tmux-copycat.git
)

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

# create configuration file
echo '# List of plugins' > $sTmuxConfigPath

# using each plugin name...
for sName in ${lstPluginName[@]}; do

    # for each listed url...
    for sUrl in ${lstPluginUrl[@]}; do

        # check if name is contained in url
        if [[ "$sUrl" == *"$sName"* ]]; then

            e_header "... " $sName

            # do the download
            git clone $sUrl $sPluginBasePath/$sName

            # insert plugin name into configuration
            echo "set -g @plugin 'tmux-plugins/$sName'" >> $sTmuxConfigPath

            # proceed with next plugin name
            break

        fi

    done

done

# create ending line in configuration file
echo "" >> $sTmuxConfigPath
echo "# Initialize tmux plugin manager" >> $sTmuxConfigPath
echo "run '$sPluginBasePath/tpm/tpm'" >> $sTmuxConfigPath

