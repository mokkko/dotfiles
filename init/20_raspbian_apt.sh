#
## check for execution permission
#

is_raspbian || return 1




#
## update and upgrade packages
#

e_header "Updating APT"
sudo apt-get -qq update
sudo apt-get -qq dist-upgrade




#
## install hardware
#

#sudo apt-get install rpi-update
#sudo rpi-update
#sudo reboot




#
## install necessary packages
#

# define packages
packages=(
  build-essential
  libncursesw5-dev
  libgdbm-dev
  libc6-dev
  zlib1g-dev
  libsqlite3-dev
  tk-dev
  libssl-dev
  openssl
  git-core
  htop
  nmap
  tree
)

# 
packages=($(setdiff "${packages[*]}" "$(dpkg --get-selections | grep -v deinstall | awk '{print $1}')"))

# install using apt-get
if (( ${#packages[@]} > 0 )); then
  e_header "Installing APT packages: ${packages[*]}"
  for package in "${packages[@]}"; do
    sudo apt-get -qq install "$package"
  done
fi
