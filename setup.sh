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

sudo port install vim +huge +python37
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
git config --global core.pager "delta"
git config --global delta.features "decorations line-numbers"
git config --global delta.syntax-theme "OneHalfLight"
git config --global color.diff.commit red
git config --global pull.rebase false

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

ln -sf $(pwd)/starship/starship.toml "$HOME/.config/starship.toml"

# Some Docker and K8s goodies
fish -c "fisher add barnybug/docker-fish-completion"
fish -c "fisher add evanlucas/fish-kubectl-completions"
fish -c "fisher add DrPhil/kubectl-fish-abbr"

code --install-extension ccy.ayu-adaptive
code --install-extension ms-azuretools.vscode-docker
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension vscode-icons-team.vscode-icons
code --install-extension skyapps.fish-vscode
code --install-extension eamodio.gitlens
code --install-extension humao.rest-client
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension mhookyqr.beautify
code --install-extension k--kato.intellij-idea-keybindings
code --install-extension 42crunch.vscode-openapi

ln -sf $(pwd)/prefs/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

sdk install java $JAVA_VERSION
sdk install maven

sudo port install nodejs12 npm6

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
sudo chown -R $USER /opt/local/lib/node_modules

npm install -g n
mkdir ~/n

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install starship
brew install azure-cli
brew install git-delta
brew install watch
brew install exa

# Fira Code font
brew tap homebrew/cask-fonts
brew cask install font-fira-code

# JetBrains Mono font
brew tap homebrew/cask-fonts
brew cask install font-jetbrains-mono
brew install font-jetbrains-mono-nerd-font

# Kubelogin
brew install int128/kubelogin/kubelogin

# Helm
brew install helm
# I need Helm-2.14 in particular, so I need to use MacPorts
sudo port install helm-2.14

# Some additional goodies
brew install speedtest-cli
brew install neofetch
brew install ctop lazydocker
brew install stern

cd /usr/local/bin
ln -s helm helm3

# AWS
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
rm AWSCLIV2.pkg

brew tap weaveworks/tap
brew install weaveworks/tap/eksctl

