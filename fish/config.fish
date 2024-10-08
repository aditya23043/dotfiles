if status is-interactive
  set fish_greeting ''
end

if test "$TERM" = "linux"
  setfont /usr/share/kbd/consolefonts/ter-p28b.psf.gz
end


alias ll "eza -lah --color=always --group-directories-first -F --icons=always"
alias ls "eza --group-directories-first -F -a --color=always --icons=always"
export QT_QPA_PLATFORMTHEME=gtk2
export GTK_THEME=Dracula
export _JAVA_AWT_WM_NONREPARENTING=1
alias aur "xdg-open https://aur.archlinux.org"
alias files "fzf --preview='cat {}' | xargs nvim"
set JAVA_HOME "/usr/lib/jvm/java-22-openjdk"
set _JAVA_OPTIONS "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
set -U fish_user_paths $JAVA_HOME/bin $fish_user_paths
set XILINXD_LICENSE_FILE "2100@192.168.1.70"

bind \ef accept-autosuggestion

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/adi/.ghcup/bin # ghcup-env

set -U fish_color_autosuggestion "#e4decd"