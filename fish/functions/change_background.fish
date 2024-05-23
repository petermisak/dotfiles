function change_background --argument mode_setting
    echo "Setting background to $mode_setting"
    set -l mode light
    switch $mode_setting
        case light
            # yes | fish_config theme save "Snow Day"
            # yes | fish_config theme save Tomorrow
            #yes | fish_config theme save "Catppuccin Latte"
            yes | fish_config theme save "Rosé Pine Dawn"
            git config --global delta.syntax-theme OneHalfLight
            set mode light
        case dark
            #yes | fish_config theme save "Catppuccin Macchiato"
            # yes | fish_config theme save "Rosé Pine Moon"
            yes | fish_config theme save "Rosé Pine"
            git config --global delta.syntax-theme zenburn
            set mode dark
    end
end
