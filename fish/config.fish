if status is-interactive
  set fish_greeting ''
end

if test "$TERM" = "linux"
  setfont /usr/share/kbd/consolefonts/ter-22b.psf.gz
    echo -en "\e]P0141617" #black
    echo -en "\e]P8282828" #darkgrey
    echo -en "\e]P1ea6962" #darkred
    echo -en "\e]P9ea6962" #red
    echo -en "\e]P2a9b665" #darkgreen
    echo -en "\e]PAa9b665" #green
    echo -en "\e]P3d8a657" #darkyellow
    echo -en "\e]PBd8a657" #yellow
    echo -en "\e]P47daea3" #darkblue
    echo -en "\e]PC7daea3" #blue
    echo -en "\e]P5d3869b" #darkmagen4ta
    echo -en "\e]PDd3869b" #magenta
    echo -en "\e]P689b482" #darkcyan
    echo -en "\e]PE89b482" #cyan
    echo -en "\e]P7d4be98" #lightgrey
    echo -en "\e]PFd4be98" #white
    clear #for background artifacting
    echo -en "\e[H\e[2J"
end

function fish_command_not_found
    echo fish: $argv[1]: command not found
end


alias ll "eza -lah --color=always --group-directories-first -F --icons=always"
alias ls "eza --group-directories-first -F -a --color=always --icons=always"
alias llnu "nu --commands 'ls'"
export QT_QPA_PLATFORMTHEME=gtk2
export GTK_THEME=Dracula
export _JAVA_AWT_WM_NONREPARENTING=1
alias files "fzf --preview='cat {}' | xargs nvim"
set JAVA_HOME "/usr/lib/jvm/java-22-openjdk"
set _JAVA_OPTIONS "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
set -U fish_user_paths $JAVA_HOME/bin $fish_user_paths
set -U fish_user_paths /tools/Xilinx/Vivado/2019.1/bin $fish_user_paths
set XILINXD_LICENSE_FILE "2100@192.168.1.70"
set WINEARCH win32
set WINEPREFIX ~/.wine32
set GALLIUM_HUD "fps+temperature+cpu+memory-clock+VRAM-usage"

bind \ef accept-autosuggestion


set -U fish_color_autosuggestion "#33384d"

function aur
  xdg-open "https://aur.archlinux.org/'$1'"
end

function foo
  cd /home/adi/AUR && git clone https://aur.archlinux.org/$argv && cd $argv && makepkg -si && cd
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/adi/.ghcup/bin # ghcup-env

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/adi/.opam/opam-init/init.fish' && source '/home/adi/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
