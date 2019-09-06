#!/usr/bin/env bash

sudo -v

echo Confinguring defaults

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → Sleep
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 3
defaults write com.apple.dock wvous-br-modifier -int 0

echo "Configuring dev tools"

set -e

if [[ $(xcode-select --version) ]]; then
    echo "Xcode command tools already installed"
else
    echo "Installing Xcode command line tools"
    $(xcode-select --install)
fi

sudo xcodebuild -license accept

sudo port selfupdate

sudo port install git +credential_osxkeychain+doc+diff_highlight

sudo port install vim
git clone https://github.com/petermisak/.vim.git ~/.vim-mine
ln -sf ~/.vim-mine ~/.vim
ln -sf $HOME/.vim/vimrc $HOME/.vimrc
cd $HOME/.vim
git submodule update --init
cd -

echo "Installing fish shell"

sudo port install fish
sudo chpass -s /opt/local/bin/fish ${USER}
sudo sh -c 'echo /opt/local/bin/fish >> /etc/shells'

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
