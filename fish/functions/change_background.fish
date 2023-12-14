function change_background --argument mode_setting
    echo "Setting background to $mode_setting"
    set -l mode light
    switch $mode_setting
        case light
            yes | fish_config theme save "Snow Day"
            git config --global delta.syntax-theme OneHalfLight
            set mode light
        case dark
            yes | fish_config theme save "Catppuccin Macchiato"
            git config --global delta.syntax-theme "Sublime Snazzy"
            set mode dark
    end
end
