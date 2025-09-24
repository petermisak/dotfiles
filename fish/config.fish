. ~/.config/fish/aliases.fish

# disable fish greeting message
function fish_greeting
end

# Fix the locales
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF8

# Default editor Vim
set -xg EDITOR nvim

set HOMEBREW_HOME /usr/local
if test -d /opt/homebrew
    set HOMEBREW_HOME /opt/homebrew
    set -xg PATH $HOMEBREW_HOME/bin $HOMEBREW_HOME/sbin $PATH
end

# Homebrew Python
set -xg PATH /usr/local/opt/python/libexec/bin $PATH

# Go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# Kubernetes
set -x KUBECONFIG $HOME/.kube/config

# Path to node global (the dir was created manually by mkdir ~/.npm-global ;  npm config set prefix '~/.npm-global')
set -xg PATH ~/.npm-global/bin $PATH

# pyenv
if test -d ~/.pyenv/shims
    set -xg PATH ~/.pyenv/shims $PATH
end

# n
set -xg N_PREFIX $HOME/n
set -xg PATH $HOME/n/bin $PATH

# Cargo
set -xg PATH $HOME/.cargo/bin $PATH

# User scripts & Lunar
set -xg PATH $HOME/bin $PATH
set -xg PATH $HOME/.local/bin $PATH

# bat
set -xg BAT_THEME OneHalfLight

# Fish completions for Homebrew, as we're using Macports' fish
if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# 1password completions
op completion fish | source

# Fish syntax highlighting
# scheme set default

set -g fish_pager_color_prefix black --bold --underline

function _gen_fzf_default_opts
    set color00 '#1B2B34'
    set color01 '#343D46'
    set color02 '#4F5B66'
    set color03 '#65737E'
    set color04 '#A7ADBA'
    set color05 '#C0C5CE'
    set color06 '#CDD3DE'
    set color07 '#D8DEE9'
    set color08 '#EC5f67'
    set color09 '#F99157'
    set color0A '#FAC863'
    set color0B '#99C794'
    set color0C '#5FB3B3'
    set color0D '#6699CC'
    set color0E '#C594C5'
    set color0F '#AB7967'

    echo "--black
  --height 40%
  --color=bg+:$color00,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
end

# Colored man pages
set -x LESS_TERMCAP_mb (printf "\e[01;31m")
set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")

# set -xg FZF_DEFAULT_OPTS (_gen_fzf_default_opts)
set -xg FZF_DEFAULT_OPTS --height 40% --color light
#set -xg FZF_DEFAULT_OPTS --height 40% --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229,info:150,prompt:110,spinner:150,pointer:167,marker:174

# exa/eza colors
set -x EXA_COLORS "uu=0:gu=0:ur=0:uw=0:ux=0:ue=0:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0"

starship init fish | source
