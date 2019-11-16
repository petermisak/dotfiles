# disable fish greeting message
function fish_greeting; end

# MacPorts
set -xg PATH /opt/local/bin /opt/local/sbin $PATH

# vscode
set -xg PATH "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" $PATH

# Path to node global (the dir was created manually by mkdir ~/.npm-global ;  npm config set prefix '~/.npm-global')
set -xg PATH ~/.npm-global/bin $PATH

# Locale fix
set -xg LC_CTYPE en_US.UTF-8

# Enable Starship Prompt
eval (starship init fish)

