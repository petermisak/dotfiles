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
set -x KUBECONFIG $HOME/.kube/config

# Path to node global (the dir was created manually by mkdir ~/.npm-global ;  npm config set prefix '~/.npm-global')
set -xg PATH ~/.npm-global/bin $PATH

# Cargo
set -xg PATH $HOME/.cargo/bin $PATH

# User scripts
set -xg PATH $HOME/bin $PATH

# Base16 Shell
# eval sh $HOME/.config/oceanic-next-shell/oceanic-next.dark.sh

# Base16 OceanicNext
# Author: https://github.com/voronianski/oceanic-next-color-scheme

# Fish syntax highlighting
#set -g fish_color_autosuggestion '555'  'brblack'
#set -g fish_color_cancel -r
#set -g fish_color_command --bold
#set -g fish_color_comment red
#set -g fish_color_cwd green
#set -g fish_color_cwd_root red
#set -g fish_color_end brmagenta
#set -g fish_color_error brred
#set -g fish_color_escape 'bryellow'  '--bold'
#set -g fish_color_history_current --bold
#set -g fish_color_host normal
#set -g fish_color_match --background=brblue
#set -g fish_color_normal normal
#set -g fish_color_operator bryellow
#set -g fish_color_param cyan
#set -g fish_color_quote yellow
#set -g fish_color_redirection brblue
#set -g fish_color_search_match 'bryellow'  '--background=brblack'
#set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
#set -g fish_color_user brgreen
#set -g fish_color_valid_path --underline

set -g fish_color_search_match 'black'  '--background=d8dbda'
set -g fish_pager_color_prefix 'black' '--bold' '--underline'

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
# set -xg FZF_DEFAULT_OPTS --height 40% --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229,info:150,prompt:110,spinner:150,pointer:167,marker:174
function pcp_on -d "Set PCP kubeconfig"
    set PCP_KUBECONFIG "$HOME/.kube/pcp.config"

    if not test -z "$PCP_KUBECONFIG"; and not string match -q "*$PCP_KUBECONFIG*" $KUBECONFIG
        set -xg KUBECONFIG $KUBECONFIG:$PCP_KUBECONFIG
    end
end

function pcp_off -d "Unset PCP kubeconfig"
    set PCP_KUBECONFIG "$HOME/.kube/pcp.config"

    if not test -z "$PCP_KUBECONFIG"; and string match -q "*$PCP_KUBECONFIG*" $KUBECONFIG
        set -xg KUBECONFIG (string replace -r "\:$PCP_KUBECONFIG" "" -- $KUBECONFIG)
    end
end

starship init fish | source
