if status is-interactive
    set fish_greeting ''
end

function fish_command_not_found
    echo fish: $argv[1]: command not found
end

# alias nvim="~/nvim-macos-arm64/bin/nvim"
alias ls="eza --color=always --icons=always -s modified"
export LANG=en_US.UTF-8
export ANI_CLI_PLAYER=mpv
export XILINXD_LICENSE_FILE=2100@192.168.1.70.
export EDITOR=vim
export PSPDEV=/opt/pspdev/
export PSPSDK=$PSPDEV/psp/sdk

export GTK_THEME=Flat-Remix-GTK-Magenta-Dark-Solid
export MOZ_USE_XINPUT2=1

function wall
    swaybg -o "*" -i $argv[1] -m fill &
end

set -U fish_color_autosuggestion "#181818"

# echo "Week 3/13"

# uv
fish_add_path "/home/adi/.local/bin"
