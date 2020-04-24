#!/usr/bin/env bash

JAVA_VERSION="8.0.222-zulu"

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
sudo port install bash
sudo port install fzf

sudo port install vim
git clone https://github.com/petermisak/.vim.git ~/.vim-mine
ln -sf ~/.vim-mine ~/.vim
ln -sf $HOME/.vim/vimrc $HOME/.vimrc
cd $HOME/.vim
git submodule update --init
cd -

git clone https://github.com/mhartington/oceanic-next-shell.git ~/.config/oceanic-next-shell

ln -sf $(pwd)/git/.gitaliases $HOME/.gitaliases

git config --global include.path $HOME/.gitaliases
git config --global core.editor vim
git config --global color.ui auto
git config --global credential.helper osxkeychain
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

echo "Installing fish shell"

sudo port install fish
sudo chpass -s /opt/local/bin/fish ${USER}
sudo sh -c 'echo /opt/local/bin/fish >> /etc/shells'

# ln -sf $(pwd)/fish/functions "$HOME/.config/fish"
ln -sf $(pwd)/fish/config.fish "$HOME/.config/fish/config.fish"

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

fish -c "fisher add barnybug/docker-fish-completion"
fish -c "fisher add jethrokuan/fzf"
fish -c "fisher add jethrokuan/z"
fish -c "fisher add reitzig/sdkman-for-fish"
fish -c "fisher add edc/bass"
fish -c "fisher add jhillyerd/plugin-git"

# Some Docker and K8s goodies
fish -c "fisher add barnybug/docker-fish-completion"
fish -c "fisher add evanlucas/fish-kubectl-completions"

code --install-extension ccy.ayu-adaptive
code --install-extension ms-azuretools.vscode-docker
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension vscode-icons-team.vscode-icons
code --install-extension skyapps.fish-vscode

ln -sf $(pwd)/prefs/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

sdk install java $JAVA_VERSION
sdk install maven

sudo port install nodejs12 npm6

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
sudo chown -R $USER /opt/local/lib/node_modules

npm install -g n diff-so-fancy

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install starship
brew install azure-cli

# Fira Code font
brew tap homebrew/cask-fonts
brew cask install font-fira-code

# JetBrains Mono font
brew tap homebrew/cask-fonts
brew cask install font-jetbrains-mono

# Kubelogin
brew install int128/kubelogin/kubelogin

