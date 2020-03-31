# disable fish greeting message
function fish_greeting; end

# Fix the locales
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF8

# Macports
set -xg PATH /opt/local/bin /opt/local/sbin $PATH

# Homebrew Python
set -xg PATH /usr/local/opt/python/libexec/bin $PATH

# Go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# Kubernetes
set -x KUBECONFIG $HOME/.kube/config $KUBECONFIG

# Path to node global (the dir was created manually by mkdir ~/.npm-global ;  npm config set prefix '~/.npm-global')
set -xg PATH ~/.npm-global/bin $PATH

# Cargo  
set -xg PATH $HOME/.cargo/bin $PATH

# User scripts
set -xg PATH $HOME/bin $PATH

eval (starship init fish)

# Base16 Shell
eval sh $HOME/.config/oceanic-next-shell/oceanic-next.dark.sh

