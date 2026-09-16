if status is-interactive
    set fish_greeting ''
end

function fish_command_not_found
    echo fish: $argv[1]: command not found
end

# alias nvim="~/nvim-macos-arm64/bin/nvim"
alias ls="eza --color=always --icons=always"
export LANG=en_US.UTF-8
export ANI_CLI_PLAYER=mpv
export XILINXD_LICENSE_FILE=2100@192.168.1.70.
export EDITOR=vim
export PSPDEV=/opt/pspdev/
export PSPSDK=$PSPDEV/psp/sdk

export GTK_THEME=Flat-Remix-GTK-Magenta-Dark-Solid
export MOZ_USE_XINPUT2=1

set -U fish_color_autosuggestion "#1f202e"

# echo "Week 3/13"
